//
//  HGTRBModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGTRBModel : NSObject
@property (nonatomic,copy) NSString *borrowUserId;//借阅职工用户id
@property (nonatomic,copy) NSString *name;//职工名称
@property (nonatomic,copy) NSString *phone;//电话
@property (nonatomic,copy) NSString *department;//部门
@property (nonatomic,copy) NSString *endTime;//可以返回空值
@property (nonatomic,copy) NSString *borrowNum;//待归还数量

+(instancetype)initWithDict:(NSDictionary *)dict;
@end
