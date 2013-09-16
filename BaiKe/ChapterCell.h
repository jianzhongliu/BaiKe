//
//  ChapterCell.h
//  BaiKe
//
//  Created by jianzhongliu on 7/31/13.
//  Copyright (c) 2013 yons. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "cnvUILabel.h"

@interface ChapterCell : UITableViewCell
{
    UILabel *_labTitle;
    UILabel *_labDescription;

}
@property (strong , nonatomic) UILabel * labTitle;
@property (strong , nonatomic) UILabel *labDescription;


-(void)setTitleFontColor:(UIColor *)color;
-(void)setTitle:(NSString *)title;
-(void)setDescription:(NSString *)description;

@end
