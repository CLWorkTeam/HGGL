//
//  ClassRoom.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ClassRoom : NSObject
//:教室编号
@property (nonatomic,copy)NSString *classroom_num;
//:教室用途
@property (nonatomic,copy)NSString *classroom_use;
//:开始时间
@property (nonatomic,copy)NSString *classroom_start;
//:结束时间
@property (nonatomic,copy)NSString *classroom_end;
//:价格
@property (nonatomic,copy)NSString *classroom_price;
//:备注
@property (nonatomic,copy)NSString *classroom_note;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
