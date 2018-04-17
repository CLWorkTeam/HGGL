//
//  MPTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MPTableViewCell.h"
#import "HGLable.h"
#import "MenteeProject.h"
#import "TextFrame.h"
//#define contexFont [UIFont systemFontOfSize:14]
//#define titleFont [UIFont systemFontOfSize:14]
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
//#define magin 7
//#define Hmagin 5
@implementation MPTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(void)setMP:(MenteeProject *)MP
{
    _MP = MP;
    UILabel * PName = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    PName.text = MP.project_name;
    PName.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth - 2*CellWMargin, MP.projectNameH);
    [self.contentView addSubview:PName];
    UILabel *time = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
//    time.text = [NSString stringWithFormat:@"%@-%@",MP.project_star,MP.project_end];
    time.frame = CGRectMake(CellWMargin, CGRectGetMaxY(PName.frame)+CellHMargin, (HGScreenWidth - 2*CellWMargin)*0.8, minH);
    [self.contentView addSubview:time];
//    UILabel *CT = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
//    CT.text = MP.mentee_class;
//    CT.frame = CGRectMake((HGScreenWidth - 2*CellWMargin)*0.8,CGRectGetMaxY(PName.frame)+CellHMargin ,(HGScreenWidth - 2*CellWMargin)*0.2 , minH);
//    [self.contentView addSubview:CT];
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    MPTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MPTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
