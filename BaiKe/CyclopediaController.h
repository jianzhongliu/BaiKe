//
//  CyclopediaController.h
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"
#import "DTCommont.h"
@interface CyclopediaController : BaseViewController <UITableViewDelegate ,UITableViewDataSource>{
    UITableView *myTable;
    NSMutableArray *myArray;
    NSMutableArray *myNameArrray;
}
@end
