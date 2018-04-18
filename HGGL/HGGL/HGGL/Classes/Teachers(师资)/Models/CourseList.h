//
//  CourseList.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseList : NSObject
//课程名称
@property (nonatomic,copy) NSString *course_name;
//项目简介
@property (nonatomic,copy) NSString *course_dec;
//项目备注
@property (nonatomic,copy) NSString *course_note;

@property (nonatomic,copy) NSString *course_id;//课程id（编号）
//@property (nonatomic,copy) NSString *course_name;//课程名称
@property (nonatomic,copy) NSString *course_start;//课程起始日期
@property (nonatomic,copy) NSString *course_end;//课程结束日期
@property (nonatomic,copy) NSString *teacher_name;//授课教师
@property (nonatomic,copy) NSString *course_info;//课程简介
@property (nonatomic,copy) NSString *course_remark;//课程备注

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
