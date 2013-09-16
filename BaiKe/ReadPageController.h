//
//  ReadPageController.h
//  BaiKe
//
//  Created by yons on 13-7-28.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseViewController.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"

@interface ReadPageController : BaseViewController <UITextViewDelegate, IFlySpeechSynthesizerDelegate>
{
    NSString *_content;
    UIButton *listButton;
    int page;
}
@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSString *title;
@end
