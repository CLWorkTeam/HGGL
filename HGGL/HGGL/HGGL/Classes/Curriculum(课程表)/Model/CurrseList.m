//
//  CurrseList.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrseList.h"

@implementation CurrseList
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
    
    return [[[self alloc] init] initWithDict:dict];
}
@end
