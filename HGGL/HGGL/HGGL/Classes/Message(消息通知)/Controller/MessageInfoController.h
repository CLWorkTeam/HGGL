//
//  MessageInfoController.h
//  SYDX_2
//
//  Created by mac on 15-8-14.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageInfoController : UIViewController
//:消息名称
@property (nonatomic,copy) NSString *msg_name;
//:发布人名称
@property (nonatomic,copy) NSString *msg_publisher;
//:消息内容
@property (nonatomic,copy) NSString *msg_content;
@end
