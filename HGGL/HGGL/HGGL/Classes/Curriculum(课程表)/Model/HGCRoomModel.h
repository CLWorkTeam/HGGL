//
//  HGCRoomModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGCRoomModel : NSObject
@property (nonatomic,copy)NSString *holdId;//id（编号）
@property (nonatomic,copy)NSString *holdName;//教室名称
@property (nonatomic,copy)NSString *holdNum;//教室可容纳人数
@property (nonatomic,copy)NSArray *detailList;//教室占用详情列表（数组，数组里面是json对象）
@property (nonatomic,copy)NSMutableArray *detailArr;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
