//
//  HGProjectListModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGProjectListModel.h"

@implementation HGProjectListModel
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
