//
//  HGSignOutModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGSignOutModel : NSObject
@property (nonatomic,copy) NSString *className;//班级名称
@property (nonatomic,copy) NSString *classTotalNum;//班级总人数
@property (nonatomic,copy) NSString *classSignOutNum;//班级签退人数
@property (nonatomic,copy) NSString *classRealNum;//班级实际用餐人数
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
