//
//  HGPCourseModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/4.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGPCourseModel : NSObject
@property (nonatomic,copy) NSString *course_info;
@property (nonatomic,copy) NSString *course_remark;
@property (nonatomic,copy) NSString *course_start;
@property (nonatomic,copy) NSString *course_end;
@property (nonatomic,copy) NSString *course_teacher;
@property (nonatomic,copy) NSString *course_name;
@property (nonatomic,copy) NSString *course_id;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
