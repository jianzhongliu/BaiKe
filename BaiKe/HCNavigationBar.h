//
//  HCNavigationBar.h
//  hubei10010
//
//  Created by huangzhan on 12-10-30.
//  Copyright (c) 2012年 hollycrm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCNavigationBar : UINavigationBar{
    BOOL showBackgroud;
    UIImageView * navigationBarBackgroundImage;
}
@property BOOL showBackgroud;
@property (nonatomic, retain) UIImageView *navigationBarBackgroundImage;

-(void) setBackgroundWith:(UIImage*)backgroundImage;
-(void) clearBackground;
@end



