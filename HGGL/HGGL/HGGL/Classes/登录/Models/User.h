//
//  User.h
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject<NSCoding>
//：用户ID
@property (nonatomic,copy)NSString *user_id;
//：用户姓名
@property (nonatomic,copy)NSString *user_name;
//：用户手机号
@property (nonatomic,copy)NSString *user_tel;
//:用户电话
@property (nonatomic,copy)NSString *user_phone;
//：用户类型  1：校职工 2：教师 3：学生
@property (nonatomic,copy)NSString *user_type;
//用户性别 1：男 0：女
@property (nonatomic,copy)NSString *user_sex;
//：用户职务
@property (nonatomic,copy)NSString *user_duty;
//：用户身份证号
@property (nonatomic,copy)NSString *user_idCard;
//：用户邮箱
@property (nonatomic,copy)NSString *user_email;
//：用户备注
@property (nonatomic,copy)NSString *user_note;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
