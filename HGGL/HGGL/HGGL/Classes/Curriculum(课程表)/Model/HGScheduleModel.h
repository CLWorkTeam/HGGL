//
//  HGScheduleModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGScheduleModel : NSObject
@property (nonatomic,copy) NSString *courseId;//课程id（编号）//
@property (nonatomic,copy) NSString *courseName;//课程名称//
@property (nonatomic,copy) NSString *startTime;//课程起始日期//
@property (nonatomic,copy) NSString *endTime;//课程结束日期    10:30//
@property (nonatomic,copy) NSString *teacher;//授课教师//
@property (nonatomic,copy) NSString *classroom;//教室地址//
@property (nonatomic,copy) NSString *courseInfo;//课程简介
@property (nonatomic,copy) NSString *timeFrame;//课程简介
@property (nonatomic,copy) NSString *classroomId;
@property (nonatomic,copy) NSString *course_remark;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
