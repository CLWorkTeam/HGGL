//
//  HGHoldRMDModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGHoldRMDModel : NSObject
@property (nonatomic,copy)NSString *projectName;//项目名称
@property (nonatomic,copy)NSString *courseName;//课程名称
@property (nonatomic,copy)NSString *peopleNum;//人数
@property (nonatomic,copy)NSString *startTime;//开始时间
@property (nonatomic,copy)NSString *endTime;//结束时间
@property (nonatomic,copy)NSString *contact;//联系人
@property (nonatomic,copy)NSString *contactPhone;//联系人电话

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
