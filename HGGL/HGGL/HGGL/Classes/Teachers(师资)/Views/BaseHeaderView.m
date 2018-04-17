//
//  BaseHeaderView.m
//  SYDX_2
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BaseHeaderView.h"
#import "HGLable.h"
@interface BaseHeaderView ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *sex;
@property (nonatomic,weak) UILabel *tel;
@end
@implementation BaseHeaderView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self == [super initWithFrame:frame]) {
        [self setImageview];
        [self setLables];
    }
    return self;
}
-(void)setNameS:(NSString *)nameS
{
    _nameS = nameS;
    UILabel *nameC = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    nameC.text = nameS;
    //NSLog(@"@@%@",self.name);
    nameC.frame = CGRectMake(170, 0, HGScreenWidth-120-50, 40);
    [self addSubview:nameC];
    
}
-(void)setSexS:(NSString *)sexS
{
    _sexS = sexS;
    UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    lab.text = sexS;
    lab.frame = CGRectMake(120+50, 40, HGScreenWidth-120-50, 40);
    [self addSubview:lab];
}
-(void)setTelS:(NSString *)telS
{
    _telS = telS;
    UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    lab.text = telS;
    lab.frame = CGRectMake(170, 80, HGScreenWidth-120-50, 40);
    [self addSubview:lab];
}
//设置imageview
-(void)setImageview
{
    UIImageView *ima = [[UIImageView alloc]init];
    //ima.backgroundColor = [UIColor redColor];
    ima.image = [UIImage imageNamed:@"default_photo"];
    [self addSubview:ima];
    self.ima = ima;
    
}
//设置剩下的lable
-(void)setLables
{
    //姓名
    UILabel *name = [[UILabel alloc]init];
    name.font = [UIFont systemFontOfSize:14];
    name.textColor = [UIColor blackColor];
    name.textAlignment = NSTextAlignmentCenter;
    name.text = @"姓名:";
    [self addSubview:name];
    self.name = name;
    //性别
    UILabel *sex = [[UILabel alloc]init];
    sex.font = [UIFont systemFontOfSize:14];
    sex.textColor = [UIColor blackColor];
    sex.textAlignment = NSTextAlignmentCenter;
    sex.text = @"性别:";
    self.sex = sex;
    [self addSubview:sex];
    //电话
    UILabel *tel = [[UILabel alloc]init];
    tel.font = [UIFont systemFontOfSize:14];
    tel.textColor = [UIColor blackColor];
    tel.textAlignment = NSTextAlignmentCenter;
    tel.text = @"电话:";
    self.tel = tel;
    [self addSubview:tel];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.ima.frame = CGRectMake(10, 10, 100, 100);
    self.name.frame = CGRectMake(120, 0, 50, 40);
    self.sex.frame = CGRectMake(120, CGRectGetMaxY(self.name.frame), 50, 40);
    self.tel.frame = CGRectMake(120, CGRectGetMaxY(self.sex.frame), 50, 40);
    
}

@end
