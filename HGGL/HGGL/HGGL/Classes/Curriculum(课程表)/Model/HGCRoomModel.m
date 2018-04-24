//
//  HGCRoomModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRoomModel.h"
#import "HGHoldRMDModel.h"
@implementation HGCRoomModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        for (NSDictionary *dict1 in self.detailList) {
            HGHoldRMDModel *model = [HGHoldRMDModel initWithDict:dict1];
            [self.detailArr addObject:model];
            
        }
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
