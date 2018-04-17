//
//  CurrseList.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrseList : NSObject

//资源名称
@property (nonatomic,copy)NSString *roomName;
//资源内容
@property (nonatomic,strong)NSArray *roomContent;

//课程名称
@property (nonatomic,copy)NSString *course_name;
//：课程起始日期
@property (nonatomic,copy)NSString *course_start;
//：课程结束日期
@property (nonatomic,copy)NSString *course_end;
//：授课教师
@property (nonatomic,copy)NSString *course_teacher;
//分配人
@property (nonatomic,copy)NSString *classOwner;




//：项目id（编号）
@property (nonatomic,copy)NSString *project_id;
//：项目名称
@property (nonatomic,copy)NSString *project_name;
//课程id（编号）
@property (nonatomic,copy)NSString *course_id;
//：教师id（编号）
@property (nonatomic,copy)NSString *teacher_id;
//：是否接送
@property (nonatomic,copy)NSString *teacher_pickup;
//：教师简介
@property (nonatomic,copy)NSString *teacher_info;
//：课程简介
@property (nonatomic,copy)NSString *course_info;
//：课程备注
@property (nonatomic,copy)NSString *course_remark;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
