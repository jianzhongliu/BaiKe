//
//  MoreController.m
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "MoreController.h"
#import "SQLManagerController.h"
#import "cnvUILabel.h"

@interface MoreController ()

@end

@implementation MoreController

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
    CGRect tempRect = CGRectMake(0.0f, 0.0f, 320.0f, 44.0f);
    UIImageView * textbg = [[UIImageView alloc]  initWithFrame:tempRect];
    textbg.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    [self.view addSubview:textbg];
    
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLable.textAlignment = UITextAlignmentCenter;
    titleLable.textColor     = RGB(0.0f, 0.0f, 0.0f);
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor     = [UIColor whiteColor];
    titleLable.shadowColor   = [UIColor blackColor];//字体为白色时可给他添加黑色的阴影效果
    titleLable.shadowOffset  = CGSizeZero;
    titleLable.font          = [UIFont boldSystemFontOfSize:20.0f];
    titleLable.text = @"设置";
    [titleLable sizeToFit];//在边框变化时改变
    titleLable.center        = CGPointMake(160.0f, 22.0f);
    [self.view addSubview:titleLable];
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    UIButton *bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame=CGRectMake(100, 100, 80, 40);
    [bu setTitle:@"设置播放语言" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(setLocalism) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];
    
    bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame=CGRectMake(100, 150, 80, 40);
    [bu setTitle:@"设置语速" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(setDB) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];
    
    bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame=CGRectMake(100, 200, 80, 40);
    [bu setTitle:@"关于" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(setDB) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];
    
    bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame=CGRectMake(100, 250, 80, 40);
    [bu setTitle:@"反馈" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(setDB) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];
    

    
    bu=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame=CGRectMake(100, 300, 80, 40);
    [bu setTitle:@"设置数据库" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(setDB) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];

    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=YES;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setLocalism{
    NSString *str = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"word1" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"====%@",[[[[str componentsSeparatedByString:@"==="] objectAtIndex:30] componentsSeparatedByString:@"=="]objectAtIndex:1]);
    
    NSMutableArray *arry = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"", @"", @"", @"", @"", @"", nil];
  SelectValueController  * controller =[[SelectValueController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:controller];
    controller.myArray = arry;
    controller.delegate = self;
    
    [self presentViewController:nav animated:YES completion:^{
    }];
}
-(void)setDB{
    SQLManagerController *view = [[SQLManagerController alloc] init];
    [self.navigationController pushViewController:view animated:YES];
    
}
#pragma mark SelectValueControllerDelegate
-(void)returnSelectedValues:(NSString *)value{
    NSLog(@"%@",value);
    NSUserDefaults *user = [[NSUserDefaults alloc] init];
    [user setValue:value forKey:@"voice"];
    [user synchronize];
}

@end
