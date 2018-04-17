//
//  teacBaseInfo.m
//  SYDX_2
//
//  Created by mac on 15-6-25.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "teacBaseInfo.h"

@implementation teacBaseInfo
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
+(NSArray *)baseWithDict:(NSDictionary *)dict
{
    teacBaseInfo *info = [self initWithDict:dict];
    NSArray *array1 = [NSArray arrayWithObjects:info.teacher_national,info.teacher_bith,info.teacher_cerType,info.teacher_cerNum, nil];
    NSArray *array2 = [NSArray arrayWithObjects:info.teacher_type,info.teacher_prof,info.teacher_class,info.teacher_pay, nil];
    NSArray *array3 = [NSArray arrayWithObjects:info.teacher_workUnit,info.teacher_workPlace,info.teacher_title, nil];
    NSArray *array4 = [NSArray arrayWithObjects:info.teacher_tel,info.teacher_oficTel,info.teacher_fax,info.teacher_mail,info.teacher_zipCode, nil];
    return [NSArray arrayWithObjects:array2,array3,array1,array4, nil];
}
@end
