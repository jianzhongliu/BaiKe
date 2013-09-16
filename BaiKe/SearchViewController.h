//
//  SearchViewController.h
//  BaiKe
//
//  Created by yons on 13-8-7.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"

@interface SearchViewController : BaseViewController <UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>
{
    UISearchBar *search;
    UITableView *myTable;
    NSMutableArray *myArray;
}
@end
