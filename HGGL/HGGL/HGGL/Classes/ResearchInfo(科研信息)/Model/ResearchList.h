//
//  ResearchList.h
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResearchList : NSObject
//：课题名称
@property (nonatomic,copy)NSString *research_name;
//：课题id（编号）
@property (nonatomic,copy)NSString *research_id;
//：课题类型
@property (nonatomic,copy)NSString *research_type;
//：类别 区情研究  干部培训规律 党校发展 理论研究
@property (nonatomic,copy)NSString *research_category;
//：总经费
@property (nonatomic,copy)NSString *research_funds;
//：已报销经费
@property (nonatomic,copy)NSString *research_has_funds;
//：未报销经费
@property (nonatomic,copy)NSString *research_not_funds;
//：课题负责人
@property (nonatomic,copy)NSString *research_manager;
//：课题状态
@property (nonatomic,copy)NSString *research_status;
//:课题操作详情
@property (nonatomic,copy)NSString *research_url;
//：课题操作数组
@property (nonatomic,strong)NSArray *research_control;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
