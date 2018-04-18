//
//  CourseTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CourseTableViewCell.h"
#import "HGLable.h"
#import "CourseFrame.h"
#import "CourseList.h"
#import "TextFrame.h"
#define Width 35
//#define minH 30
//#define magin 15
#define TitleFont [UIFont systemFontOfSize:14]
#define ContexFont [UIFont systemFontOfSize:14]

@interface CourseTableViewCell()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *dec;
@property (nonatomic,weak) UILabel *note;
@property (nonatomic,weak) UILabel *decV;
@property (nonatomic,weak) UILabel *noteV;
@end
@implementation CourseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:16 Color:[UIColor blackColor]];
//    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:16];
//    [self.contentView  addSubview:title];
//    self.title = title;
//    UILabel *dec = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    dec.text = @"简介";
//    [self.contentView addSubview:dec];
//    self.dec = dec;
//    UILabel *decV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:13 Color:[UIColor blackColor]];
//    [self.contentView addSubview:decV];
//    self.decV = decV;
//    UILabel *note = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
//    note.text = @"备注";
//    [self.contentView addSubview:note];
//    self.note = note;
//    UILabel *noteV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:13 Color:[UIColor blackColor]];
//    [self.contentView addSubview:noteV];
//    self.noteV = noteV;
    
}

-(void)setCourseF:(CourseFrame *)courseF
{
    _courseF = courseF;
    
    UIImageView *ima = [[UIImageView alloc]init];
    CGFloat imaH = [TextFrame frameOfText:@"马克思主义" With:[UIFont fontWithName:@"Helvetica-Bold" size:14] Andwidth:HGScreenWidth-CellWMargin*2].height;
    ima.frame = CGRectMake(0, imaH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    
    //课程名称
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.text = courseF.course.course_name;
    [self.contentView  addSubview:title];
    self.title = title;
    
    //简介
    UILabel *dec = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
    dec.text = @"简介:";
    [self.contentView addSubview:dec];
    self.dec = dec;
    UILabel *decV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView addSubview:decV];
    decV.text = courseF.course.course_dec;
    self.decV = decV;
    
    //备注
    UILabel *note = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
    note.text = @"备注:";
    [self.contentView addSubview:note];
    self.note = note;
    UILabel *noteV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    noteV.text = courseF.course.course_note;
    [self.contentView addSubview:noteV];
    self.noteV = noteV;
    
    //计算frame和赋text
    _title.text = courseF.course.course_name;
    self.title.frame = courseF.course_nameF;
    self.dec.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.title.frame)+CellHMargin, Width, minH);
    self.decV.frame = courseF.course_decF;
    self.decV.text = courseF.course.course_dec;
    self.note.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.decV.frame)+CellHMargin, Width, minH);
    self.noteV.frame = courseF.course_noteF;
    self.noteV.text = courseF.course.course_note;
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"CourseTableViewCell";
    CourseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[CourseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
