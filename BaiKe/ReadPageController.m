//
//  ReadPageController.m
//  BaiKe
//
//  Created by yons on 13-7-28.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import "ReadPageController.h"
#import "iflyMSC/IFlySpeechSynthesizer.h"
#import "AVFoundation/AVAudioSession.h"
#import "AVFoundation/AVAudioPlayer.h"

#define APPID @"51ef8027"
#define pageHight 460
#define pageSize 500
@interface ReadPageController ()
{
    int allPage;
    int currentPage;
    UITextView *text;
    BOOL tapYN;
    IFlySpeechSynthesizer *_iFlySpeechSynthesizer;
    bool _isCancel;
}
@end

@implementation ReadPageController
@synthesize content=_content;
@synthesize title;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.content=[NSString string];
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor lightGrayColor]];
    [self setTitle:[NSString stringWithFormat:@"%@",self.title]];
    listButton = [UIButton buttonWithType:UIButtonTypeCustom];
    listButton.tag=101;
    [listButton setBackgroundImage:[UIImage imageNamed:@"navbuttonnormal.png"] forState:UIControlStateNormal];
    [listButton setFrame:CGRectMake(260.0, 6.0, 55.0, 32.0)];
    [listButton addTarget:self action:@selector(listen:) forControlEvents:UIControlEventTouchUpInside];
    listButton.titleLabel.font = [UIFont systemFontOfSize:14.0f];
    [listButton setTitle:@"听书" forState:UIControlStateNormal];
    UIBarButtonItem *listBarButton = [[UIBarButtonItem alloc] initWithCustomView:listButton] ;
    [self.navigationItem setRightBarButtonItem:listBarButton];
    
//    NSString *str=[[NSString alloc]initWithContentsOfFile:[[NSBundle mainBundle]pathForResource:@"shalou" ofType:@"txt"] encoding:NSUTF8StringEncoding error:nil];
    text = [[UITextView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.bounds.size.height-40)];
    text.delegate = self;
    text.backgroundColor = [UIColor lightGrayColor];
    [self.view addSubview: text];
    
    text.text = _content;
    text.font = [UIFont systemFontOfSize:18];
    text.textColor = [UIColor blackColor];
    text.editable = NO;
    text.scrollEnabled = YES;
    //计算textView的总页数
    allPage = text.contentSize.height / pageHight + 1;
    //设置当前页为1
    currentPage = 1;

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDown)];
    [text addGestureRecognizer:tap];
    tapYN = YES;
    
    NSString *initString = [[NSString alloc] initWithFormat:@"appid=%@",APPID];
    _iFlySpeechSynthesizer = [IFlySpeechSynthesizer createWithParams:initString delegate:self];
    _iFlySpeechSynthesizer.delegate = self;
    
    // 设置语音合成的参数
    [_iFlySpeechSynthesizer setParameter:@"speed" value:@"50"];//合成的语速,取值范围 0~100
    [_iFlySpeechSynthesizer setParameter:@"volume" value:@"50"];//合成的音量;取值范围 0~100
    //发音人,默认为”xiaoyan”;可以设置的参数列表可参考个 性化发音人列表;
    [_iFlySpeechSynthesizer setParameter:@"voice_name" value:@"xiaoyan"];
    [_iFlySpeechSynthesizer setParameter:@"sample_rate" value:@"8000"];//音频采样率,目前支持的采样率有 16000 和 8000;
}
-(void)popself{
    [_iFlySpeechSynthesizer stopSpeaking];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)listen:(id)sender{
    page = 1;
    if([((UIButton *)sender).titleLabel.text isEqualToString:@"停止"]){
        [_iFlySpeechSynthesizer stopSpeaking];
        [((UIButton *)sender) setTitle:@"听书" forState:UIControlStateNormal];
    }else{
        [((UIButton *)sender) setTitle:@"停止" forState:UIControlStateNormal];
        if(self.content.length < pageSize){
            [_iFlySpeechSynthesizer startSpeaking:self.content];
        }else{
            NSLog(@"%d,....%d", 0, pageSize*page);
            [_iFlySpeechSynthesizer startSpeaking:[self.content substringWithRange:NSMakeRange(0, pageSize)]];
        }
    }
}

-(void)tapDown{
    if(tapYN){
        tapYN =  !tapYN;
        [UIView animateWithDuration:0.0 animations:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES];
            [self.navigationController setNavigationBarHidden:YES];
        } completion:^(BOOL finished) {
            text.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        }];
    }else{
        tapYN = !tapYN;
        [UIView animateWithDuration:0.3 animations:^{
            text.canCancelContentTouches=YES;
            [[UIApplication sharedApplication] setStatusBarHidden:NO];
            [self.navigationController setNavigationBarHidden:NO];
        } completion:^(BOOL finished) {
            text.canCancelContentTouches=NO;
            text.frame = CGRectMake(0, 0, 320, self.view.bounds.size.height);
        }];
    }
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    [_iFlySpeechSynthesizer setDelegate:nil];
    [_iFlySpeechSynthesizer stopSpeaking];
}

#pragma mark - UITextViewDelegate 阻止复制，剪切等功能
-(BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    //    UITextView *text=(UITextView *)sender;
    [UIMenuController sharedMenuController].menuVisible = NO;  //donot display the menu
    return NO;
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
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    [[AVAudioSession sharedInstance] setActive: YES error: nil];
    
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];//用于开关
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
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
    
    if (_isCancel) {
        //            text = @"合成取消";
    }
    else if (error.errorCode ==0 ) {
        //            text = @"合成完成";
        //_resultView.text = _result;
    }
    else
    {
        NSString *      text0 = [NSString stringWithFormat:@"发生错误：%d %@", error.errorCode, error.errorDesc];
        NSLog(@"%@",text0);
    }
    
    if([[listButton titleForState:UIControlStateNormal] isEqualToString:@"听书"]){
        return;
    }
    if(page == (self.content.length/pageSize + 1)){
        [listButton setTitle:@"听书" forState:UIControlStateNormal];
        page=1;
        return;
    }
    
//    [listButton setTitle:@"听书" forState:UIControlStateNormal];
    if(self.content.length > pageSize){
        page ++;
        NSLog(@"%d,....%d",self.content.length, pageSize);
        if(self.content.length < page*pageSize){
            NSLog(@"%d,....%d=======%@",pageSize*(page - 1), self.content.length,[self.content substringWithRange:NSMakeRange(pageSize*(page - 1), self.content.length-(page-1)*pageSize)]);
            [_iFlySpeechSynthesizer startSpeaking:[self.content substringWithRange:NSMakeRange(pageSize*(page - 1), self.content.length-(page-1)*pageSize)]];
        }else{
            NSLog(@"%d,....%d", pageSize*(page -1), pageSize*page);
            [_iFlySpeechSynthesizer startSpeaking:[self.content substringWithRange:NSMakeRange(pageSize*(page -1), pageSize)]];
        }
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
