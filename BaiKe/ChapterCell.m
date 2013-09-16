//
//  ChapterCell.m
//  BaiKe
//
//  Created by jianzhongliu on 7/31/13.
//  Copyright (c) 2013 yons. All rights reserved.
//

#import "ChapterCell.h"

@implementation ChapterCell
@synthesize labTitle = _labTitle;
@synthesize labDescription = _labDescription;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _labTitle = [[UILabel alloc] initWithFrame:CGRectMake(5,5, 300, 20)];
        _labTitle.font = [UIFont boldSystemFontOfSize: 14.0f];
        _labTitle.textColor = [UIColor blackColor];
        [self addSubview:_labTitle];
        
        _labDescription = [[UILabel alloc] initWithFrame:CGRectMake(5,25, 300, 35)];
        _labDescription.numberOfLines = 0;
        _labDescription.lineBreakMode = 0;
        _labDescription.font = [UIFont systemFontOfSize:12];
        _labDescription.textColor = [UIColor grayColor];
        [self addSubview:_labDescription];
        self.selectionStyle = 2;
    }
    return self;
}

-(void)setTitleFontColor:(UIColor *)color{
    _labTitle.textColor = color;
}

-(void)setTitle:(NSString *)title{
    _labTitle.text = title;
}

-(void)setDescription:(NSString *)description{
    _labDescription.text = description;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

//-(void)setTitleHighlightKeyWord:(NSString *)title keyword:(NSString *)keyword{
//    [_labTitle cnv_setUIlabelTextColor:[UIColor redColor] andKeyWordColor:[UIColor blueColor]];
//    [_labTitle cnv_setUILabelText:title andKeyWord:keyword];
//}
//
//-(void)setdescriptionHighlightKeyWord:(NSString *)title keyword:(NSString *)keyword{
//    [_labDescription cnv_setUIlabelTextColor:[UIColor redColor] andKeyWordColor:[UIColor blueColor]];
//    [_labDescription cnv_setUILabelText:title andKeyWord:keyword];
//}

@end
