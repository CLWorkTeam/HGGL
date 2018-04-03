//
//  Message.h
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Message : NSObject
//:消息id（消息接收ID）
@property (nonatomic,copy) NSString *msg_id;
//:消息名称
@property (nonatomic,copy) NSString *msg_name;
//:发布人名称
@property (nonatomic,copy) NSString *msg_publisher;
//:类型 1：纯文本  2： H5详情

@property (nonatomic,copy) NSString *msg_type;
//:消息读取状态  0：未读 1：已读
@property (nonatomic,copy) NSString *msg_status;
//:消息内容
@property (nonatomic,copy) NSString *msg_content;
//;发送时间
@property (nonatomic,copy) NSString *msg_send_time;
//消息详情url地址
@property (nonatomic,copy) NSString *msg_url;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
