//
//  GuideController.m
//  BaiKe
//
//  Created by jianzhongliu on 7/30/13.
//  Copyright (c) 2013 yons. All rights reserved.
//

#import "GuideController.h"
#import "MainTabBarController.h"
@interface GuideController ()

@end

@implementation GuideController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
          
        // Custom initialization
    }
    return self;
}
-(void)loadView{
    [super loadView];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor redColor]];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];

    if(true){
        MainTabBarController *controller = [[MainTabBarController alloc] init];
        [self.navigationController pushViewController:controller animated:YES];
    }
	// Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
