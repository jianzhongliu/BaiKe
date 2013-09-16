//
//  ListenViewController.h
//  BaiKe
//
//  Created by jianzhongliu on 7/29/13.
//  Copyright (c) 2013 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "iflyMSC/IFlySpeechSynthesizerDelegate.h"
#import "iflyMSC/IFlySpeechRecognizer.h"
@interface ListenViewController : BaseViewController <IFlySpeechSynthesizerDelegate>

@end
