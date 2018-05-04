//
//  StudentTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "StudentTableViewCell.h"
#import "HGLable.h"
#import "HGMenteeModel.h"
//#import "MenteeList.h"
#import "TextFrame.h"
#import "HGLable.h"
//#define margin 8
//#define labHeigh 25
#define Width 65
//#define Hmargin 5
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@interface StudentTableViewCell ()
@property (nonatomic,weak) UIView *grayView;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *sex;
@property (nonatomic,weak) UILabel *tel;
@property (nonatomic,weak) UILabel *group;
@property (nonatomic,weak) UILabel *room;
@property (nonatomic,weak) UILabel *part;
@property (nonatomic,weak) UILabel *area;
@end
@implementation StudentTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
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

    
   
    
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:name];
    self.name = name;
    
    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:sex];
    self.sex = sex;
    
    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:tel];
    self.tel = tel;
    
    UILabel *group = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:group];
    self.group = group;
    
    UILabel *room = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:room];
    self.room = room;
    
    UILabel *part = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:part];
    self.part = part;
    
    UILabel *area = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:area];
    self.area = area;
    
    
    
    
    
    
    
}
-(void)setMen:(HGMenteeModel *)men
{
    _men = men;
    
    self.name.text = men.mentee_name;
    self.sex.text = men.mentee_sex;
    self.tel.text = men.mentee_tel;
    self.group.text = [NSString stringWithFormat:@"组号：%@",men.mentee_group];
    self.room.text = [NSString stringWithFormat:@"房号：%@",men.mentee_room];
    self.area.text = [NSString stringWithFormat:@"关区：%@",men.mentee_district];
    self.part.text = [NSString stringWithFormat:@"部门：%@",men.mentee_department];;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat WMargin = 10;
    CGFloat WMar = 5;
    CGFloat Hmar = 20;
    CGFloat H = 30;
    self.grayView.frame = CGRectMake(WMargin, 0, self.width-2*WMargin, self.height-Hmar);
//    [self.name sizeToFit];
    self.name.frame = CGRectMake(WMar, 0, self.grayView.width/3-WMar, H);
    [self.sex sizeToFit];
    self.sex.width = 15;
    self.sex.frame = CGRectMake(self.name.maxX+WMar, self.name.y, self.sex.width, H);
    self.tel.frame = CGRectMake(self.sex.maxX+WMar, self.name.y, self.grayView.width-self.sex.width-self.name.width-4*WMar, H);
    self.group.frame = CGRectMake(self.name.x, self.name.maxY, self.grayView.width/2-3*WMar/2, H);
    self.room.frame = CGRectMake(self.group.maxX+WMar, self.group.y, self.group.width, H);
    self.area.frame = CGRectMake(self.name.x, self.group.maxY, self.grayView.width-WMar*2, H);
    self.part.frame = CGRectMake(self.name.x, self.area.maxY, self.area.width, H);
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    StudentTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[StudentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}


@end
