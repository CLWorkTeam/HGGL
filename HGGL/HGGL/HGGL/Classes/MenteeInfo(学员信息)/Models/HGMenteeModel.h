//
//  HGMenteeModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGMenteeModel : NSObject
@property (nonatomic,copy) NSString *mentee_id;//学员id
@property (nonatomic,copy) NSString *mentee_name;//学员姓名
@property (nonatomic,copy) NSString *mentee_sex;//学员性别
@property (nonatomic,copy) NSString *mentee_tel;//学员联系电话
@property (nonatomic,copy) NSString *mentee_group;//学员所在组
@property (nonatomic,copy) NSString *mentee_room;//房间
@property (nonatomic,copy) NSString *mentee_district;//关区
@property (nonatomic,copy) NSString *mentee_department;//部门
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
