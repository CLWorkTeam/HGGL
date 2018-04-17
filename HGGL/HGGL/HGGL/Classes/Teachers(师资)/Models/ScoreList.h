//
//  ScoreList.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScoreList : NSObject
//项目课程ID
@property (nonatomic,copy) NSString *projectCourse_id;
//课程名称
@property (nonatomic,copy) NSString *course_name;
//项目名称
@property (nonatomic,copy) NSString *project_name;
//课程评分
@property (nonatomic,copy) NSString *course_score;
//教授日期
@property (nonatomic,copy) NSString *course_date;
//项目名称的height
@property (nonatomic,assign) CGFloat projectNameH;
//课程名称的height
@property (nonatomic,assign) CGFloat courseNameH;
//cell的高度
@property (nonatomic,assign) CGFloat cellH;
+(instancetype)scoreWithDict:(NSDictionary *)dict;
@end
