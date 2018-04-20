//
//  HGCRModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRModel.h"

@implementation HGCRModel
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
