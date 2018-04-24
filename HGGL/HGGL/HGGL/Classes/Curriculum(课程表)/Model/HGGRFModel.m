//
//  HGGRFModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGGRFModel.h"
#import "HGGRRModel.h"
@implementation HGGRFModel
-(NSMutableArray *)roomArray
{
    if (_roomArray == nil) {
        _roomArray = [NSMutableArray array];
    }
    return _roomArray;
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        for (NSDictionary *dict in self.roomList) {
            HGGRRModel *model = [HGGRRModel initWithDict:dict];
            [self.roomArray addObject:model];
        }
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
@end
