//
//  HGItemPlanModel.h
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGItemPlanModel : NSObject

@property (nonatomic,copy) NSString *planId;//计划id;
@property (nonatomic,copy) NSString *projectType;//项目类型
@property (nonatomic,copy) NSString *projectName;//项目名称
@property (nonatomic,copy) NSString *startTime;//开始时间
@property (nonatomic,copy) NSString *endTime;//结束时间
@property (nonatomic,copy) NSString *feeStandard;//费用标准
@property (nonatomic,copy) NSString *days;//天数
@property (nonatomic,copy) NSString *peopleNums;//人数
@property (nonatomic,copy) NSString *accommodation;//住宿
@property (nonatomic,copy) NSString *linkman;//联系人
@property (nonatomic,copy) NSString *linkmanPhone;//联系人电话
@property (nonatomic,copy) NSString *placeOfClass;//上课地点
@property (nonatomic,copy) NSString *teachers;//班主任/联系人
@property (nonatomic,copy) NSString *registrationTime;//报道时间
@property (nonatomic,copy) NSString *backTime;//返程时间
;



@end
