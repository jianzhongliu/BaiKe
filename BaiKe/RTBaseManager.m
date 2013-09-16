//
//  RTBaseManager.m
//  Anjuke
//
//  Created by omiyang on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RTBaseManager.h"

@implementation RTBaseManager

@synthesize delegate = _delegate;



@end

@implementation NSArray (RTArray)

- (NSInteger)integerAtIndex:(NSInteger)index
{
    NSNumber *number = [self safelyObjectAtIndex:index];
    return [number intValue];
}

+ (NSArray *)arrayNamed:(NSString *)name
{
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"plist"];
    return [NSArray arrayWithContentsOfFile:path];
}

- (id)safelyObjectAtIndex:(NSUInteger)index {
    if (self && [self isKindOfClass:[NSArray class]] &&self.count > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

//- (id)objectAtIndex:(NSUInteger)index {
//    if (self && self.count > index) {
//        return [self objectAtIndex:index];
//    }
//    return nil;
//}

@end
@implementation NSMutableArray (RTMutableArray)

- (void)addInteger:(NSInteger)integer
{
    NSNumber *number = [NSNumber numberWithInt:integer];
    [self safelyAddObject:number];
}

- (id)safelyObjectAtIndex:(NSUInteger)index {
    if (self &&[self isKindOfClass:[NSArray class]] && self.count > index) {
        return [self objectAtIndex:index];
    }
    return nil;
}

- (void)safelyAddObject:(id)object {
    if (self &&[self isKindOfClass:[NSArray class]] && object) {
        [self addObject:object];
    }
}

@end
@implementation NSString (RTString)

- (CGSize)safelySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size {
    if (self && self.length > 0) {
        return [self sizeWithFont:font constrainedToSize:size];
    }
    return CGSizeMake(0, 0);
}
@end