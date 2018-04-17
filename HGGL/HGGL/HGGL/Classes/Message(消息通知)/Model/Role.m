//
//  Role.m
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/27.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "Role.h"

@implementation Role
-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}
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
@end
