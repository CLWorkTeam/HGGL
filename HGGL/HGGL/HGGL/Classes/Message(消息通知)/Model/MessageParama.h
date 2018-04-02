//
//  MessageParama.h
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MessageParama : NSObject
//：用户id（编号）
@property (nonatomic,copy)NSString *user_id;
//类型 1：学员消息 2：职工消息
@property (nonatomic,copy)NSString *type;
//当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page ;
//分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;
@end
