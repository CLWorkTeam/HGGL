//
//  HGUCRoomModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGUCRoomModel : NSObject
@property (nonatomic,copy)NSString *unHoldId;//id（编号）
@property (nonatomic,copy)NSString *unHoldName;//教室名称
@property (nonatomic,copy)NSString *unHoldNum;//教室可容纳人数
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
