//
//  CalculatorSelectorController.m
//  Anjuke
//
//  Created by omiyang on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorSelectorController.h"
#import "CalculatorManager.h"
#define AJK_RATEDISCOUNT_PLIST @"AJKLoanRateDiscount.plist"

@interface  CalculatorSelectorController ()

@property (retain, nonatomic) NSMutableDictionary *viewData;

- (void)setPayStyleValueByIndexPath:(NSIndexPath *)indexPath;
- (void)setYearValueByIndexPath:(NSIndexPath *)indexPath;
- (void)setRateValueByIndexPath:(NSIndexPath *)indexPath;
@end


@implementation CalculatorSelectorController

@synthesize delegate = _delegate;
@synthesize type = _type;
@synthesize selectedValue = _selectedValue;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.viewData = [NSMutableDictionary dictionary];
        [self.viewData setValue:[NSNumber numberWithInt:self.type] forKey:@"type"];
        [self.viewData setValue:self.selectedValue forKey:@"selectedValue"];
    }
    return self;
}

#pragma mark - View lifecycle
- (void)loadView
{
    [super loadView];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setBackgroundImage:[UIImage imageNamed:@"navbuttonnormal.png"] forState:UIControlStateNormal];
    [listButton setFrame:CGRectMake(0.0, 6.0, 55.0, 32.0)];
    [listButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    listButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [listButton setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *listBarButton = [[UIBarButtonItem alloc] initWithCustomView:listButton] ;
    [self.navigationItem setLeftBarButtonItem:listBarButton];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    table.backgroundColor = self.view.backgroundColor;
    [self.view addSubview:table];
    
    switch (self.type) {
        case 1:
            [self setTitle:@"还款方式"];
//            self.navigationController.navigationItem.title = @"还款方式";
            break;
        case 2:
            [self setTitle:@"按揭年数"];
//            self.navigationController.navigationItem.title = @"按揭年数";
            break;
        case 3:
            [self setTitle:@"利率"];
//            self.navigationController.navigationItem.title = @"利率";
            break;
    }

}
-(void)popself{
    [self.navigationController popViewControllerAnimated:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}

#pragma mark - uitablevie
#pragma mark - UITableViewDelegate & UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (self.type) {
        case 1:
            return 2;
            break;
        case 2:
            return 30;
            break;
        default:
            return 3;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (self.type) {
        case 1:
            return [self createPayStyleCell:tableView indexPath:indexPath];
            break;
        case 2:
            return [self createYearCell:tableView indexPath:indexPath];
            break;
        default:
            return [self createRateCell:tableView indexPath:indexPath];
    }
}

- (UITableViewCell *)createPayStyleCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"SelectorPayStyleCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
    switch ([indexPath row]) {
        case 0:
            cell.textLabel.text = @"等额本息";
            if ([self.selectedValue intValue] == 1) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            break;
            
        default:
            if ([self.selectedValue intValue] == 2) {
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
            }
            cell.textLabel.text = @"等额本金";
            break;
    }
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (UITableViewCell *)createYearCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"SelectorYearCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier] ;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [NSString stringWithFormat:@"%d年 (%d期)", row+1, (row+1)*12];
    cell.accessoryType = UITableViewCellAccessoryNone;
    if ([self.selectedValue intValue] == row+1) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (UITableViewCell *)createRateCell:(UITableView *)tableView indexPath:(NSIndexPath *)indexPath {
    NSString *identifier = @"SelectorRateCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        cell.textLabel.textColor = [UIColor colorWithRed:51/255.0 green:51/255.0 blue:51/255.0 alpha:1];
    }
    
    NSUInteger row = [indexPath row];
    NSString *plistPath =[[NSBundle mainBundle] pathForResource:[AJK_RATEDISCOUNT_PLIST stringByDeletingPathExtension] ofType:[AJK_RATEDISCOUNT_PLIST pathExtension]];
    NSDictionary *dyna =[[[NSMutableArray alloc] initWithContentsOfFile:plistPath] safelyObjectAtIndex:row];
    if ([self.selectedValue floatValue] == [[dyna objectForKey:@"dyna"] floatValue]) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    cell.textLabel.text = [dyna objectForKey:@"name"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (self.type) {
        case 1:
            [self setPayStyleValueByIndexPath:indexPath];
            break;
        case 2:
            [self setYearValueByIndexPath:indexPath];
            break;
        default:
            [self setRateValueByIndexPath:indexPath];
            break;
    }
}

#pragma mark - originMethod
- (void)calIndexTableReload {
    [[self.delegate table] reloadData];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)setPayStyleValueByIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSMutableDictionary *condition = [self.delegate condition];
    switch (row) {
        case 0:
            [condition setValue:@"等额本息" forKey:@"payStyleLabel"];
            [condition setValue:@"1" forKey:@"payStyle"];
            break;
            
        default:
            [condition setValue:@"等额本金" forKey:@"payStyleLabel"];
            [condition setValue:@"2" forKey:@"payStyle"];
            break;
    }
    [self calIndexTableReload];
}

- (void)setYearValueByIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSMutableDictionary *condition = [self.delegate condition];
    
    [condition setValue:[NSString stringWithFormat:@"%d年 (%d期)",row+1,(row+1)*12] forKey:@"yearLabel"];
    [condition setValue:[NSString stringWithFormat:@"%d",row+1] forKey:@"year"];

    [self calIndexTableReload];
}

- (void)setRateValueByIndexPath:(NSIndexPath *)indexPath {
    NSUInteger row = [indexPath row];
    NSMutableDictionary *condition = [self.delegate condition];
    NSString *plistPath =[[NSBundle mainBundle] pathForResource:[AJK_RATEDISCOUNT_PLIST stringByDeletingPathExtension] ofType:[AJK_RATEDISCOUNT_PLIST pathExtension]];
    NSDictionary *dyna = [[NSArray arrayWithContentsOfFile:plistPath] safelyObjectAtIndex:row];
    [condition setValue:[dyna objectForKey:@"name"] forKey:@"ratePercentLabel"];
    [condition setValue:[dyna objectForKey:@"dyna"] forKey:@"ratePercent"];
    
    [self calIndexTableReload];
}

@end
