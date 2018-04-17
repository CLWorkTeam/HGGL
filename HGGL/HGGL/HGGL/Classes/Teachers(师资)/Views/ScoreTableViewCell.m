//
//  ScoreTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ScoreTableViewCell.h"
#import "HGLable.h"
#import "ScoreList.h"
#import "TextFrame.h"
#define contexFont [UIFont systemFontOfSize:14]
#define titleFont [UIFont systemFontOfSize:14]
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
//#define magin 7
//#define Hmagin 5
@interface ScoreTableViewCell()
@property (nonatomic,weak) UILabel *courseN;
@property (nonatomic,weak) UILabel *courseNV;
@property (nonatomic,weak) UILabel *projectN;
@property (nonatomic,weak) UILabel *projectNV;
@property (nonatomic,weak) UILabel *scoreN;
@property (nonatomic,weak) UILabel *scoreNV;
@property (nonatomic,weak) UILabel *dateN;
@property (nonatomic,weak) UILabel *dateNV;


@end
@implementation ScoreTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    UILabel *course = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    course.text = @"课    程:";
//    self.courseN = course;
//    [self.contentView addSubview:course];
//    UILabel *courseV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.courseNV = courseV;
//    [self.contentView addSubview:courseV];
//    UILabel *project = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    project.text = @"项目名称:";
//    self.projectN = project;
//    [self.contentView addSubview:project];
//    UILabel *projectV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.projectNV = projectV;
//    [self.contentView addSubview:projectV];
//    UILabel *score = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    score.text = @"课程评分:";
//    self.scoreN = score;
//    [self.contentView addSubview:score];
//    UILabel *scoreV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.scoreNV = scoreV;
//    [self.contentView addSubview:scoreV];
//    UILabel *date = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    self.dateN = date;
//    date.text = @"授课日期:";
//    [self.contentView addSubview:date];
//    UILabel *dateV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.dateNV = dateV;
//    [self.contentView addSubview:dateV];
}
-(void)setScore:(ScoreList *)score
{
    _score = score;
    
    UILabel *course = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    course.text = @"课       程:";
    self.courseN = course;
    [self.contentView addSubview:course];
    UILabel *courseV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.courseNV = courseV;
    [self.contentView addSubview:courseV];
    
    UILabel *project = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    project.text = @"项目名称:";
    self.projectN = project;
    [self.contentView addSubview:project];
    UILabel *projectV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.projectNV = projectV;
    [self.contentView addSubview:projectV];
    
    UILabel *scoreN = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    scoreN.text = @"课程评分:";
    self.scoreN = scoreN;
    [self.contentView addSubview:scoreN];
    UILabel *scoreV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.scoreNV = scoreV;
    [self.contentView addSubview:scoreV];
    
    UILabel *date = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    self.dateN = date;
    date.text = @"授课日期:";
    [self.contentView addSubview:date];
    UILabel *dateV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.dateNV = dateV;
    [self.contentView addSubview:dateV];
    
    
    self.courseN.frame = CGRectMake(CellWMargin, CellHMargin, Width, minH);
    self.courseNV.text = score.course_name;
    self.courseNV.frame = CGRectMake(CellWMargin+CellHMargin+Width,CellHMargin, HGScreenWidth - Width-2*CellWMargin-CellHMargin, score.courseNameH);
    self.projectN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.courseNV.frame)+CellHMargin, Width, minH);
    self.projectNV.text = score.project_name;
    self.projectNV.frame = CGRectMake(CellHMargin+CellWMargin+Width, CGRectGetMaxY(self.courseNV.frame)+CellHMargin, HGScreenWidth - Width-2*CellWMargin-CellHMargin, score.projectNameH);
    self.scoreN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.projectNV.frame)+CellHMargin, Width, minH);
    self.scoreNV.text = score.course_score;
    self.scoreNV.frame = CGRectMake(CellHMargin+CellWMargin+Width, CGRectGetMaxY(self.projectN.frame)+CellHMargin, HGScreenWidth - Width-2*CellWMargin-CellHMargin, minH);
    self.dateN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.scoreN.frame)+CellHMargin, Width, minH);
    HGLog(@"时间%@",score.course_date);
    self.dateNV.text = score.course_date;
    self.dateNV.frame = CGRectMake(CellHMargin+CellWMargin+Width, CGRectGetMaxY(self.scoreNV.frame)+CellHMargin, HGScreenWidth - Width-2*CellWMargin-CellHMargin, minH);

}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    ScoreTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ScoreTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
