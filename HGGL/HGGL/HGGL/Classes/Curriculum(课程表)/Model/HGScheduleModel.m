//
//  HGScheduleModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGScheduleModel.h"

@implementation HGScheduleModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.courseId = (dict[@"courseId"]?dict[@"courseId"]:@"");
        self.courseName = (dict[@"courseName"]?dict[@"courseName"]:@"");
        self.startTime = (dict[@"startTime"]?dict[@"startTime"]:@"");
        self.endTime = (dict[@"endTime"]?dict[@"endTime"]:@"");
        self.teacher = (dict[@"teacher"]?dict[@"teacher"]:@"");
        self.classroom = (dict[@"classroom"]?dict[@"classroom"]:@"");
        self.courseInfo = (dict[@"courseInfo"]?dict[@"courseInfo"]:@"");
        self.timeFrame = (dict[@"timeFrame"]?dict[@"timeFrame"]:@"");
        self.classroomId = (dict[@"classroomId"]?dict[@"classroomId"]:@"");
        self.course_remark = (dict[@"course_remark"]?dict[@"course_remark"]:@"");
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
@end
