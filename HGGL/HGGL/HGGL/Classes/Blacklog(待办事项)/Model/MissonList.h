//
//  MissonList.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MissonList : NSObject
@property (nonatomic,copy)NSString *task_id;
//:任务名称
@property (nonatomic,copy)NSString *task_name;
//:任务类型
@property (nonatomic,copy)NSString *task_type;
//:项目id（编号）
@property (nonatomic,copy)NSString *project_id;
//:项目名称
@property (nonatomic,copy)NSString *project_name;
//:任务状态  0：未完成 1：已完成
@property (nonatomic,copy)NSString *task_status;
//:任务内容
@property (nonatomic,copy)NSString *task_content;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
