//
//  PCourseTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-6.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PCourseTableViewCell.h"
#import "HGLable.h"
//#import "PCourse.h"
#import "HGPCourseModel.h"
#import "TextFrame.h"
//#define margin 15
//#define labHeigh 25
#define Width 65
//#define Hmargin 5
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@interface PCourseTableViewCell ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *courseName;
@property (nonatomic,weak) UILabel *teacherName;
@end

@implementation PCourseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setUpAllSubViews
{
    UIImageView *ima = [[UIImageView alloc]init];
    self.ima = ima;
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    [self.contentView addSubview:ima];
    
    UILabel *courseName = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    courseName.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGFont];
    [self.contentView addSubview:courseName];
    self.courseName = courseName;
    
    UILabel *teacherName = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.teacherName = teacherName;
    [self.contentView addSubview:teacherName];
}
-(void)setPC:(HGPCourseModel *)PC
{
    _PC = PC;
    
    self.courseName.text = PC.course_name;
    self.teacherName.text = [NSString stringWithFormat:@"教师：%@",PC.course_teacher];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat H = 30;
    self.ima.frame = CGRectMake(0, H/2-CellWMargin/2, CellWMargin, CellWMargin);
    self.courseName.frame = CGRectMake(CellWMargin, 0, HGScreenWidth - 2*CellWMargin, H);
    self.teacherName.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.courseName.frame), self.courseName.width, H);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    PCourseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PCourseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
@end
