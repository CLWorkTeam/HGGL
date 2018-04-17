//
//  MissonList.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MissonList.h"

@implementation MissonList
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.task_content = dict[@"task_content"];
        self.task_id = dict[@"task_id"];
        self.task_name = dict[@"task_name"];
        self.task_status = dict[@"task_status"];
        self.task_type = dict[@"task_type"];
        self.project_id = dict[@"project_id"];
        self.project_name = dict[@"project_name"];
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
