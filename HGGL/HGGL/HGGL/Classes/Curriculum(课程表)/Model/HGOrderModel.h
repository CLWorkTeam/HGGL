//
//  HGOrderModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGOrderModel : NSObject
@property (nonatomic,copy) NSString *menuId;//菜品id
@property (nonatomic,copy) NSString *menuUrl;//菜品图片地址url
@property (nonatomic,copy) NSString *menuName;//菜品名称
@property (nonatomic,copy) NSString *menuNum;//菜品数量

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
