//
//  AppDelegate.h
//  BaiKe
//
//  Created by yons on 13-7-28.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
#import "HCNavigationBar.h"
#define APPID @"51ef8027"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
UINavigationController *navController;
}
@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

+ (id)G;
@end
