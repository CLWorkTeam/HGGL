//
//  HGMenteeModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMenteeModel.h"

@implementation HGMenteeModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.mentee_id = (dict[@"mentee_id"]?dict[@"mentee_id"]:@"");
        self.mentee_sex = (dict[@"mentee_sex"]?dict[@"mentee_sex"]:@"");
        self.mentee_name = (dict[@"mentee_name"]?dict[@"mentee_name"]:@"");
        self.mentee_tel = (dict[@"mentee_tel"]?dict[@"mentee_tel"]:@"");
        self.mentee_group = (dict[@"mentee_group"]?dict[@"mentee_group"]:@"");
        self.mentee_room = (dict[@"mentee_room"]?dict[@"mentee_room"]:@"");
        self.mentee_district = (dict[@"mentee_district"]?dict[@"mentee_district"]:@"");
        self.mentee_department = (dict[@"mentee_department"]?dict[@"mentee_department"]:@"");
    }
    
    return self;
}

+(instancetype)initWithDict:(NSDictionary *)dict
{
    return [[[self alloc] init] initWithDict:dict];
}
@end
