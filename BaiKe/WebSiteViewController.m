//
//  WebSiteViewController.m
//  BaiKe
//
//  Created by yons on 13-8-4.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "WebSiteViewController.h"

@interface WebSiteViewController ()

@end

@implementation WebSiteViewController
@synthesize url = _url;
@synthesize name = _name;
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
    webSite = [[UIWebView alloc] initWithFrame:self.view.bounds];
    webSite.delegate = self;
    webSite.scalesPageToFit = YES;
    NSURL *url = [NSURL URLWithString:_url];
    NSURLRequest *request =[NSURLRequest requestWithURL:url];
    [webSite loadRequest:request];
    [self.view addSubview:webSite];
    
    UIButton *listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [listButton setBackgroundImage:[UIImage imageNamed:@"navbuttonnormal.png"] forState:UIControlStateNormal];
    [listButton setFrame:CGRectMake(0.0, 6.0, 55.0, 32.0)];
    [listButton addTarget:self action:@selector(popself) forControlEvents:UIControlEventTouchUpInside];
    listButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [listButton setTitle:@"返回" forState:UIControlStateNormal];
    listButton.hidden = YES;
    UIBarButtonItem *listBarButton = [[UIBarButtonItem alloc] initWithCustomView:listButton] ;
    [self.navigationItem setRightBarButtonItem:listBarButton];
	// Do any additional setup after loading the view.
}

#pragma mark - UIWebViewDelegate
- (void)webViewDidStartLoad:(UIWebView *)webView
{
    
}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alterview = [[UIAlertView alloc] initWithTitle:@"" message:[error localizedDescription]  delegate:nil cancelButtonTitle:nil otherButtonTitles:@"OK", nil];
    [alterview show];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden=NO;
    [self setTitle:_name];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
