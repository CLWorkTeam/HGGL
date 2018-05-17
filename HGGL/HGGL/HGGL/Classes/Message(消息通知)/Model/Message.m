//
//  Message.m
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "Message.h"

@implementation Message
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.msg_id = (dict[@"msg_id"]?dict[@"msg_id"]:@"");
        
        self.msg_name = (dict[@"msg_name"]?dict[@"msg_name"]:@"");
        
        self.msg_publisher = (dict[@"msg_publisher"]?dict[@"msg_publisher"]:@"");
        
        self.msg_status = (dict[@"msg_status"]?dict[@"msg_status"]:@"");
        
        self.msg_content = (dict[@"msg_content"]?dict[@"msg_content"]:@"");
        
        self.msg_send_time = (dict[@"msg_send_time"]?dict[@"msg_send_time"]:@"");
        
        self.msg_type = (dict[@"msg_type"]?dict[@"msg_type"]:@"");
        
        self.msg_url = (dict[@"msg_url"]?dict[@"msg_url"]:@"");
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}

@end
