//
//  TeacIntroInfo.m
//  SYDX_2
//
//  Created by mac on 15-7-21.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacIntroInfo.h"

@implementation TeacIntroInfo
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
