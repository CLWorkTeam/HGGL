//
//  History.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface History : NSObject
@property (nonatomic,copy)NSString *list_id;
//:接待单名称
@property (nonatomic,copy)NSString *list_name;
//:接待开始时间
@property (nonatomic,copy)NSString *list_start;
//:接待结束时间
@property (nonatomic,copy)NSString *list_end;
//:班次联系人
@property (nonatomic,copy)NSString *list_contact;
//:班次联系人电话
@property (nonatomic,copy)NSString *list_contactmobile;
//:班次接待负责人
@property (nonatomic,copy)NSString *list_principal;
//:班次接待负责人电话
@property (nonatomic,copy)NSString *list_principalmobile;
//:确认单信息地址
@property (nonatomic,copy)NSString *list_url;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
