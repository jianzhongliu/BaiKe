//
//  CalculatorManager.m
//  Anjuke
//
//  Created by omiyang on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CalculatorManager.h"

#define AJK_LOANRATE_PLIST @"AJKLoanRate.plist"
#define AJK_COMMERCIALRATE_PLIST @"AJKCommercialRate.plist"

@implementation CalculatorManager

- (NSArray *) calculator:(NSDictionary *)condition {
    NSMutableArray *result = [[NSMutableArray alloc] init] ;
    
    int type = [[condition objectForKey:@"type"] intValue];
    int payStyle = [[condition objectForKey:@"payStyle"] intValue];
    int gjj = [[condition objectForKey:@"gjj"] intValue];
    int biz = [[condition objectForKey:@"biz"] intValue];
    
    int month = [[condition objectForKey:@"year"] intValue] * 12;
    float percent = (float)[[condition objectForKey:@"ratePercent"] floatValue];
    float gjjRate = (float)[[self getRateByType:1 withMonth:month] floatValue] /100;
    float bizRate = (float)[[self getRateByType:2 withMonth:month] floatValue] * percent/100;
    
    //每月还款
    NSArray *monthlyPay;
    
    float payTotal;
    switch (type) {
        case 1:
            monthlyPay = [self getMonthlyPayStyle:payStyle money:gjj rate:gjjRate month:month];
            payTotal = [self getPayTotal:monthlyPay month:month];
            [result safelyAddObject:[NSNumber numberWithInt:gjj]];
            [result safelyAddObject:[NSNumber numberWithFloat:gjjRate*100]];
            [result safelyAddObject:[NSNumber numberWithFloat:payTotal]];
            [result safelyAddObject:[NSNumber numberWithFloat:payTotal-gjj]];
            [result safelyAddObject:[NSNumber numberWithInt:month]];
            if (payStyle == 1) {
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:0]];
            }
            else {
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:0]];
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:(month-1)]];
            }
            break;
        case 2:
            monthlyPay = [self getMonthlyPayStyle:payStyle money:biz rate:bizRate month:month];
            payTotal = [self getPayTotal:monthlyPay month:month];
            [result safelyAddObject:[NSNumber numberWithInt:biz]];
            [result safelyAddObject:[NSNumber numberWithFloat:bizRate*100]];
            [result safelyAddObject:[NSNumber numberWithFloat:payTotal]];
            [result safelyAddObject:[NSNumber numberWithFloat:payTotal-biz]];
            [result safelyAddObject:[NSNumber numberWithInt:month]];
            if (payStyle == 1) {
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:0]];                
            }
            else {
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:0]];
                [result safelyAddObject:[monthlyPay safelyObjectAtIndex:(month-1)]];
            }
            break;
        default:;
            NSArray *gjjMonthly = [self getMonthlyPayStyle:payStyle money:gjj rate:gjjRate month:month];
            float gjjTotal = [self getPayTotal:gjjMonthly month:month];
            NSArray *bizMonthly = [self getMonthlyPayStyle:payStyle money:biz rate:bizRate month:month];
            float bizTotal = [self getPayTotal:bizMonthly month:month];
            [result safelyAddObject:[NSNumber numberWithInt:gjj+biz]];
            [result safelyAddObject:[NSNumber numberWithFloat:gjjRate*100]];
            [result safelyAddObject:[NSNumber numberWithFloat:bizRate*100]];
            [result safelyAddObject:[NSNumber numberWithFloat:gjjTotal+bizTotal]];
            [result safelyAddObject:[NSNumber numberWithFloat:gjjTotal+bizTotal-gjj-biz]];
            [result safelyAddObject:[NSNumber numberWithInt:month]];
            if (payStyle == 1) {
                float gjjPay = [[gjjMonthly safelyObjectAtIndex:0] floatValue];
                float bizPay = [[bizMonthly safelyObjectAtIndex:0] floatValue];
                [result safelyAddObject:[NSNumber numberWithFloat:(gjjPay + bizPay)]];                
            }
            else {
                float gjjPayFirst = [[gjjMonthly safelyObjectAtIndex:0] floatValue];
                float bizPayFirst = [[bizMonthly safelyObjectAtIndex:0] floatValue];
                float gjjPaylast = [[gjjMonthly safelyObjectAtIndex:(month-1)] floatValue];
                float bizPaylast = [[bizMonthly safelyObjectAtIndex:(month-1)] floatValue];
                
                [result safelyAddObject:[NSNumber numberWithFloat:(gjjPayFirst + bizPayFirst)]];
                [result safelyAddObject:[NSNumber numberWithFloat:(gjjPaylast + bizPaylast)]];                
            }
            break;
    }
    
    return result;
}

- (NSString *)getRateByType:(NSInteger)paytype withMonth:(NSInteger)month {
    NSString *result = nil;
    switch (paytype) {
        case 1:
        {
            NSString *plistPath =[[NSBundle mainBundle] pathForResource:[AJK_LOANRATE_PLIST stringByDeletingPathExtension] ofType:[AJK_LOANRATE_PLIST pathExtension]];
            for (NSDictionary *r in [NSArray arrayWithContentsOfFile:plistPath]) {
//                [NSArray arrayWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:AJK_LOANRATE_PLIST]]
                if (month <= [[r objectForKey:@"month"] intValue]) {
                    result = [r objectForKey:@"rate"];
                    break;
                }
            }
        }
            break;
        case 2:
        {
            NSString *plistPath =[[NSBundle mainBundle] pathForResource:[AJK_COMMERCIALRATE_PLIST stringByDeletingPathExtension] ofType:[AJK_COMMERCIALRATE_PLIST pathExtension]];
            for (NSDictionary *r in [NSArray arrayWithContentsOfFile:plistPath]) {
//                [NSArray arrayWithContentsOfFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:AJK_COMMERCIALRATE_PLIST]]
                if (month <= [[r objectForKey:@"month"] intValue]) {
                    result = [r objectForKey:@"rate"];
                    
                    break;
                }
            }
        }
            break;
    }
    return result;
    
}

- (NSArray *)getMonthlyPayStyle:(int)style money:(int)money rate:(float)rate month:(int)month {
    NSMutableArray *result = [[NSMutableArray alloc] init] ;
    rate = rate/12;
    if(style==1){
        float pay = 10000*money*rate*pow((1+rate),month)/(pow((1+rate),month)-1);
        [result safelyAddObject:[NSNumber numberWithFloat:pay]];        
    }
    else{
        float first = (float)money/month;
        for(int i=0;i<month;i++){
            float pay = (first+(money-first*i)*rate)*10000;
            [result safelyAddObject:[NSNumber numberWithFloat:pay]];
        }
    }
    return result;
}

- (float)getPayTotal:(NSArray *)monthly month:(int)month{
    float total = 0;
    if (monthly.count > 1) {
        for (int i=0; i<monthly.count; i++) {
            total += [[monthly safelyObjectAtIndex:i] floatValue];
        }
    }
    else {
        total = [[monthly safelyObjectAtIndex:0] floatValue] * month;
    }
    
    return (float)total/10000;
}


@end
