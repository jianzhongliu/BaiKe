//
//  BaseViewController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"
#import "HCNavigationBar.h"
@interface BaseViewController ()

@end

@implementation BaseViewController
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
    
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setBackgroundImage:[UIImage imageNamed:@"navbuttonnormal.png"] forState:UIControlStateNormal];
    [listButton setFrame:CGRectMake(0.0, 6.0, 55.0, 32.0)];
    [listButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    listButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [listButton setTitle:@"返回" forState:UIControlStateNormal];
    UIBarButtonItem *listBarButton = [[UIBarButtonItem alloc] initWithCustomView:listButton] ;
    [self.navigationItem setLeftBarButtonItem:listBarButton];

	// Do any additional setup after loading the view.
}
-(void)popself{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)reloadNetwork{


}
@end
