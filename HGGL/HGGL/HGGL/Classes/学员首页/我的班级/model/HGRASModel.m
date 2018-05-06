//
//  HGRASModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/6.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRASModel.h"

@implementation HGRASModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
//        [self setValuesForKeysWithDictionary:dict];
        self.receptionPeople = (dict[@"receptionPeople"]?dict[@"receptionPeople"]:@"");
        self.receptionPhone = (dict[@"receptionPhone"]?dict[@"receptionPhone"]:@"");
        self.car = (dict[@"car"]?dict[@"car"]:@"");
        self.carNum = (dict[@"carNum"]?dict[@"carNum"]:@"");
        self.driver = (dict[@"driver"]?dict[@"driver"]:@"");
        self.driverPhone = (dict[@"driverPhone"]?dict[@"driverPhone"]:@"");
        self.remark = (dict[@"remark"]?dict[@"remark"]:@"");
        self.trainFlightInfo = (dict[@"trainFlightInfo"]?dict[@"trainFlightInfo"]:@"");
        self.arrivePlace = (dict[@"arrivePlace"]?dict[@"arrivePlace"]:@"");
        self.date = (dict[@"date"]?dict[@"date"]:@"");
        self.time = (dict[@"time"]?dict[@"time"]:@"");
        self.arr = @[self.trainFlightInfo,self.arrivePlace,self.date,self.time,self.receptionPeople,self.receptionPhone,self.car,self.carNum,self.driver,self.driverPhone,self.remark];
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
