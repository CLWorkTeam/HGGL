//
//  Dinner.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Dinner : NSObject
//:接待信息具体时间
@property (nonatomic,copy)NSString *dining_time;
//:就餐类型
@property (nonatomic,copy)NSString *dining_kind;
//:就餐形式
@property (nonatomic,copy)NSString *dining_form;
//：就餐人数
@property (nonatomic,copy)NSString *dining_num;
//:就餐餐厅
@property (nonatomic,copy)NSString *dining_place;
//：备注
@property (nonatomic,copy)NSString *dining_note;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
