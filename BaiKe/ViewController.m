//
//  ViewController.m
//  BaiKe
//
//  Created by yons on 13-7-28.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "ViewController.h"
#import "ReadPageController.h"
#import "ListenViewController.h"
#import "BaiduMobAdView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but.frame = CGRectMake(0, 0,100, 40);
    [but addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [but setTitle:@"阅读一篇文章" forState:UIControlStateNormal];
    
    [self.view addSubview:but];
    
    UIButton *but1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    but1.frame = CGRectMake(100, 0, 100, 40);
    [but1 setTitle:@"阅读" forState:UIControlStateNormal];
    [but1 addTarget:self action:@selector(readText) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:but1];
    NSMutableDictionary *value = [[NSMutableDictionary alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Baike" ofType:@"plist"]];
    NSLog(@"%@",value);
	// Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    self .navigationController.navigationBarHidden = NO;
    [self showAudioAdView];
    [self showAdViewInController:self withRect:CGRectMake(0,self.view.bounds.size.height-40, 320, 40)];
}
- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}
-(void)readText{
    ListenViewController *controller = [[ListenViewController alloc] init];
    [self.navigationController pushViewController:controller animated:NO];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    // Dispose of any resources that can be recreated.
}
-(void)click{

    ReadPageController *controller = [[ReadPageController alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
    
}
#pragma mark - showAdViewMethods
//显示横幅的广告
- (void)showAdViewInController:(UIViewController<BaiduMobAdViewDelegate> *)controller withRect:(CGRect) rect
{
    BaiduMobAdView *adView = [[BaiduMobAdView alloc] init];
    adView.AdUnitTag = @"myAdPlaceId1";
    adView.AdType = BaiduMobAdViewTypeBanner;
    adView.frame = rect;
    adView.delegate = controller;
    [controller.view addSubview:adView];
    [adView start];
}
//显示视频加载前的15秒广告
-(void)showAudioAdView{
    sharedAdView = [[BaiduMobAdView alloc] init];
    // 视频类型广告相关设置
    sharedAdView.AdUnitTag = @"myAdPlaceId2";
    sharedAdView.AdType = BaiduMobAdViewTypeVABeforeVideo;
    sharedAdView.frame = CGRectMake(20,20,kBaiduAdViewSquareBanner300x250.width,kBaiduAdViewSquareBanner300x250.height);
    sharedAdView.delegate = self;
    [self.view addSubview:sharedAdView];
    [sharedAdView start];
}

#pragma mark - baiduMobViewDelegate
- (NSString *)publisherId
{
    return  @"debug"; //@"your_own_app_id";
}

- (NSString*) appSpec
{
    //注意：该计费名为测试用途，不会产生计费，请测试广告展示无误以后，替换为您的应用计费名，然后提交AppStore.
    return @"debug";
}

-(BOOL) enableLocation
{
    //启用location会有一次alert提示
    return NO;
}


-(void) willDisplayAd:(BaiduMobAdView*) adview
{
    
    NSLog(@"delegate: will display ad");
    
}

-(void) failedDisplayAd:(BaiduMobFailReason) reason;
{
    NSLog(@"delegate: failedDisplayAd %d", reason);
}

@end
