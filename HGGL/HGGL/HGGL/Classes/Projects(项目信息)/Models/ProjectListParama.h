//
//  ProjectListParama.h
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ProjectListParama : NSObject
@property (nonatomic,copy)NSString *str;

//：项目类型，默认全部
@property (nonatomic,copy)NSString *project_type;
//：项目性质
//@property (nonatomic,copy) NSString *project_nature;
//：项目起始日期，默认全部
@property (nonatomic,copy)NSString *project_start;
//：项目结束日期，默认全部
@property (nonatomic,copy)NSString *project_end;
//：项目运行状态，默认全部
@property (nonatomic,copy)NSString *project_status;
//：当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;
@end
