//
//  teacBaseInfo.h
//  SYDX_2
//
//  Created by mac on 15-6-25.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface teacBaseInfo : NSObject
//教师主键ID
@property (nonatomic,copy) NSString *teacher_id;
//教师照片
@property (nonatomic,copy) NSString *teacher_pic;
//教师姓名
@property (nonatomic,copy) NSString *teacher_name;
//教师性别
@property (nonatomic,copy) NSString *teacher_sex;
//手机号码
@property (nonatomic,copy) NSString *teacher_tel;
//所属民族
@property (nonatomic,copy) NSString *teacher_national;
//出生日期
@property (nonatomic,copy) NSString *teacher_bith;
//证件类型
@property (nonatomic,copy) NSString *teacher_cerType;
//证件号码
@property (nonatomic,copy) NSString *teacher_cerNum;
//职务
@property (nonatomic,copy) NSString *teacher_title;
//专业领域
@property (nonatomic,copy) NSString *teacher_prof;
//聘任类型
@property (nonatomic,copy) NSString *teacher_type;
//区范围
//@property (nonatomic,copy) NSString *teacher_area;
//传真号码
@property (nonatomic,copy) NSString *teacher_fax;
//办公电话
@property (nonatomic,copy) NSString *teacher_oficTel;
//邮箱地址
@property (nonatomic,copy) NSString *teacher_mail;
//邮政编码
@property (nonatomic,copy) NSString *teacher_zipCode;
//工作单位
@property (nonatomic,copy) NSString *teacher_workUnit;
//单位地址
@property (nonatomic,copy) NSString *teacher_workPlace;
//适合班次
@property (nonatomic,copy) NSString *teacher_class;
//课酬区间
@property (nonatomic,copy) NSString *teacher_pay;
-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
+(NSArray *)baseWithDict:(NSDictionary *)dict;
@end
