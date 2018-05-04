//
//  HGProjectBaseModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGProjectBaseModel : NSObject
@property (nonatomic,copy)NSString *project_id;//项目id
@property (nonatomic,copy)NSString *project_serial_num;//项目编号
@property (nonatomic,copy)NSString *project_name;//项目名称
@property (nonatomic,copy)NSString *project_start;//开始时间
@property (nonatomic,copy)NSString *project_end;//结束时间
@property (nonatomic,copy)NSString *running_status;//项目运行状态
@property (nonatomic,copy)NSString *project_apply_start;//项目报名开始时间
@property (nonatomic,copy)NSString *project_apply_end;//项目报名结束时间
@property (nonatomic,copy)NSString *project_days;//项目天数
@property (nonatomic,copy)NSString *project_people_num;//人数
@property (nonatomic,copy)NSString *project_fee;//费用
@property (nonatomic,copy)NSString *project_room;//教室
@property (nonatomic,copy)NSString *project_type;//项目类型
@property (nonatomic,copy)NSString *project_department;//承训部门
@property (nonatomic,copy)NSString *project_level;//级别
@property (nonatomic,copy)NSString *project_entrust_company;//项目委托单位
@property (nonatomic,copy)NSString *entrust_contact;//委托联系人
@property (nonatomic,copy)NSString *entrust_contact_phone;//委托联系人电话
@property (nonatomic,copy)NSString *project_contact;//项目联系人
@property (nonatomic,copy)NSString *contact_phone;//联系人电话
@property (nonatomic,copy)NSString *course_contact;//课程负责人
@property (nonatomic,copy)NSString *project_teacher;//班主任
@property (nonatomic,copy)NSString *projectUrl_confirm_list;//确认单url
@property (nonatomic,strong)NSArray *remarkList;//服务备注列表(数组，数组里面是对象)

@property (nonatomic,strong) NSMutableArray *contentArray;
@property (nonatomic,strong) NSMutableArray *remarkArray;
+(instancetype)initWithDict:(NSDictionary *)dict;

@end
