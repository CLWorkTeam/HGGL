//
//  Car.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Car : NSObject
//:用车人姓名
@property (nonatomic,copy)NSString *car_peoplename;
//:用车人电话
@property (nonatomic,copy)NSString *car_mobile;
//:出发时间
@property (nonatomic,copy)NSString *car_start;
//:到达时间
@property (nonatomic,copy)NSString *car_end;
//:等车点
@property (nonatomic,copy)NSString *car_waitplace;
//:到达地点
@property (nonatomic,copy)NSString *car_place;
//：人数
@property (nonatomic,copy)NSString *car_peoplenum;
//:车辆名称
@property (nonatomic,copy)NSString *car_name ;
//:车牌号
@property (nonatomic,copy)NSString *car_num;
//:司机
@property (nonatomic,copy)NSString *car_driver;
//:司机电话
@property (nonatomic,copy)NSString *car_drivermobile;
//:出库时间
@property (nonatomic,copy)NSString *car_approvalstart;
//:归库时间
@property (nonatomic,copy)NSString *car_approvalend;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
