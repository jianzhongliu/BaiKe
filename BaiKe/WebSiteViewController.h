//
//  WebSiteViewController.h
//  BaiKe
//
//  Created by yons on 13-8-4.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "BaseViewController.h"

@interface WebSiteViewController : BaseViewController <UIWebViewDelegate>{
    UIWebView *webSite;
    NSString *_url;
    NSString *_name;
}
@property (retain , nonatomic) NSString *url;
@property (retain , nonatomic) NSString *name;
@end
