//
//  MainTabBarController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "MainTabBarController.h"
#import "UIViewAdditions.h"
#import "QuestController.h"
#import "CyclopediaController.h"
#import "NavigationController.h"
#import "MoreController.h"
#import "BaseViewController.h"
@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.delegate = self;
    [self.view setBackgroundColor:[UIColor grayColor]];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    NSMutableArray *viewControllers = [[NSMutableArray alloc] initWithCapacity:4];
    
    QuestController *view1 = [[QuestController alloc] init];
    CyclopediaController *view2 = [[CyclopediaController alloc] init];
    NavigationController *view3 = [[NavigationController alloc] init];
    MoreController *view4 = [[MoreController alloc] init];
    
    [viewControllers addObject:view1];
    [viewControllers addObject:view2];
    [viewControllers addObject:view3];
    [viewControllers addObject:view4];
    
    self.viewControllers = viewControllers;
    _viewSelectedIndex = 0;

    self.navigationItem.hidesBackButton = YES;
	[self.tabBar setHidden:YES];
    _contentView = [[UIView alloc] initWithFrame:CGRectZero];
    //_contentView.backgroundColor = [UIColor redColor];
    
	[self.view addSubview:_contentView];
    _contentView.frame =CGRectMake(0.0f, 431.0f, 320.0f, 46.0f);
    if([_contentView respondsToSelector:@selector(addConstraints:)]){
        [_contentView setTranslatesAutoresizingMaskIntoConstraints:NO];
        
        NSMutableArray *tmpConstraints = [NSMutableArray array];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[_contentView(==320)]" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
        [tmpConstraints addObjectsFromArray:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_contentView(46)]-5-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_contentView)]];
        [self.view addConstraints:tmpConstraints];
    }else{
//        [_contentView setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
        _contentView.frame = CGRectMake(0.0f, 431.0f, 320.0f, 46.0f);
    }
    
    CGRect frame = CGRectMake(0.0f, 431.0f, 320.0f, 46.0f);
	UIImageView *bg = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, frame.size.width, frame.size.height + 5.0f)];
	[_contentView addSubview:bg];
	[bg setImage:[UIImage imageNamed: @"menuBG.png"]];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(24.0f, 4.0f, 50.0f, 49.0f)];
    [_contentView addSubview:btn1];
    [btn1 setTag:1];
    [btn1 setImage:[UIImage imageNamed:@"menuicon_home.png"] forState:UIControlStateNormal];
    [btn1 setShowsTouchWhenHighlighted:YES];
    [btn1 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn2 = [[UIButton alloc] initWithFrame:CGRectMake(98.0f, 4.0f, 50.0f, 49.0f)];
    [_contentView addSubview:btn2];
    [btn2 setTag:2];
    [btn2 setImage:[UIImage imageNamed:@"menuicon_one.png"] forState:UIControlStateNormal];
    [btn2 setShowsTouchWhenHighlighted:YES];
    [btn2 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn3 = [[UIButton alloc] initWithFrame:CGRectMake(172.0f, 4.0f, 50.0f, 49.0f)];
    [_contentView addSubview:btn3];
    [btn3 setTag:3];
    [btn3 setImage:[UIImage imageNamed:@"menuicon_ser.png"] forState:UIControlStateNormal];
    [btn3 setShowsTouchWhenHighlighted:YES];
    [btn3 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *btn4 = [[UIButton alloc] initWithFrame:CGRectMake(246.0f, 4.0f, 50.0f, 49.0f)];
    [_contentView addSubview:btn4];
    [btn4 setTag:4];
    [btn4 setImage:[UIImage imageNamed:@"menuicon_set.png"] forState:UIControlStateNormal];
    [btn4 setShowsTouchWhenHighlighted:YES];
    [btn4 addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _selectView   = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 16.0f, 8.0f)];
	[_contentView addSubview:_selectView];
	[_selectView setImage:[UIImage imageNamed:@"tabbar_selected.png"]];
    
    UIButton *btn      = (UIButton *)[_contentView viewWithTag:_viewSelectedIndex+1];
    CGFloat centerLeft = btn.left + btn.width / 2.0f;
    _selectView.center = CGPointMake(centerLeft, 4.0f);
	// Do any additional setup after loading the view.
}
- (void) buttonClick:(id)sender {
    int tag = [sender tag] - 1;
    BaseViewController *viewController = (BaseViewController *)[self.viewControllers objectAtIndex:tag];
    if (self.selectedIndex == tag) {
        [viewController reloadNetwork];
        return;
    }
    if ([self tabBarController:self shouldSelectViewController:viewController]) {
        self.selectedIndex = tag;
    }
}

- (void)setSelectedIndex:(NSUInteger)index {
	[super setSelectedIndex:index];
	_viewSelectedIndex = index;
    
    UIButton *btn = (UIButton *)[_contentView viewWithTag:_viewSelectedIndex+1];
    CGFloat centerLeft = btn.left + btn.width / 2.0f;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.3];
	_selectView.center = CGPointMake(centerLeft, 4.0f);
	[UIView commitAnimations];
}

////////////////////////////////////////////////////////////////////////////////////////////////////
#pragma mark -
#pragma mark UITabBarControllerDelegate

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController
{
    return YES;
}

- (NSUInteger) supportedInterfaceOrientations{
    return UIInterfaceOrientationMaskPortrait;
}

- (BOOL) shouldAutorotate {
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
