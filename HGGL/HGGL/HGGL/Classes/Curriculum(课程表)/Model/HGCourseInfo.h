//
//  HGCourseInfo.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGCourseInfo : NSObject
@property (nonatomic,copy) NSString *project_id;//所属项目id
@property (nonatomic,copy) NSString *project_name;//所属项目名称
@property (nonatomic,copy) NSString *course_classroom;//教室
@property (nonatomic,copy) NSString *course_id;//课程id
@property (nonatomic,copy) NSString *course_name;//课程名称
@property (nonatomic,copy) NSString *course_start;//课程开始时间
@property (nonatomic,copy) NSString *course_end;//课程结束时间
@property (nonatomic,copy) NSString *course_teacher;//教师
@property (nonatomic,copy) NSString *teacher_id;//教师id
@property (nonatomic,copy) NSString *teacher_pickup;//是否接送
@property (nonatomic,copy) NSString *teacher_info;//教师简介
@property (nonatomic,copy) NSString *course_info;//课程简介
@property (nonatomic,copy) NSString *course_remark;//课程备注
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
