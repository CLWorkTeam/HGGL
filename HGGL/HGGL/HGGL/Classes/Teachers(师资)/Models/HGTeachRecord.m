//
//  HGTeachRecord.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTeachRecord.h"

@implementation HGTeachRecord
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
