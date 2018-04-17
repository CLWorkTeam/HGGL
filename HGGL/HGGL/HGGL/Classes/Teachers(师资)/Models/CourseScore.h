//
//  CourseScore.h
//  SYDX_2
//
//  Created by mac on 15-7-27.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseScore : NSObject
//项目课程名称
@property (nonatomic,strong)NSString *student_name;
//课程满意度评分
@property (nonatomic,strong)NSString *student_satisf;
//学生评价
@property (nonatomic,strong)NSString *student_evaluation;
//评价时间
@property (nonatomic,strong)NSString *student_date;
//cell的高度
@property (nonatomic,assign) CGFloat cellH;
//评价详情的高度
@property (nonatomic,assign) CGFloat evaluateH;
+(instancetype)courseScoreWithDict:(NSDictionary *)dict;
@end
