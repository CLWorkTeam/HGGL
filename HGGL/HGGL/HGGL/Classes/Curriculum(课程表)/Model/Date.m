//
//  Date.m
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "Date.h"

@implementation Date
+(instancetype)dateWithDict:(NSDictionary *)dict
{
    Date *date = [[Date alloc]init];
    [date setValuesForKeysWithDictionary:dict];
    return date;
}
@end
