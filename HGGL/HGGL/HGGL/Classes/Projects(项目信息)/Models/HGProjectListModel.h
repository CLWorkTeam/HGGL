//
//  HGProjectListModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGProjectListModel : NSObject
@property (nonatomic,copy)NSString *project_id;//项目id
@property (nonatomic,copy)NSString *project_serial_num;//项目编号
@property (nonatomic,copy)NSString *project_name;//项目名称
@property (nonatomic,copy)NSString *project_start;//开始时间
@property (nonatomic,copy)NSString *project_end;//结束时间
@property (nonatomic,copy)NSString *running_status;//项目运行状态
@property (nonatomic,copy)NSString *project_contact;//项目联系人
@property (nonatomic,copy)NSString *contact_phone;//联系人电话
@property (nonatomic,copy)NSString *course_hour;//课时
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
