//
//  QuestController.h
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"
#import "UIViewAdditions.h"
#import "DTCommont.h"
#import "CustomSegmentedControl.h"

@interface QuestController : BaseViewController <UITableViewDelegate, UITableViewDataSource, CustomSegmentedControlDelegate, UISearchBarDelegate>
{
    UITableView *myTable;
    NSMutableArray *myWordArray;
    CustomSegmentedControl *segmentedControl;
    NSDictionary * segmentDic;
}

@end
