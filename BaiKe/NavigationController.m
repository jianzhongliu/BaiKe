//
//  NavigationController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "NavigationController.h"
#import "CalculatorSelectorController.h"
#import "CalculatorResultController.h"
//#import "CalculatorHelpController.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface NavigationController ()

@end

@implementation NavigationController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    self.navigationItem.titleView.backgroundColor = [UIColor blackColor];
    [self.table reloadData];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}
- (void)loadView {
    [super loadView];
    
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    UIView *view = [[UIView alloc] initWithFrame:frame];
    view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0];
    self.view = view;
    [self configControllerInformation];
    [self drawButtonMenu];
    [self drawTableView];
    [self drawCalcButton];
}

-(void) rightBarButtonAction:(id)sender
{
    [self helpBtnClick:sender];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.textAlignment = UITextAlignmentCenter;
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor     = [UIColor whiteColor];
    titleLable.shadowColor   = [UIColor blackColor];//字体为白色时可给他添加黑色的阴影效果
    titleLable.shadowOffset  = CGSizeZero;
    titleLable.font          = [UIFont boldSystemFontOfSize:20.0f];
    titleLable.text = @"房贷计算器";
    [titleLable sizeToFit];//在边框变化时改变
    titleLable.center        = CGPointMake(160.0f, 22.0f);
    [self.view addSubview:titleLable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShowOnDelay:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
}

- (void)hidekeybord {
    [self.gjjField resignFirstResponder];
    [self.bizField resignFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark Main Action Of Controller

- (void)configControllerInformation {
    self.tabBarController.tabBar.hidden = YES;
    self.title = @"房贷计算器";
    self.payType = 1;
    [self.condition setValue:[NSNumber numberWithInt:1]  forKey:@"type"];
}

- (NSMutableDictionary *)condition {
    if (_condition == nil) {
        NSString *plistPath =[[NSBundle mainBundle] pathForResource:[CALCUL_PLIST_FILE stringByDeletingPathExtension] ofType:[CALCUL_PLIST_FILE pathExtension]];
        _condition = [[NSMutableDictionary alloc] initWithContentsOfFile:plistPath];
    }
    return _condition;
}

- (CalculatorManager *)calManager {
    if (_calManager == nil) {
        _calManager = [[CalculatorManager alloc] init];
    }
    return _calManager;
}



/**
 绘制导航栏组件
 */

-(void) drawNavigationBarItem {
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:238/255.0 blue:238/255.0 alpha:1.0];
    //    self.navigationItem.rightBarButtonItem = [RTBarButtonGenerator createBarButtonItemWithText:@"帮助" target:self selector:@selector(helpBtnClick:)];
}

/**
 绘制顶部的三个类型的贷款计算按钮
 */
- (void)drawButtonMenu {
    NSArray *buttonList = [self fetchMenuButtonList];
    for (int i=0; i<[buttonList count];i++ ) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        NSArray *btnData = [buttonList objectAtIndex:i];
        btn.accessibilityLabel = [btnData objectAtIndex:0];
        btn.frame = CGRectMake(10+i*100, 18+45, 101, 40);
        NSString *buttonName = [btnData objectAtIndex:3];
        btn.tag = [[btnData objectAtIndex:1] intValue];
        [btn setTitle:[btnData objectAtIndex:2] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(typeButtonSelected:) forControlEvents:UIControlEventTouchDown];
        [self.view addSubview:btn];
        if ([buttonName isEqualToString:@"gjjBtn"]) {
            self.gjjBtn = btn;
        } else if([buttonName isEqualToString:@"bizBtn"]) {
            self.bizBtn = btn;
        } else if([buttonName isEqualToString:@"combineBtn"]) {
            self.combineBtn = btn;
        }
    }
    [self setTypeButtonImage];
}

/**
 绘制Table View数据
 */
- (void) drawTableView {
    self.table = [[UITableView alloc] initWithFrame:CGRectMake(0,110, 320, 295) style:UITableViewStyleGrouped];
    self.table.delegate = self;
    self.table.dataSource = self;
    if (SYSTEM_VERSION_LESS_THAN(@"6.0")) {
        self.table.backgroundColor = self.view.backgroundColor;
    }else {
        UIView *bgView = [[UIView alloc]initWithFrame:self.table.frame];
        bgView.backgroundColor = self.view.backgroundColor;
        self.table.backgroundView = bgView;
    }
    [self.table setBackgroundColor:[UIColor redColor]];
    self.table.separatorColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    self.table.scrollEnabled = NO;
    [self.view addSubview:self.table];
}

- (void)drawCalcButton {
    UIButton *startBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    startBtn.accessibilityLabel = @"startBtn";
    startBtn.frame = CGRectMake(10, self.view.frame.size.height-44-38-20, 301, 38);
    [startBtn setBackgroundImage:[UIImage imageNamed:@"calculator-start.png"] forState:UIControlStateNormal];
    [startBtn setTitle:@"开 始 计 算" forState:UIControlStateNormal];
    [startBtn addTarget:self action:@selector(startCalculator) forControlEvents:UIControlEventTouchUpInside];
    startBtn.titleLabel.textColor = [UIColor whiteColor];
    [self.view addSubview:startBtn];
}


- (void) backButtonClicked {
    self.tabBarController.tabBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)helpBtnClick:(id)sender {
    //    CalculatorHelpController *controller = [[CalculatorHelpController alloc] init];
    //    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark -
#pragma mark Btn Clicked Style
- (void) setTypeButtonImage {
    switch (self.payType) {
        case 1:
            [self setGjjBtnImageSelected];
            [self setBizBtnImageUnSelected];
            [self setCombineBtnImageUnSelected];
            break;
        case 2:
            [self setGjjBtnImageUnSelected];
            [self setCombineBtnImageUnSelected];
            [self setBizBtnImageSelected];
            break;
        default:
            [self setGjjBtnImageUnSelected];
            [self setBizBtnImageUnSelected];
            [self setCombineBtnImageSelected];
            break;
    }
    [self.table reloadData];
    
}

#pragma mark Type Button Selected
- (void)typeButtonSelected:(id)sender {
    self.payType = [sender tag];
    [self.condition setValue:[NSString stringWithFormat:@"%d",self.payType] forKey:@"type"];
    [self setTypeButtonImage];
}

#pragma mark status of button style tab页的文字和背景图片

- (void)setGjjBtnImageSelected {
    [self.gjjBtn setBackgroundImage:[UIImage imageNamed:@"calculator-left-sel.png"] forState:UIControlStateNormal];
    self.gjjBtn.titleLabel.textColor = [UIColor whiteColor];
}
- (void)setGjjBtnImageUnSelected {
    [self.gjjBtn setBackgroundImage:[UIImage imageNamed:@"calculator-left.png"] forState:UIControlStateNormal];
    self.gjjBtn.titleLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
}
- (void)setBizBtnImageSelected {
    [self.bizBtn setBackgroundImage:[UIImage imageNamed:@"calculator-mid-sel.png"] forState:UIControlStateNormal];
    self.bizBtn.titleLabel.textColor = [UIColor whiteColor];
}
- (void)setBizBtnImageUnSelected {
    [self.bizBtn setBackgroundImage:[UIImage imageNamed:@"calculator-mid.png"] forState:UIControlStateNormal];
    self.bizBtn.titleLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
}
- (void)setCombineBtnImageSelected {
    [self.combineBtn setBackgroundImage:[UIImage imageNamed:@"calculator-right-sel.png"] forState:UIControlStateNormal];
    self.combineBtn.titleLabel.textColor = [UIColor whiteColor];
}
- (void)setCombineBtnImageUnSelected {
    [self.combineBtn setBackgroundImage:[UIImage imageNamed:@"calculator-right.png"] forState:UIControlStateNormal];
    self.combineBtn.titleLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
}

#pragma mark -
#pragma mark DataSource
/**
 获取三个button按钮信息
 */
- (NSArray *)fetchMenuButtonList {
    NSArray *gjj = [[NSArray alloc] initWithObjects:@"button_gjj", @"1", @"公积金贷款", @"gjjBtn", nil];
    NSArray *biz = [[NSArray alloc] initWithObjects:@"button_biz", @"2", @"商业贷款", @"bizBtn", nil];
    NSArray *combine = [[NSArray alloc] initWithObjects:@"button_combine", @"3", @"组合贷款", @"combineBtn", nil];
    return [[NSArray alloc] initWithObjects:gjj,biz,combine, nil];
}

#pragma mark -
#pragma mark TableView Delegate Method
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.payType == 1) {
        return 3;
    }
    return 4;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.tableFootView == nil) {
        UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
        self.tableFootView = footView;
    }
    
    if (self.rateLabel == nil) {
        UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, 20)];
        rateLabel.font = [UIFont systemFontOfSize:13];
        rateLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
        rateLabel.backgroundColor = [UIColor clearColor];
        rateLabel.textAlignment = NSTextAlignmentRight;
        self.rateLabel = rateLabel;
        [self.tableFootView addSubview:self.rateLabel];
    }
    
    float percent = (float)[[self.condition objectForKey:@"ratePercent"] floatValue];
    int month = [[self.condition objectForKey:@"year"] intValue] *12;
    int type = [[self.condition objectForKey:@"type"] intValue];
    float gjjRate;
    float bizRate;
    
    switch (type) {
        case 1:
            gjjRate = [[self.calManager getRateByType:type withMonth:month] floatValue] ;
            self.rateLabel.text = [NSString stringWithFormat:@"公积金贷款利率%.2f%%", gjjRate];
            break;
        case 2:
            bizRate = [[self.calManager getRateByType:type withMonth:month] floatValue] * percent;
            self.rateLabel.text = [NSString stringWithFormat:@"商业贷款利率%.2f%%",bizRate];
            
            break;
        case 3:
            gjjRate = [[self.calManager getRateByType:1 withMonth:month] floatValue] ;
            bizRate = [[self.calManager getRateByType:2 withMonth:month] floatValue] * percent;
            self.rateLabel.text = [NSString stringWithFormat:@"公积金贷款利率%.2f%% 商业贷款利率%.2f%%", gjjRate, bizRate];
            break;
    }
    return self.tableFootView;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    switch (self.payType) {
        case 1:
            cell = [self getGjjCell:indexPath];
            break;
        case 2:
            cell = [self getBizCell:indexPath];
            break;
        default:
            cell = [self getCombineCell:indexPath];
            break;
    }
    return cell;
}

#pragma three type cell
- (UITableViewCell *)getGjjCell:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    NSString *identifier = [NSString stringWithFormat:@"GJJCellIdentifier_%d",row];
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (row) {
        case 0:
            cell.textLabel.text = @"还款方式:";
            cell.accessibilityLabel = @"item_paytype";
            cell.detailTextLabel.text = [self.condition objectForKey:@"payStyleLabel"];
            break;
        case 1:
            cell.textLabel.text = @"贷款总额:";
            self.gjjField = [self createTextFieldWithDefaultText:[self.condition objectForKey:@"gjj"] frame:CGRectMake(170, 7, 100, 30)];
            self.gjjField.accessibilityLabel = @"input_gjj";
            //            [self.gjjField setKeyboardType:UIKeyboardTypeNumberPad];
            self.gjjField.delegate = self;
            [cell addSubview:self.gjjField];
            [cell addSubview:[self createLabelWithFrame:CGRectMake(272, 11, 30, 20)]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.textLabel.text = @"按揭年数:";
            cell.accessibilityLabel = @"item_year";
            cell.detailTextLabel.text = [self.condition objectForKey:@"yearLabel"];
            break;
    }
    return cell;
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.text = @"";
    return YES;
}

- (UITableViewCell *)getBizCell:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    NSString *identifier = [NSString stringWithFormat:@"BizCellIdentifier_%d",row];
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (row) {
        case 0:
            cell.textLabel.text = @"还款方式:";
            cell.accessibilityLabel = @"item_paytype";
            cell.detailTextLabel.text = [self.condition objectForKey:@"payStyleLabel"];
            break;
        case 1:
            cell.textLabel.text = @"贷款总额:";
            self.bizField = [self createTextFieldWithDefaultText:[self.condition objectForKey:@"biz"] frame:CGRectMake(170, 7, 100, 30)];
            self.bizField.accessibilityLabel = @"input_biz";
            self.bizField.delegate = self;
            [cell addSubview:self.bizField];
            [cell addSubview:[self createLabelWithFrame:CGRectMake(272, 11, 30, 20)]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        case 2:
            cell.textLabel.text = @"按揭年数:";
            cell.accessibilityLabel = @"item_year";
            cell.detailTextLabel.text = [self.condition objectForKey:@"yearLabel"];
            break;
        case 3:
            cell.textLabel.text = @"利率:";
            cell.accessibilityLabel = @"item_rate";
            cell.detailTextLabel.text = [self.condition objectForKey:@"ratePercentLabel"];
            break;
    }
    return cell;
}

- (UITableViewCell *)getCombineCell:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    NSString *identifier = [NSString stringWithFormat:@"CombineCellIdentifier_%d",row];
    
    UITableViewCell *cell = [self.table dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
        
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14];
        cell.detailTextLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    switch (row) {
        case 0:
        {
            cell.textLabel.text = @"还款方式:";
            cell.accessibilityLabel = @"item_paytype";
            cell.detailTextLabel.text = [self.condition objectForKey:@"payStyleLabel"];
            break;
        }
        case 1:;
        {
            UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 11, 140, 20)];
            textLabel.font = [UIFont boldSystemFontOfSize:14];
            textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
            textLabel.text = @"贷款金额:";
            textLabel.backgroundColor = [UIColor clearColor];
            [cell addSubview:textLabel];
            
            UILabel *gjjPrefix = [[UILabel alloc] initWithFrame:CGRectMake(120, 11, 50, 20)];
            gjjPrefix.font = [UIFont systemFontOfSize:14];
            gjjPrefix.text = @"公积金";
            gjjPrefix.backgroundColor = [UIColor clearColor];
            [cell addSubview:gjjPrefix];
            
            UILabel *bizPrefix = [[UILabel alloc] initWithFrame:CGRectMake(120, 46, 50, 20)];
            bizPrefix.text = @"商业性";
            bizPrefix.backgroundColor = [UIColor clearColor];
            bizPrefix.font = [UIFont systemFontOfSize:14];
            [cell addSubview:bizPrefix];
            
            self.gjjField = [self createTextFieldWithDefaultText:[self.condition objectForKey:@"gjj"] frame:CGRectMake(170, 7, 100, 30)];
            self.gjjField.accessibilityLabel = @"input_gjj";
            
            self.gjjField.delegate = self;
            [cell addSubview:self.gjjField];
            [cell addSubview:[self createLabelWithFrame:CGRectMake(272, 11, 30, 20)]];
            self.bizField = [self createTextFieldWithDefaultText:[self.condition objectForKey:@"biz"] frame:CGRectMake(170, 42, 100, 30)];
            self.bizField.accessibilityLabel = @"input_biz";
            
            self.bizField.delegate = self;
            [cell addSubview:self.bizField];
            [cell addSubview:[self createLabelWithFrame:CGRectMake(272, 46, 30, 20)]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.accessoryType = UITableViewCellAccessoryNone;
            break;
        }
        case 2:
        {
            cell.textLabel.text = @"按揭年数:";
            cell.accessibilityLabel = @"item_year";
            cell.detailTextLabel.text = [self.condition objectForKey:@"yearLabel"];
            break;
        }
        case 3:
        {
            cell.textLabel.text = @"利率:";
            cell.accessibilityLabel = @"item_rate";
            cell.detailTextLabel.text = [self.condition objectForKey:@"ratePercentLabel"];
            break;
        }
    }
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([indexPath row] == 1 && self.payType == 3) {
        return 80;
    }
    return 45;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    
    int type = 0;
    NSString *selectedValue = @"";
    switch (row) {
        case 0:
            type = 1;
            selectedValue = [self.condition objectForKey:@"payStyle"];
            break;
        case 1:
            return;
        case 2:
            type = 2;
            selectedValue = [self.condition objectForKey:@"year"];
            break;
        case 3:
            type = 3;
            selectedValue = [self.condition objectForKey:@"ratePercent"];
            break;
    }
    
    CalculatorSelectorController *controller = [[CalculatorSelectorController alloc] init];
    controller.delegate = self;
    controller.type = type;
    controller.selectedValue = selectedValue;
    
    [self doneButton:nil];
    [self.navigationController pushViewController:controller animated:YES];
}

- (UITextField *)createTextFieldWithDefaultText:(NSString *)text frame:(CGRect)frame{
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.text = text;
    field.font = [UIFont systemFontOfSize:16];
    field.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    field.textAlignment = NSTextAlignmentRight;
    field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    field.borderStyle = UITextBorderStyleRoundedRect;
    return field;
}

- (UILabel *)createLabelWithFrame:(CGRect)frame {
    UILabel *label = [[UILabel alloc] initWithFrame:frame];
    label.text = @"万元";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont systemFontOfSize:14];
    return label;
}


#pragma mark - Calculator
- (void)startCalculator {
    
    NSArray *result = [self.calManager calculator:self.condition];
    [self.condition writeToFile:[[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]
                                 stringByAppendingPathComponent:CALCUL_PLIST_FILE] atomically:YES];
    
    CalculatorResultController *controller = [[CalculatorResultController alloc] init];
    controller.data = result;
    controller.type = [[self.condition objectForKey:@"type"] intValue];
    controller.payStyle = [[self.condition objectForKey:@"payStyle"] intValue];
    
    [self.navigationController pushViewController:controller animated:YES];
    
}


#pragma mark - keyboard done
- (void)keyboardWillShowOnDelay:(NSNotification *)notification
{
    [self performSelector:@selector(keyboardWillShow:) withObject:nil afterDelay:0];
}

- (void)keyboardWillDisappear:(NSNotification *)notification {
    [self.doneBtn removeFromSuperview];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
    UIView *foundKeyboard = nil;
    
    UIWindow *keyboardWindow = nil;
    for (UIWindow *testWindow in [[UIApplication sharedApplication] windows])
    {
        if (![[testWindow class] isEqual:[UIWindow class]])
        {
            keyboardWindow = testWindow;
            break;
        }
    }
    if (!keyboardWindow) return;
    
    for (UIView *possibleKeyboard in [keyboardWindow subviews])
    {
        //iOS3
        if ([[possibleKeyboard description] hasPrefix:@"<UIKeyboard"])
        {
            foundKeyboard = possibleKeyboard;
            break;
        }
        else if ([[possibleKeyboard description] hasPrefix:@"<UIPeripheralHostView"])
        {
            NSArray *subviews = [possibleKeyboard subviews];
            for (UIView *vi in subviews) {
                if ([[vi description] hasPrefix:@"<UIKeyboard"])
                {
                    foundKeyboard = vi;
                    break;
                }
            }
        }
        if (foundKeyboard) {
            break;
        }
    }
    
    if (foundKeyboard)
    {
        // create custom button
        UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        doneButton.frame = CGRectMake(0, 163, 106, 53);
        doneButton.adjustsImageWhenHighlighted = NO;
        [doneButton setImage:[UIImage imageNamed:@"numberPadBtn.png"] forState:UIControlStateNormal];
        [doneButton addTarget:self action:@selector(doneButton:) forControlEvents:UIControlEventTouchUpInside];
        self.doneBtn = doneButton;
        
        
        [foundKeyboard addSubview:self.doneBtn];
    }
}

- (void)doneButton:(id)sender{
    int type = [[self.condition objectForKey:@"type"] intValue];
    switch (type) {
        case 1:
            if (![@"" isEqualToString:self.gjjField.text]) {
                if ([self.gjjField.text intValue]>10000) {
                    self.gjjField.text = @"10000";
                }
                [self.condition setValue:self.gjjField.text forKey:@"gjj"];
            }
            else {
                self.gjjField.text = [self.condition objectForKey:@"gjj"];
            }
            break;
        case 2:
            if (![@"" isEqualToString:self.bizField.text]) {
                if ([self.bizField.text intValue]>10000) {
                    self.bizField.text = @"10000";
                }
                [self.condition setValue:self.bizField.text forKey:@"biz"];
            }
            else {
                self.bizField.text = [self.condition objectForKey:@"biz"];
            }
            break;
        default:
            if (![@"" isEqualToString:self.gjjField.text]) {
                if ([self.gjjField.text intValue]>10000) {
                    self.gjjField.text = @"10000";
                }
                [self.condition setValue:self.gjjField.text forKey:@"gjj"];
            }
            else {
                self.gjjField.text = [self.condition objectForKey:@"gjj"];
            }
            if (![@"" isEqualToString:self.bizField.text]) {
                if ([self.bizField.text intValue]>10000) {
                    self.bizField.text = @"10000";
                }
                [self.condition setValue:self.bizField.text forKey:@"biz"];
            }
            else {
                self.bizField.text = [self.condition objectForKey:@"biz"];
            }
            break;
    }
    
    [self.gjjField resignFirstResponder];
    [self.bizField resignFirstResponder];
}

@end
