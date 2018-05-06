//
//  HGMenteeListModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/5.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGMenteeListModel : NSObject
@property (nonatomic,copy) NSString *student_id;//学员id             .
@property (nonatomic,copy) NSString *student_avator;//学员头像.
@property (nonatomic,copy) NSString *student_name;//学员名称.
@property (nonatomic,copy) NSString *student_sex;//学员性别.
@property (nonatomic,copy) NSString *student_tel;//电话.
@property (nonatomic,copy) NSString *student_district;//关区.
@property (nonatomic,copy) NSString *student_department;//部门.
@property (nonatomic,copy) NSString *student_job;//职务.
@property (nonatomic,copy) NSString *student_birth;//出生日期.
@property (nonatomic,copy) NSString *student_age;//年龄.
@property (nonatomic,copy) NSString *id_card;//身份证.
@property (nonatomic,copy) NSString *nation;//民族.
@property (nonatomic,copy) NSString *email;//邮箱.
@property (nonatomic,copy) NSString *remark;//备注.
@property (nonatomic,copy) NSString *currentProject;//学员当前所在项目名称
@property (nonatomic,copy) NSString *projectId;//项目id
@property (nonatomic,strong) NSMutableArray *menteeArray;//部门
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
