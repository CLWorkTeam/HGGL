//
//  HGRASModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/6.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGRASModel : NSObject
@property (nonatomic,copy) NSString *receptionPeople;//接待人
@property (nonatomic,copy) NSString *receptionPhone;//接待电话
@property (nonatomic,copy) NSString *car;//车辆
@property (nonatomic,copy) NSString *carNum;//车牌号
@property (nonatomic,copy) NSString *driver;//司机
@property (nonatomic,copy) NSString *driverPhone;//司机电话
@property (nonatomic,copy) NSString *remark;//备注（详细地址）
@property (nonatomic,copy) NSString *trainFlightInfo;//车次/班次
@property (nonatomic,copy) NSString *arrivePlace;//到达地点
@property (nonatomic,copy) NSString *date;//日期
@property (nonatomic,copy) NSString *time;//时间
@property (nonatomic,strong) NSArray *arr;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
