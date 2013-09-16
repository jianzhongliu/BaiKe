//
//  CalculatorResultController.m
//  Anjuke
//
//  Created by omiyang on 7/14/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorResultController.h"
#import "AppDelegate.h"

#define LOCATION_NETWORKNOOPEN @"非常抱歉,您尚未连接网络"

@implementation CalculatorResultController

@synthesize data = _data;
@synthesize payStyle = _payStyle;
@synthesize type = _type;
@synthesize labels = _labels;
@synthesize viewData = _viewData;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Initialization code
        

        
        self.navigationItem.title = @"计算结果";
        
//        [self.controller navigationItem].leftBarButtonItem = [RTBarButtonGenerator createArrowBarButtonItemWithText:@"房贷计算器" target:self.controller selector:@selector(backButtonClick)];
    }
    return self;
}

- (void)loadView {
    [super loadView];
}


- (NSMutableDictionary *)viewData {
    if (_viewData == nil) {
        _viewData = [[NSMutableDictionary alloc] init];
    }
    return _viewData;
}
- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


- (void)backButtonClick {
    [self.navigationController popViewControllerAnimated:YES];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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
    
    NSArray *array;
    switch (self.type) {
        case 1:
            if (self.payStyle ==1) {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"公积金贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"月均还款:",@"%.2f (元)", nil];
            }
            else {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"公积金贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"首月还款:",@"%.2f (元)", @"末月还款:",@"%.2f (元)", nil];
            }
            break;
        case 2:
            if (self.payStyle ==1) {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"商业贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"月均还款:",@"%.2f (元)", nil];
            }
            else {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"商业贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"首月还款:",@"%.2f (元)", @"末月还款:",@"%.2f (元)", nil];
            }
            break;
        default:
            if (self.payStyle ==1) {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"公积金贷款利率:",@"%.2f%%",@"商业贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"月均还款:",@"%.2f (元)", nil];
            }
            else {
                array = [[NSArray alloc] initWithObjects:@"贷款总额:",@"%.f (万元)",@"公积金贷款利率:",@"%.2f%%",@"商业贷款利率:",@"%.2f%%",@"还款总额:",@"%.3f (万元)",@"支付利息:",@"%.3f (万元)",@"贷款月数:",@"%.f月",@"首月还款:",@"%.2f (元)", @"末月还款:",@"%.2f (元)", nil];
            }
            break;
    }
//    [_labels addObjectsFromArray:array];
    self.labels = array;

    [self.viewData setValue:self.data forKey:@"data"];
    [self.viewData setValue:self.labels forKey:@"labels"];
    
    self.view.backgroundColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStyleGrouped];
    table.delegate = self;
    table.dataSource = self;
    table.separatorColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    table.backgroundColor = self.view.backgroundColor;
    table.scrollEnabled = NO;
    [self.view addSubview:table];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
}
-(void)popself{
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - TableView Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.data.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger row = [indexPath row];
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil] ;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    cell.textLabel.text = [self.labels safelyObjectAtIndex:row*2];
    CGSize size = [cell.textLabel.text safelySizeWithFont:cell.textLabel.font constrainedToSize:CGSizeMake(320, 20)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(size.width+25, 14, 130, size.height)];
    lab.font = cell.textLabel.font;
    if ([cell.textLabel.text hasSuffix:@"还款:"]) {
        lab.textColor = [UIColor redColor];
    }
    else {
        lab.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    }
    lab.text = [NSString stringWithFormat:[self.labels safelyObjectAtIndex:(row*2+1)],[[self.data safelyObjectAtIndex:row] floatValue]];
    lab.backgroundColor = [UIColor clearColor];
    [cell addSubview:lab];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
    
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    
    UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 30)] ;
    
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 310, 20)];
    rateLabel.font = [UIFont systemFontOfSize:13];
    rateLabel.textColor = [UIColor colorWithRed:231/255.0 green:120/255.0 blue:24/255.0 alpha:1];
    rateLabel.backgroundColor = [UIColor clearColor];
    rateLabel.textAlignment = NSTextAlignmentRight;
    rateLabel.text = @"以上结果仅供参考";
    [footView addSubview:rateLabel];
    
    
    return footView;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.data = nil;
}

@end
