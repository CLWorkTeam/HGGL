//
//  BlackLog.h
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BlackLog : NSObject
//待办id
@property (nonatomic,copy) NSString *backlog_id;
//: 待办名称
@property (nonatomic,copy) NSString *backlog_name;
//: 发布人
@property (nonatomic,copy) NSString *backlog_publisher;
//:类别   1.工作流  3.科研审批 4.公告审批  5.个人任务
@property (nonatomic,copy) NSString *backlog_type;
//:待办内容
@property (nonatomic,copy) NSString *backlog_content;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
