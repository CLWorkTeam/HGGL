//
//  Mentee.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Mentee : NSObject
//学员id
@property(nonatomic,copy)NSString *mentee_id;
//：学员姓名
@property(nonatomic,copy)NSString *mentee_name;
//：学员性别
@property(nonatomic,copy)NSString *mentee_sex;
//：学员联系电话
@property(nonatomic,copy)NSString *mentee_tel;
//：学员民族
@property(nonatomic,copy)NSString *mentee_nation;
//：学员出生日期
@property(nonatomic,copy)NSString *mentee_birthday;
//：学员年龄
@property(nonatomic,copy)NSString *mentee_age;
//：学员身份证号
@property(nonatomic,copy)NSString *mentee_idCard;
//：学员邮箱
@property(nonatomic,copy)NSString *mentee_email;
//：学员单位
@property(nonatomic,copy)NSString *mentee_workUnit;
//：学员职务
@property(nonatomic,copy)NSString *mentee_duty;
//：学员学历
//@property(nonatomic,copy)NSString *mentee_education;
//：学员学历学位
@property(nonatomic,copy)NSString *mentee_degree;
//：学员政治面貌
@property(nonatomic,copy)NSString *mentee_politicsStatus;
//：学员籍贯
@property(nonatomic,copy)NSString *mentee_place;
//：学员备注
@property(nonatomic,copy)NSString *mentee_note;
//：学员所在组
@property(nonatomic,copy)NSString *mentee_group;
//:学员头像
@property(nonatomic,copy)NSString *mentee_pic;


+(instancetype)initWithDict:(NSDictionary *)dict;
@end
