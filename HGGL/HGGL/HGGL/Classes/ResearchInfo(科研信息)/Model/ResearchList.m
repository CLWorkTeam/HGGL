//
//  ResearchList.m
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchList.h"

@implementation ResearchList
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.research_category = dict[@"research_category"];
        self.research_control = dict[@"research_control"];
        self.research_funds = dict[@"research_funds"];
        self.research_has_funds = dict[@"research_has_funds"];
        self.research_id = dict[@"research_id"];
        self.research_manager = dict[@"research_manager"];
        self.research_name = dict[@"research_name"];
        self.research_not_funds = dict[@"research_not_funds"];
        self.research_status = dict[@"research_status"];
        self.research_type = dict[@"research_type"];
        self.research_url = dict[@"research_url"];
    
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
