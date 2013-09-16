//
//  HCNavigationBar.m
//  hubei10010
//
//  Created by huangzhan on 12-10-30.
//  Copyright (c) 2012年 hollycrm. All rights reserved.
//

#import "HCNavigationBar.h"
#define HCNAVIGATIONBARCOLOR [UIColor whiteColor]//RGB(200.0f, 0.0f, 0.0f)

@implementation HCNavigationBar
@synthesize showBackgroud,navigationBarBackgroundImage;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.barStyle = UIBarStyleBlackTranslucent;
        self.tintColor = HCNAVIGATIONBARCOLOR;//RGB(241.0f, 241.0f, 241.0f)
        self.frame = CGRectMake(0.0f, 0.0f, 320.0f, 46.5f);
        showBackgroud = YES;
        navigationBarBackgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
        navigationBarBackgroundImage.image = [UIImage imageNamed:@"navigationbar_bg.png"];
    }
    return self;
}

-(void) setBackgroundWith:(UIImage*)backgroundImage
{
    navigationBarBackgroundImage = [[UIImageView alloc] initWithFrame:self.frame];
    navigationBarBackgroundImage.image = backgroundImage;
    showBackgroud = YES;
    [self setNeedsDisplay];
}

// clear the background image and call setNeedsDisplay to force a redraw
-(void) clearBackground
{
    navigationBarBackgroundImage = nil;
    showBackgroud = NO;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    if (showBackgroud) {
        [navigationBarBackgroundImage.image drawInRect:rect];
        return;
    }
    [super drawRect:rect];
}

@end

//@implementation UINavigationBar (HCCategory)
//
//+ (Class)class {
//    return NSClassFromString(@"HCNavigationBar");
//}
//
//-(void)drawRect:(CGRect)rect {
//    [super drawRect:rect];
//
//    UIImage *backImage = [UIImage imageNamed:@"navigationbar_bg.png"];
//    //    //UIImage *backImage = [UIImage imageNamed:@"enter_center.png"];
//    //    //UIImage * backImage = [UIImage imageWithColor:[UIColor blueColor]];
//    [backImage drawInRect:rect];
//}
//@end

@implementation UIViewController (HCCategory)

- (void)setTitle:(NSString *)title {
    UILabel *titleLable = [[UILabel alloc] initWithFrame:CGRectZero];//CGRectZero是一个高度和宽度为零、位于(0,0)的矩形常量。需要创建边框但还不确定边框大小或位置时,可以使用此常量
    self.navigationItem.titleView = titleLable;
    titleLable.textAlignment = UITextAlignmentCenter;
    //titleLable.textColor     = RGB(0.0f, 0.0f, 0.0f);
    titleLable.backgroundColor = [UIColor clearColor];
    titleLable.textColor     = [UIColor whiteColor];
    titleLable.shadowColor   = [UIColor blackColor];//字体为白色时可给他添加黑色的阴影效果
    titleLable.shadowOffset  = CGSizeZero;
    titleLable.font          = [UIFont boldSystemFontOfSize:20.0f];
    titleLable.text = title;
    [titleLable sizeToFit];//在边框变化时改变
    titleLable.center        = CGPointMake(160.0f, 22.0f);
    titleLable.frame = self.view.frame;
}

@end