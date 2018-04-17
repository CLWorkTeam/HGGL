//
//  TeacherListTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacherListTableViewCell.h"
#import "teacBaseInfo.h"
#import "HGLable.h"
#import "TextFrame.h"
#define teacherH 5
@interface TeacherListTableViewCell()
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *sex;
@property (nonatomic,weak) UILabel *tel;
@property (nonatomic,weak) UILabel *type;
@property (nonatomic,weak) UILabel *titleN;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *area;
@property (nonatomic,weak) UILabel *profN;
@property (nonatomic,weak) UILabel *prof;
@end
@implementation TeacherListTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.name = name;
//    [self.contentView addSubview:name];
//    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.sex = sex;
//    [self.contentView addSubview:sex];
//    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.tel = tel;
//    [self.contentView  addSubview:tel];
//    UILabel *type = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.type = type;
//    [self.contentView addSubview:type];
//    UILabel *titleN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    titleN.text = @"单位职务";
//    self.titleN = titleN;
//    [self.contentView addSubview:titleN];
//    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.title = title;
//    [self.contentView addSubview:title];
//    UILabel *area = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.area = area;
//    [self.contentView addSubview:area];
//    UILabel *profN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    profN.text = @"专业领域";
//    self.profN = profN;
//    [self.contentView addSubview:profN];
//    UILabel *prof = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
//    self.prof = prof;
//    [self.contentView addSubview:prof];
    
}
-(void)setInfo:(teacBaseInfo *)info
{
    
    _info = info;
    //姓名
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    NSString *nameStr = [info.teacher_name stringByReplacingOccurrencesOfString:@" " withString:@""];
    self.name = name;
    [self.contentView addSubview:name];
    
    //性别
    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.sex = sex;
    sex.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:sex];
    
    //联系方式
    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.tel = tel;
    tel.backgroundColor = [UIColor clearColor];
    [self.contentView  addSubview:tel];
    
    //类型
    UILabel *type = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    self.type = type;
    [self.contentView addSubview:type];
    
    //
    UILabel *titleN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    titleN.text = @"单位职务:";
    self.titleN = titleN;
    [self.contentView addSubview:titleN];
    //
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.title = title;
    [self.contentView addSubview:title];

    
    UILabel *profN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    profN.text = @"专业领域:";
    self.profN = profN;
    [self.contentView addSubview:profN];
    
    UILabel *prof = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.prof = prof;
    [self.contentView addSubview:prof];
    
    self.name.frame = CGRectMake(CellWMargin,teacherH, HGScreenWidth*0.2-CellWMargin, minH);
    self.name.text = nameStr;
    self.sex.frame = CGRectMake(CGRectGetMaxX(self.name.frame), teacherH, HGScreenWidth*0.06, minH);
    self.sex.text = info.teacher_sex;
    self.tel.frame = CGRectMake(CGRectGetMaxX(self.sex.frame)+5, teacherH, HGScreenWidth*0.3, minH);
   // NSString *telStr = info.teacher_tel;

    self.tel.text = info.teacher_tel;
    self.type.frame = CGRectMake(CGRectGetMaxX(self.tel.frame)+5, teacherH, HGScreenWidth*0.44-CellWMargin, minH);
    if (info.teacher_type.length == 0) {
        self.type.text = @"";
    }else
    {
        NSString *str = [NSString stringWithFormat:@"%@",info.teacher_type];
        self.type.text = str;
    }

    self.titleN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.name.frame)+teacherH, HGScreenWidth*0.25-CellWMargin, minH);
    
    self.title.frame = CGRectMake(CGRectGetMaxX(self.titleN.frame)+teacherH,CGRectGetMaxY(self.name.frame)+teacherH, HGScreenWidth*0.75-teacherH-CellWMargin, minH);
    self.title.text = info.teacher_title;
    
    self.profN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.title.frame)+teacherH, HGScreenWidth*0.25-CellWMargin, minH);
    self.prof.frame = CGRectMake(CGRectGetMaxX(self.profN.frame)+teacherH, CGRectGetMaxY(self.title.frame)+teacherH, HGScreenWidth*0.75-teacherH-CellWMargin, minH);
    self.prof.text = info.teacher_prof;
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    TeacherListTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TeacherListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
