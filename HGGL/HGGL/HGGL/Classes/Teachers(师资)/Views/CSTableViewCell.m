//
//  CSTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-27.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CSTableViewCell.h"
#import "HGLable.h"
#import "CourseScore.h"
#import "TextFrame.h"
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation CSTableViewCell

-(void)setCs:(CourseScore *)cs
{
    _cs = cs;
    CGFloat VWidth = HGScreenWidth-Width-2*CellWMargin-CellHMargin;
    UILabel *student = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    student.text = @"学       员:";
    student.frame = CGRectMake(CellWMargin,CellHMargin, Width, minH);
    [self.contentView addSubview:student];
    UILabel *studentV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    studentV.text = cs.student_name;
    studentV.frame = CGRectMake(CGRectGetMaxX(student.frame)+CellHMargin,CellHMargin, VWidth, minH);
    [self.contentView addSubview:studentV];
    UILabel *score = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    score.text = @"满  意  度:";
    score.frame = CGRectMake(CellWMargin,CGRectGetMaxY(student.frame)+CellHMargin, Width, minH);
    [self.contentView addSubview:score];
    UILabel *scoreV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    scoreV.text = cs.student_satisf;
    scoreV.frame = CGRectMake(CGRectGetMaxX(score.frame)+CellHMargin, CGRectGetMaxY(student.frame)+CellHMargin, VWidth, minH);
    [self.contentView addSubview:scoreV];
    UILabel *date = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    date.text = @"评价时间:";
    date.frame = CGRectMake(CellWMargin,CGRectGetMaxY(score.frame)+CellHMargin, Width, minH);
    [self.contentView addSubview:date];
    UILabel *dateV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    dateV.text = cs.student_date;
    dateV.frame = CGRectMake(CGRectGetMaxX(date.frame)+CellHMargin, CGRectGetMaxY(score.frame)+CellHMargin, VWidth, minH);
    [self.contentView addSubview:dateV];
    UILabel *evaluate = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    evaluate.frame = CGRectMake(CellWMargin, CGRectGetMaxY(date.frame)+CellHMargin, Width, minH);
    evaluate.text = @"评价详情:";
    [self.contentView addSubview:evaluate];
    UILabel *evaluateV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    evaluateV.backgroundColor = [UIColor redColor];
    evaluate.backgroundColor = [UIColor greenColor];
    evaluateV.text = cs.student_evaluation;
    evaluateV.frame = CGRectMake(CGRectGetMaxX(evaluate.frame)+CellHMargin  , CGRectGetMaxY(date.frame)+CellHMargin, VWidth, cs.evaluateH);
    [self.contentView addSubview:evaluateV];

    
}

+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    CSTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CSTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}

@end
