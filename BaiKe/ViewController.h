//
//  ViewController.h
//  BaiKe
//
//  Created by yons on 13-7-28.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMobAdDelegateProtocol.h"
#import "BaseViewController.h"
@interface ViewController : BaseViewController <BaiduMobAdViewDelegate>
{
    BaiduMobAdView* sharedAdView;
}
@end
