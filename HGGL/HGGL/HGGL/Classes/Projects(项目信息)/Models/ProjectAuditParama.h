//
//  ProjectAuditParama.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/14.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectAuditParama : NSObject

@property (nonatomic,copy)NSString *str;

@property (nonatomic,copy)NSString *user_id;

//：项目类型，默认全部
@property (nonatomic,copy)NSString *project_type;
//：项目起始日期，默认全部
@property (nonatomic,copy)NSString *project_start;
//：项目结束日期，默认全部
@property (nonatomic,copy)NSString *project_end;
//：项目审批状态，默认全部
@property (nonatomic,copy)NSString *project_manage_status;
//：当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;

@end
