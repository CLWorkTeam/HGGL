//
//  HGGRFModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGGRFModel : NSObject
@property (nonatomic,copy) NSString *floor;//楼层
@property (nonatomic,strong) NSArray *roomList;//房间列表（数组，数组里面是json对象）
@property (nonatomic,strong) NSMutableArray *roomArray;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
