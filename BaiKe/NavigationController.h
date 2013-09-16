//
//  NavigationController.h
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"
#import "CalculatorManager.h"

#define CALCUL_PLIST_FILE @"calculator.plist"

@interface NavigationController : BaseViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate> {

}
@property (strong, nonatomic) UITableView *table;
@property (strong, nonatomic) UIButton *gjjBtn, *bizBtn, *combineBtn, *doneBtn;
@property (strong, nonatomic) UITextField *gjjField,*bizField;
@property (strong, nonatomic) UIView *tableFootView;
@property (strong, nonatomic) UILabel *rateLabel;
@property (strong, nonatomic) NSMutableDictionary *condition;
@property (strong, nonatomic) CalculatorManager *calManager;

@property  NSInteger payType;
@end
