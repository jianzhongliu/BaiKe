//
//  ListenViewController.m
//  BaiKe
//
//  Created by jianzhongliu on 7/29/13.
//  Copyright (c) 2013 yons. All rights reserved.
//

#import "ListenViewController.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"

#define APPID @"51ef8027"

@interface ListenViewController ()
{
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
    bool _isCancel;
}
@end

@implementation ListenViewController

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
    [self.view setBackgroundColor:[UIColor whiteColor]];
    UIButton *leftBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBut addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchDown];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftBut];
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer createWithParams:initString delegate:self];
    _iFlySpeechSynthesizer.delegate = self;
    
    // 设置语音合成的参数
    [_iFlySpeechSynthesizer setParameter:@"speed" value:@"50"];//合成的语速,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"volume" value:@"50"];//合成的音量;取值范围 0~100
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [_iFlySpeechSynthesizer setParameter:@"voice_name" value:@"xiaoyan"];
    [_iFlySpeechSynthesizer setParameter:@"sample_rate" value:@"8000"];//音频采样率,目前支持的采样率有 16000 和 8000;
    
    UIButton *bu = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    bu.frame = CGRectMake(0, 0, 100, 40);
    [bu setTitle:@"播放" forState:UIControlStateNormal];
    [bu addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview:bu];
    
	// Do any additional setup after loading the view.
}
-(void)goBack{
    [_iFlySpeechSynthesizer stopSpeaking];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)click{
    NSString *str = [[NSString alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"01" ofType:@"docx"] encoding:NSUTF8StringEncoding error:nil];
    NSLog(@"====%@",str);
    [_iFlySpeechSynthesizer startSpeaking:@"       科大讯飞作为中国最大的智能语音技术提供商，在智能语音技术领域有着长期的研究积累、\
     并在中文语音合成、语音识别、口技术为产业化方\
     测试指标冠军、通用测试指标亚军。"];
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidDisappear:(BOOL)animated
{
    [_iFlySpeechSynthesizer setDelegate:nil];
    [_iFlySpeechSynthesizer stopSpeaking];
}
#pragma mark - IFlySpeechSynthesizerDelegate

/**
 * @fn      onSpeakBegin
 * @brief   开始播放
 *
 * @see
 */
- (void) onSpeakBegin
{
        _isCancel = NO;
    //    [_popUpView setText:@"开始播放"];
    //    [self.view addSubview:_popUpView];
}

/**
 * @fn      onBufferProgress
 * @brief   缓冲进度
 *
 * @param   progress            -[out] 缓冲进度
 * @param   msg                 -[out] 附加信息
 * @see
 */
- (void) onBufferProgress:(int) progress message:(NSString *)msg
{
    NSLog(@"bufferProgress:%d,message:%@",progress,msg);
}

/**
 * @fn      onSpeakProgress
 * @brief   播放进度
 *
 * @param   progress            -[out] 播放进度
 * @see
 */
- (void) onSpeakProgress:(int) progress
{
    NSLog(@"play progress:%d",progress);
}

/**
 * @fn      onSpeakPaused
 * @brief   暂停播放
 *
 * @see
 */
- (void) onSpeakPaused
{
    //    [_popUpView setText:@"播放暂停"];
    //    [self.view addSubview:_popUpView];
}

/**
 * @fn      onSpeakResumed
 * @brief   恢复播放
 *
 * @see
 */
- (void) onSpeakResumed
{
    //    [_popUpView setText:@"播放继续"];
    //    [self.view addSubview:_popUpView];
}

/**
 * @fn      onCompleted
 * @brief   结束回调
 *
 * @param   error               -[out] 错误对象
 * @see
 */
- (void) onCompleted:(IFlySpeechError *) error
{
    //    _startBtn.enabled = YES;
    //    _pauseBtn.enabled = NO;
    //    _cancelBtn.enabled = NO;
    //    _resumeBtn.enabled = NO;
    //    NSString *text ;
        if (_isCancel) {
//            text = @"合成取消";
        }
        else if (error.errorCode ==0 ) {
//            text = @"合成完成";
            //_resultView.text = _result;
        }
        else
        {
      NSString *      text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
            NSLog(@"%@",text);
        }
    //    [_popUpView setText: text];
    //    [self.view addSubview:_popUpView];
}

/**
 * @fn      onSpeakCancel
 * @brief   正在取消
 *
 * @see
 */
- (void) onSpeakCancel
{
    //    [_popUpView setText:@"播放取消"];
    //    [self.view addSubview:_popUpView];
        _isCancel = YES;
}


@end
