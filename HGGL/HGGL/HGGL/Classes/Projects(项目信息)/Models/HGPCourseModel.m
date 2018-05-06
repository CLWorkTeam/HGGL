//
//  HGPCourseModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/4.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPCourseModel.h"

@implementation HGPCourseModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.course_info = [self getPropertyWithStr:@"course_info" inDictionary:dict];
        self.course_remark = [self getPropertyWithStr:@"course_remark" inDictionary:dict];
        self.course_start = [self getPropertyWithStr:@"course_start" inDictionary:dict];
        self.course_end = [self getPropertyWithStr:@"course_end" inDictionary:dict];
        self.course_teacher = [self getPropertyWithStr:@"course_teacher" inDictionary:dict];
        self.course_name = [self getPropertyWithStr:@"course_name" inDictionary:dict];
        self.course_id = [self getPropertyWithStr:@"course_id" inDictionary:dict];
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
-(id)getPropertyWithStr:(NSString *)key inDictionary:(NSDictionary *)dict
{
    return dict[key]?dict[key]:@"";
}
@end
