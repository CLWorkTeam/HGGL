//
//  room.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface room : NSObject
//:住宿人姓名
@property (nonatomic,copy)NSString *accom_name;
//:客户性别
@property (nonatomic,copy)NSString *accom_sex;
//:客户职务
@property (nonatomic,copy)NSString *accom_position;
//:入住楼层
@property (nonatomic,copy)NSString *accom_floor;
//:入住房间号
@property (nonatomic,copy)NSString *accom_num;
//:房间价格
@property (nonatomic,copy)NSString *accom_price;
//:额外成本
@property (nonatomic,copy)NSString *accom_otherprice;
//: 房间状态 “未退房”、“已退房”
@property (nonatomic,copy)NSString *accom_status;
//:类型 学员 散客
@property (nonatomic,copy)NSString *accom_type;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
