//
//  CalculatorManager.h
//  Anjuke
//
//  Created by omiyang on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTBaseManager.h"

@interface CalculatorManager : RTBaseManager

- (NSArray *) calculator:(NSDictionary *)condition;

- (NSString *)getRateByType:(NSInteger)paytype withMonth:(NSInteger)month;

@end
