//
//  Role.h
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/27.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Role : NSObject
@property (nonatomic,copy)NSString *roleName;//角色名称
@property (nonatomic,copy)NSString *roleId;//角色ID
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
