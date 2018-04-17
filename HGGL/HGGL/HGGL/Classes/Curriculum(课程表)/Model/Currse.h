//
//  Currse.h
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Currse : NSObject
//: 半天最大课程数量，-1表示无教室课程
@property (nonatomic,copy)NSString *course_style;
//：教室(排序升序)
@property (nonatomic,copy)NSString *course_classroom;
//课节数
@property (nonatomic,copy)NSString *course_classCount;

//AM课表
@property (nonatomic,strong)NSArray *course_AM;
//PM课表
@property (nonatomic,strong)NSArray *course_PM;
//夜晚课表
@property (nonatomic,strong)NSArray *course_NT;

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
