//
//  MenteeProject.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenteeProject : NSObject
//：项目名称
@property (nonatomic,copy) NSString *project_name;//
//：项目开始时间
@property (nonatomic,copy) NSString *project_start;//
//：项目结束时间
@property (nonatomic,copy) NSString *project_end;//
//：项目id
@property (nonatomic,copy) NSString *project_id;//
//项目编号
@property (nonatomic,copy) NSString *project_serial_num;
//运行状态
@property (nonatomic,copy) NSString *running_status;
//：项目联系人
@property (nonatomic,copy) NSString *project_contact;
//：联系人电话
@property (nonatomic,copy) NSString *contact_phone;
//：课时
@property (nonatomic,copy) NSString *course_hour;


+(instancetype)MFWithDict:(NSDictionary *)dict;
@end
