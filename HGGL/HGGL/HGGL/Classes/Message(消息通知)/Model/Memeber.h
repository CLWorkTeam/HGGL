//
//  Memeber.h
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/26.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memeber : NSObject

@property (nonatomic,copy)NSString *user_name;//成员名称
@property (nonatomic,copy)NSString *user_id;//成员ID

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
