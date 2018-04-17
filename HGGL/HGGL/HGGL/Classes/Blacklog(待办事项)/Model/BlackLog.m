//
//  BlackLog.m
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BlackLog.h"

@implementation BlackLog
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.backlog_content = dict[@"backlog_content"];
        self.backlog_id = dict[@"backlog_id"];
        self.backlog_name = dict[@"backlog_name"];
        self.backlog_publisher = dict[@"backlog_publisher"];
        self.backlog_type = dict[@"backlog_type"];

    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
