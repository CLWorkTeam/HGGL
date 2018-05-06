//
//  MListTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MListTableViewCell.h"
#import "HGMenteeModel.h"
#import "HGLable.h"
#import "TextFrame.h"
//#define butH 25
//#define margin 8
@interface MListTableViewCell()
@property (nonatomic,weak) UIView *grayView;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *sex;
@property (nonatomic,weak) UILabel *tel;
@property (nonatomic,weak) UILabel *part;
@property (nonatomic,weak) UILabel *area;
@end
@implementation MListTableViewCell
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
    
    UILabel *part = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:part];
    self.part = part;
    
    UILabel *area = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.grayView  addSubview:area];
    self.area = area;
    
    
    
    
    
    
    
}
-(void)setMentee:(HGMenteeModel *)mentee
{
    _mentee = mentee;
    self.name.text = mentee.mentee_name;
    self.sex.text = mentee.mentee_sex;
    self.tel.text = mentee.mentee_tel;
    self.area.text = [NSString stringWithFormat:@"关区：%@",mentee.mentee_district];
    self.part.text = [NSString stringWithFormat:@"部门：%@",mentee.mentee_department];;
    
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
    self.area.frame = CGRectMake(self.name.x, self.name.maxY, self.grayView.width-WMar*2, H);
    self.part.frame = CGRectMake(self.name.x, self.area.maxY, self.area.width, H);
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"MListTableViewCell";
    MListTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
