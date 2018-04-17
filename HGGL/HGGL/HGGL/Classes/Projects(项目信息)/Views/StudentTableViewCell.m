//
//  StudentTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "StudentTableViewCell.h"
#import "HGLable.h"
#import "MenteeList.h"
#import "TextFrame.h"
//#define margin 8
//#define labHeigh 25
#define Width 65
//#define Hmargin 5
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation StudentTableViewCell

+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    StudentTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StudentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
-(void)setMen:(MenteeList *)men
{
    _men = men;
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    name.text = men.mentee_name;
    CGFloat width = HGScreenWidth-2*CellWMargin-2*CellHMargin;
    name.frame = CGRectMake(CellWMargin, CellHMargin, width*0.3, minH);
    [self.contentView addSubview:name];
    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    sex.text = men.mentee_sex;
    sex.frame = CGRectMake(CGRectGetMaxX(name.frame)+CellHMargin, CellHMargin, width*0.1, minH);
    [self.contentView addSubview:sex];
    UILabel *group = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    group.text = men.mentee_group;
    group.frame = CGRectMake(CGRectGetMaxX(sex.frame)+width*0.05+CellHMargin, CellHMargin, width*0.15, minH);
    [self.contentView addSubview:group];
    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    tel.text = men.mentee_tel;
    tel.frame = CGRectMake(CGRectGetMaxX(group.frame)+CellHMargin, CellHMargin, width*0.4, minH);
    [self.contentView addSubview:tel];
    CGFloat width1 = HGScreenWidth-2*CellWMargin-CellHMargin;
    UILabel *job = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    job.text = @"单位/职务";
    job.frame = CGRectMake(CellWMargin, CGRectGetMaxY(name.frame)+CellHMargin, width1*0.3, minH);
    [self.contentView addSubview:job];
//    UILabel *duty = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
//    duty.numberOfLines = 0;
//    duty.text = [NSString stringWithFormat:@"%@/%@",men.mentee_workUnit,men.mentee_duty];
//    CGFloat dutyH = [TextFrame frameOfText:men.mentee_duty With:[UIFont systemFontOfSize:14] Andwidth:width*0.7].height;
//    duty.frame = CGRectMake(CGRectGetMaxX(job.frame)+CellHMargin, CGRectGetMaxY(name.frame)+CellHMargin, width1*0.7, men.unitDutyH);
//    [self.contentView addSubview:duty];
}
@end
