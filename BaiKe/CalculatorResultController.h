//
//  CalculatorResultController_iPhone.h
//  Anjuke
//
//  Created by omiyang on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalculatorManager.h"

@interface CalculatorResultController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *_data;
    NSArray *_labels;
    NSUInteger _payStyle;//1:等额本息; 2:等额本金;
    NSUInteger _type;//1:公积金; 2:商业贷款; 3:组合贷款;
}

@property (nonatomic, strong) NSArray *labels;
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, assign) NSUInteger payStyle;
@property (nonatomic, assign) NSUInteger type;
@property (retain, nonatomic) NSMutableDictionary *viewData;
@end
