//
//  HGLeftTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGLeftTableViewCell.h"
#import "HGLable.h"

@interface HGLeftTableViewCell ()
@property (nonatomic,weak) UILabel *lable;
@end
@implementation HGLeftTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *lable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
//        lable.backgroundColor = HGGrayColor;
        self.lable = lable;
        [self.contentView addSubview:lable];
    }
    return self;
}
-(void)setIsSelected:(BOOL )isSelected
{
    _isSelected =isSelected;
    if (isSelected) {
        self.lable.textColor = HGMainColor;
        self.backgroundColor = [UIColor whiteColor];
        
    }else
    {
        self.lable.textColor = [UIColor blackColor];
        self.backgroundColor = HGGrayColor;
    }
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.lable.text = titleStr;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lable.frame = self.bounds;
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGLeftTableViewCell";
    HGLeftTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGLeftTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
