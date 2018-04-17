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
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
