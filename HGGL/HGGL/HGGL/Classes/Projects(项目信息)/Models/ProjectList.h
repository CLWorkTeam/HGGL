//
//  ProjectList.h
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectList : NSObject
//项目id（编号）
@property (nonatomic,copy) NSString *project_id;
//：项目名称
@property (nonatomic,copy) NSString *project_name;
//项目审批状态
@property(nonatomic, copy) NSString *project_status;
//：项目运行状态
@property (nonatomic,copy) NSString *running_status;
//：项目类型
@property (nonatomic,copy) NSString *project_type;
//：项目性质
@property (nonatomic,copy) NSString *project_nature;
//：教室
@property (nonatomic,copy) NSString *project_classroom;
//：项目起始日期
@property (nonatomic,copy) NSString *project_start;
//：项目结束日期
@property (nonatomic,copy) NSString *project_end;
//：项目负责人
@property (nonatomic,copy) NSString *project_manager;
//：项目负责人电话
//@property (nonatomic,copy) NSString *project_manager_tel;
//：课程负责人
@property (nonatomic,copy) NSString *project_courseManager;
//：计划学员人数
@property (nonatomic,copy) NSString *project_planNum;
//：实际学员人数
@property (nonatomic,copy) NSString *project_factNum;
//：班主任
@property (nonatomic,copy) NSString *project_director;
//:团队确认单url
@property (nonatomic,copy) NSString *projectUrl_confirm_list;

-(instancetype)initWithDict:(NSDictionary *)dict;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
