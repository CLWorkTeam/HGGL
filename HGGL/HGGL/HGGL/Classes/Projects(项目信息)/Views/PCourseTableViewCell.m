//
//  PCourseTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-6.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PCourseTableViewCell.h"
#import "HGLable.h"
#import "PCourse.h"
#import "TextFrame.h"
//#define margin 15
//#define labHeigh 25
#define Width 65
//#define Hmargin 5
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation PCourseTableViewCell

-(void)setPC:(PCourse *)PC
{
    _PC = PC;
    UIImageView *ima = [[UIImageView alloc]init];
    CGFloat NH = [TextFrame frameOfText:@"呵呵大" With:[UIFont fontWithName:@"Helvetica-Bold" size:HGFont] Andwidth:(HGScreenWidth-2*CellWMargin)].height;
    ima.frame = CGRectMake(0, NH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    CGFloat W = 40;
    CGFloat LWidth = HGScreenWidth - 2*CellWMargin-2*CellHMargin;
    UILabel *courseName = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    courseName.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGFont];
    courseName.text = PC.course_name;
    [self.contentView addSubview:courseName];
    courseName.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth - 2*CellWMargin, PC.CnameH);
    UILabel *teacherName = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    teacherName.text = @"教师:";
    
    teacherName.frame = CGRectMake(CellWMargin, CGRectGetMaxY(courseName.frame)+CellHMargin, W, minH);
    [self.contentView addSubview:teacherName];
    UILabel *teacherNameV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    teacherNameV.text = PC.course_teacher;
    teacherNameV.frame = CGRectMake(CGRectGetMaxX(teacherName.frame)+CellHMargin, CGRectGetMaxY(courseName.frame)+CellHMargin, 65, minH);
    [self.contentView addSubview:teacherNameV];
    UILabel *time = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    time.text = @"时间:";
    time.frame = CGRectMake(CGRectGetMaxX(teacherNameV.frame)+CellHMargin, CGRectGetMaxY(courseName.frame)+CellHMargin,W, minH);
    [self.contentView addSubview:time];
    UILabel *timeV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor ]];
    timeV.text = PC.course_start;
    timeV.frame = CGRectMake(CGRectGetMaxX(time.frame)+CellHMargin, CGRectGetMaxY(courseName.frame)+CellHMargin, LWidth-2*W, minH);
    [self.contentView addSubview:timeV];
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    PCourseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PCourseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
