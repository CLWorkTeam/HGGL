//
//  MenteeProject.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeProject.h"
#import "TextFrame.h"
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation MenteeProject
+(instancetype)MFWithDict:(NSDictionary *)dict
{
    MenteeProject *MP = [[MenteeProject alloc]init];
    MP.project_name = (dict[@"project_name"]?dict[@"project_name"]:@"");
    MP.project_start = (dict[@"project_start"]?dict[@"project_start"]:@"");
    MP.project_end = (dict[@"project_end"]?dict[@"project_end"]:@"");
    
    MP.project_id = (dict[@"project_id"]?dict[@"project_id"]:@"");
    MP.project_serial_num = (dict[@"project_serial_num"]?dict[@"project_serial_num"]:@"");
    MP.running_status = (dict[@"running_status"]?dict[@"running_status"]:@"");
    
    MP.project_contact = (dict[@"project_contact"]?dict[@"project_contact"]:@"");
    MP.contact_phone = (dict[@"contact_phone"]?dict[@"contact_phone"]:@"");
    MP.course_hour = (dict[@"course_hour"]?dict[@"course_hour"]:@"");
    
    return MP;
}
@end
