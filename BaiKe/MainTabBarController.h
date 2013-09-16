//
//  MainTabBarController.h
//  BaiKe
//
//  Created by yons on 13-7-29.
//  Copyright (c) 2013年 yons. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainTabBarController : UITabBarController <UITabBarControllerDelegate>
{
    UIView      *_contentView;
    UIImageView *_selectView;
    int         _viewSelectedIndex;
}
@end
