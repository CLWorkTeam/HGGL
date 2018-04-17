//
//  PCourse.h
//  SYDX_2
//
//  Created by mac on 15-8-6.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PCourse : NSObject
//：教室(排序升序)
@property (nonatomic,copy)NSString *course_classroom;
//：项目id（编号）
@property (nonatomic,copy)NSString *project_id;
//：项目名称
@property (nonatomic,copy)NSString *project_name;
//：课程id（编号）
@property (nonatomic,copy)NSString *course_id;
//：课程名称
@property (nonatomic,copy)NSString *course_name;
//：课程类型
@property (nonatomic,copy)NSString *course_type;
//：课程起始日期
@property (nonatomic,copy)NSString *course_start;
//：课程结束日期
@property (nonatomic,copy)NSString *course_end;
//：授课教师
@property (nonatomic,copy)NSString *course_teacher;
//教师id（编号）
@property (nonatomic,copy)NSString *teacher_id;
//：是否接送
@property (nonatomic,copy)NSString *teacher_pickup;
//：教师简介
@property (nonatomic,copy)NSString *teacher_info;
//：课程简介
@property (nonatomic,copy)NSString *course_info;
//：课程备注
@property (nonatomic,copy)NSString *course_remark;
@property (nonatomic,assign)CGFloat CnameH;
@property (nonatomic,assign)CGFloat cellH;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
