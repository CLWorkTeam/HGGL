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
@property (nonatomic,strong)NSString *projectName;
//课程名称
@property (nonatomic,strong)NSString *courseName;
//课程满意度评分
@property (nonatomic,strong)NSString *courseScore;
//评价时间
@property (nonatomic,strong)NSArray *evaluateList;
//cell的高度
@property (nonatomic,assign) CGFloat cellH;
//评价详情的高度
@property (nonatomic,assign) CGFloat evaluateH;
+(instancetype)courseScoreWithDict:(NSDictionary *)dict;
@end
