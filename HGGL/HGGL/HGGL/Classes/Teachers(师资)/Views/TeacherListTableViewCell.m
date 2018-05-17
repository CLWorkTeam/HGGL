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
@property (nonatomic,weak) UIView *grayView;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *tel;
@property (nonatomic,weak) UILabel *type;
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *sex;

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
    UIView *grayView = [[UIView alloc] init];
    [self.contentView addSubview:grayView];
    grayView.backgroundColor = HGGrayColor;
    self.grayView = grayView;
    grayView.layer.masksToBounds = YES;
    grayView.layer.cornerRadius = 5;
    
    //姓名
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.name = name;
    [self.grayView addSubview:name];
    
    //性别
    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.sex = sex;
    sex.backgroundColor = [UIColor clearColor];
    [self.grayView addSubview:sex];
    
    //联系方式
    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.tel = tel;
    tel.backgroundColor = [UIColor clearColor];
    [self.grayView  addSubview:tel];
    
    //类型
    UILabel *type = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
    self.type = type;
    [self.grayView addSubview:type];
    
    
    //单位职务
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.title = title;
    [self.grayView addSubview:title];
}
-(void)setInfo:(teacBaseInfo *)info
{
    
    _info = info;
    self.name.text = info.teacher_name;
    self.sex.text = info.teacher_sex;
    self.type.text = info.teacher_type;
    self.title.text = [NSString stringWithFormat:@"单位职务：%@ %@",info.teacher_workUnit,info.teacher_title];
    self.tel.text = [NSString stringWithFormat:@"联系电话：%@",info.teacher_tel];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat WMargin = 10;
    CGFloat WMar = 5;
    CGFloat Hmar = 20;
    CGFloat H = 30;
    self.grayView.frame = CGRectMake(WMargin, 0, self.width-2*WMargin, self.height-Hmar);
    self.name.frame = CGRectMake(WMar, 0, self.grayView.width/3-WMar, H);
    self.sex.width = 15;
    self.sex.frame = CGRectMake(self.name.maxX+WMar, self.name.y, self.sex.width, H);
    self.type.frame = CGRectMake(self.sex.maxX+WMar, self.name.y, self.grayView.width-self.sex.width-self.name.width-4*WMar, H);
    self.title.frame = CGRectMake(self.name.x, self.name.maxY, self.grayView.width-WMar*2, H);
    self.tel.frame = CGRectMake(self.name.x, self.title.maxY, self.title.width, H);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    TeacherListTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TeacherListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
