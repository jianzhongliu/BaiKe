//
//  QuestController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "QuestController.h"
#import "ChapterCell.h"
#import "ReadPageController.h"
#import "DBManager.h"
#import "SearchViewController.h"

@interface QuestController ()

@end

@implementation QuestController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        [self setTitle:@"首页"];
        segmentDic = [NSDictionary dictionaryWithObjectsAndKeys:[NSArray arrayWithObjects:@"房产科普", @"地产巨头",@"百科问答", nil], @"titles", [NSValue valueWithCGSize:CGSizeMake(107,40)], @"size", @"bottombarredfire.png", @"button-image", @"bottombarredfire_pressed.png", @"button-highlight-image", @"red-divider.png", @"divider-image", [NSNumber numberWithFloat:14.0], @"cap-width", nil];
        // Custom initialization
    }
    return self;
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationItem.hidesBackButton = YES;
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor greenColor]];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    /////////////////////////////////////    
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];
    /////////////////////////////////////
    UISearchBar *search = [[UISearchBar alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
    search.delegate = self;
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"navigationbar_bg.png"]];
    [search insertSubview:imageView atIndex:1];
    search.placeholder = @"请输入您要查找的内容";
    [self.view addSubview:search];
    /////////////////////////////////////
    
    /////////////////////////////////////    
    NSArray* segmentTitles = [segmentDic objectForKey:@"titles"];
    segmentedControl = [[CustomSegmentedControl alloc] initWithSegmentCount:segmentTitles.count segmentsize:[[segmentDic objectForKey:@"size"] CGSizeValue] dividerImage:[UIImage imageNamed:[segmentDic objectForKey:@"divider-image"]] tag:1 delegate:self];
    segmentedControl.frame = CGRectMake(0.0f, 44.0f, 320.0f, 40.0f);
    segmentedControl.backgroundColor = [UIColor redColor];
    [self.view addSubview:segmentedControl];
    
    /////////////////////////////////////
    myTable = [[UITableView alloc] initWithFrame:CGRectMake(0,44+45, 320,self.view.frame.size.height-95) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
    myTable.separatorStyle = 0;
    [self.view addSubview:myTable];
    if([myTable respondsToSelector:@selector(addConstraints:)]){
        [myTable setTranslatesAutoresizingMaskIntoConstraints:NO];
        NSMutableArray *tmpConstraints = [NSMutableArray array];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[myTable(==320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(myTable)]];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[myTable]-0-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(myTable)]];
        [self.view addConstraints:tmpConstraints];
    }else{
        //[watermarkImage setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        myTable.frame = CGRectMake(0.0f, 84.0f, 320.0f, 370.0f);
    }
        myWordArray = [NSMutableArray array];
    DBManager *db = [[DBManager alloc] init];
    [myWordArray removeAllObjects];
    [myWordArray addObjectsFromArray:[db quaryKeywordAndDescription]];
    NSLog(@"?????????????????????-----%@",[[myWordArray objectAtIndex:6] objectForKey:@"title"]);
    [myTable reloadData];
}
-(void)getKeyWord{
    DBManager *db = [[DBManager alloc] init];
    [myWordArray removeAllObjects];
    [myWordArray addObjectsFromArray:[db quaryKeywordAndDescription]];
    NSLog(@"?????????????????????-----%@",[[myWordArray objectAtIndex:6] objectForKey:@"title"]);
   [myTable setContentSize:CGSizeMake(0, 0)];
    [myTable reloadData];
}
-(void)getCompany{
    DBManager *db = [[DBManager alloc] init];
    [myWordArray removeAllObjects];
    [myWordArray addObjectsFromArray:[db quaryCompanyAndDescription]];
    NSLog(@"?????????????????????-----%@",[[myWordArray objectAtIndex:6] objectForKey:@"title"]);
   [myTable setContentSize:CGSizeMake(0, 0)];
    [myTable reloadData];
}
-(void)getQuestion{
    DBManager *db = [[DBManager alloc] init];
    [myWordArray removeAllObjects];
    [myWordArray addObjectsFromArray:[db quaryQuestionAndDescription]];
    NSLog(@"?????????????????????-----%@",[[myWordArray objectAtIndex:6] objectForKey:@"title"]);
    [myTable setContentSize:CGSizeMake(0, 0)];
    [myTable reloadData];
    
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ReadPageController *view=[[ReadPageController alloc] init];
    view.content=[[myWordArray objectAtIndex:[indexPath row]] objectForKey:@"content"];
    view.title=[[myWordArray objectAtIndex:[indexPath row]] objectForKey:@"title"];
    [self.navigationController pushViewController:view animated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [myWordArray count];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70.0f;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identify = @"cell";
    ChapterCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
        tableView.separatorStyle = 1;
    if(cell == nil){
        cell = [[ChapterCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
//        cell.accessoryType=UITableViewCellAccessoryDisclosureIndicator;
        cell.selectionStyle = 0;
    }
    [cell setTitle:[[myWordArray objectAtIndex:[indexPath row]] objectForKey:@"title"]];
    [cell setDescription:[[myWordArray objectAtIndex:[indexPath row]] objectForKey:@"content"]];
    return cell;
}

-(void)reloadNetwork{
    [myTable reloadData];
}

#pragma mark - CustomSegmentedControlDelegate
-(UIButton *)buttonFor:(CustomSegmentedControl *)segmentedControl atIndex:(NSUInteger)segmentIndex{
    NSDictionary* data = segmentDic;
    NSArray* titles = [data objectForKey:@"titles"];
    
    CapLocation location;
    if (segmentIndex == 0)
        location = CapLeft;
    else if (segmentIndex == titles.count - 1)
        location = CapRight;
    else
        location = CapMiddle;
    UIImage* buttonImage = nil;
    UIImage* buttonPressedImage = nil;
    CGSize buttonSize = [[data objectForKey:@"size"] CGSizeValue];
    buttonImage = [UIImage imageNamed:[data objectForKey:@"button-image"]];
    buttonPressedImage = [UIImage imageNamed:[data objectForKey:@"button-highlight-image"]];
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0.0, 0.0, buttonSize.width, buttonSize.height);
    [button setTitle:[titles objectAtIndex:segmentIndex] forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateHighlighted];
    [button setBackgroundImage:buttonPressedImage forState:UIControlStateSelected];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateHighlighted];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
    button.tag = segmentIndex;
    [button addTarget:self action:@selector(segmentButtonClicked:) forControlEvents:UIControlEventTouchDown];
    button.adjustsImageWhenHighlighted = NO;
    
    if (segmentIndex == 0)
        button.selected = YES;
    return button;
}

-(void)segmentButtonClicked:(id)sender{
    int index = ((UIButton*)sender).tag;
    if (index == 0) {
        [self getKeyWord];
    }
    else if(index == 1){//最新
        [self getCompany];
    }
    else if(index == 2){//推荐
        [self getQuestion];
    }
}

#pragma mark - UISearchBarDelegate
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    SearchViewController *controller = [[SearchViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}
@end
