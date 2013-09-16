//
//  RTBaseManager.h
//  Anjuke
//
//  Created by omiyang on 8/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTBaseManager : NSObject

@property (assign) id delegate;

@end

@interface NSArray (RTArray)

- (NSInteger)integerAtIndex:(NSInteger)index;
+ (NSArray *)arrayNamed:(NSString *)name;
- (id)safelyObjectAtIndex:(NSUInteger)index;

@end

@interface NSMutableArray (RTMutableArray)

- (void)addInteger:(NSInteger)integer;
- (id)safelyObjectAtIndex:(NSUInteger)index;
- (void)safelyAddObject:(id)object;

@end

@interface NSString (RTString)

- (CGSize)safelySizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size;

@end
