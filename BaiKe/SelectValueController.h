//
//  SelectValueController.h
//  BaiKe
//
//  Created by yons on 13-7-30.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SelectValuesDelegate <NSObject>

-(void)returnSelectedValues:(NSString *) value;

@end
@interface SelectValueController : UIViewController<UITableViewDataSource,UITableViewDelegate>
{
    id<SelectValuesDelegate> _delegate;
    UITableView *myTable;
    NSMutableArray *_myArray;
}
@property(strong , nonatomic)id<SelectValuesDelegate> delegate;
@property(strong , nonatomic )NSMutableArray *myArray;
@end
