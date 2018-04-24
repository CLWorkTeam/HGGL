//
//  HGGRRModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGGRRModel : NSObject
@property (nonatomic,copy) NSString *roomId;//房间id（编号）
@property (nonatomic,copy) NSString *roomName;//房间名称
@property (nonatomic,copy) NSString *roomNum;//房间可住人数
@property (nonatomic,copy) NSString *roomState;//房间状态， 1、 可用  2、预定 4、脏房  5、维修中 6、故障 7、禁用
@property (nonatomic,copy) NSString *floor;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
