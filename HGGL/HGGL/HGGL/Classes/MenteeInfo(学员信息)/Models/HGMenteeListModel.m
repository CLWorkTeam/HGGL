//
//  HGMenteeListModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/5.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMenteeListModel.h"

@implementation HGMenteeListModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.student_id = (dict[@"student_id"]?dict[@"student_id"]:@"");
        self.student_avator = (dict[@"student_avator"]?dict[@"student_avator"]:@"");
        self.student_name = (dict[@"student_name"]?dict[@"student_name"]:@"");
        self.student_sex = (dict[@"student_sex"]?dict[@"student_sex"]:@"");
        self.student_tel = (dict[@"student_tel"]?dict[@"student_tel"]:@"");
        self.student_district = (dict[@"student_district"]?dict[@"student_district"]:@"");
        self.student_department = (dict[@"student_department"]?dict[@"student_department"]:@"");
        self.student_job = (dict[@"student_job"]?dict[@"student_job"]:@"");
        self.student_birth = (dict[@"student_birth"]?dict[@"student_birth"]:@"");
        self.student_age = (dict[@"student_age"]?dict[@"student_age"]:@"");
        self.id_card = (dict[@"id_card"]?dict[@"id_card"]:@"");
        self.nation = (dict[@"nation"]?dict[@"nation"]:@"");
        self.email = (dict[@"email"]?dict[@"email"]:@"");
        self.remark = (dict[@"remark"]?dict[@"remark"]:@"");
        self.currentProject = (dict[@"currentProject"]?dict[@"currentProject"]:@"");
        self.projectId = (dict[@"projectId"]?dict[@"projectId"]:@"");
        [self setArray];
    }
    
    return self;
}

+(instancetype)initWithDict:(NSDictionary *)dict
{
    return [[[self alloc] init] initWithDict:dict];
}
-(void)setArray
{
    self.menteeArray = [NSMutableArray array];
    [self.menteeArray addObjectsFromArray:@[@[self.student_district,self.student_department,self.student_job],@[self.email,self.student_birth,self.student_age,self.id_card,self.nation,self.remark],@[self.currentProject]]];
}
@end
