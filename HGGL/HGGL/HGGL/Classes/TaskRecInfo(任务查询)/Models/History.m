//
//  History.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "History.h"

@implementation History
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
