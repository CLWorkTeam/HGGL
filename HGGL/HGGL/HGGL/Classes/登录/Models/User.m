//
//  User.m
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "User.h"
#define ZKRUserid @"user_id"
#define ZKRUserDuty @"user_duty"
#define ZKRUserEmail @"user_email"
#define ZKRUserIdCard @"user_idCard"
#define ZKRUserName @"user_name"
#define ZKRUserNote @"user_note"
#define ZKRUserPhone @"user_phone"
#define ZKRUserSex @"user_sex"
#define ZKRUserTel @"user_tel"
#define ZKRUserType @"user_type"
@implementation User
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
//归档
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_user_id forKey:ZKRUserid];
    [aCoder encodeObject:_user_duty forKey:ZKRUserDuty];
    [aCoder encodeObject:_user_email forKey:ZKRUserEmail];
    [aCoder encodeObject:_user_idCard forKey:ZKRUserIdCard];
    [aCoder encodeObject:_user_name forKey:ZKRUserName];
    [aCoder encodeObject:_user_note forKey:ZKRUserNote];
    [aCoder encodeObject:_user_phone forKey:ZKRUserPhone];
    [aCoder encodeObject:_user_sex forKey:ZKRUserSex];
    [aCoder encodeObject:_user_tel forKey:ZKRUserTel];
    [aCoder encodeObject:_user_type forKey:ZKRUserType];
}
//解档
-(id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init]) {
        _user_id = [aDecoder decodeObjectForKey:ZKRUserid];
        _user_duty = [aDecoder decodeObjectForKey:ZKRUserDuty];
        _user_email = [aDecoder decodeObjectForKey:ZKRUserEmail];
        _user_idCard = [aDecoder decodeObjectForKey:ZKRUserIdCard];
        _user_name = [aDecoder decodeObjectForKey:ZKRUserName];
        _user_note = [aDecoder decodeObjectForKey:ZKRUserNote];
        _user_phone = [aDecoder decodeObjectForKey:ZKRUserPhone];
        _user_sex = [aDecoder decodeObjectForKey:ZKRUserSex];
        _user_tel = [aDecoder decodeObjectForKey:ZKRUserTel];
        _user_type = [aDecoder decodeObjectForKey:ZKRUserType];
    }
    return self;
}
@end
