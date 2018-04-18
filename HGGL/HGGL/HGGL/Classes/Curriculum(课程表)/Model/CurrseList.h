//
//  CurrseList.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CurrseList : NSObject


//课程名称
@property (nonatomic,copy)NSString *courseName;
//课程id（编号）
@property (nonatomic,copy)NSString *courseId;
//：课程起始日期
@property (nonatomic,copy)NSString *startTime;
//：课程结束日期
@property (nonatomic,copy)NSString *endTime;
//：授课教师
@property (nonatomic,copy)NSString *teacher;
//教室
@property (nonatomic,copy)NSString *classroom;
//课程信息
@property (nonatomic,copy)NSString *courseInfo;
//课程时长
@property (nonatomic,copy)NSString *timeFrame;
//教室ID
@property (nonatomic,copy)NSString *classroomId;
//
@property (nonatomic,copy)NSString *course_remark;


@property (nonatomic,copy)NSString *teacher_id;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
