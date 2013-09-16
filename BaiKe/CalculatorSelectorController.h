//
//  CalculatorSelectorController.h
//  Anjuke
//
//  Created by omiyang on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NavigationController.h"
#import "RTBaseManager.h"

@interface CalculatorSelectorController :UIViewController<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, assign) NavigationController *delegate;
@property (nonatomic, assign) NSInteger type;
@property (nonatomic, retain) NSString *selectedValue;

@property (nonatomic, readonly) NSDictionary *data;
@end
