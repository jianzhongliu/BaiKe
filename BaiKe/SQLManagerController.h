//
//  SQLManagerController.h
//  BaiKe
//
//  Created by yons on 13-8-1.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"
#import "FMDatabase.h"
@interface SQLManagerController : BaseViewController
{
    FMDatabase *db;
    UIButton *but;
}
@end
