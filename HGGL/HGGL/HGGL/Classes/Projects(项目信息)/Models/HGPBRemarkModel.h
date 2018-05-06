//
//  HGPBRemarkModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGPBRemarkModel : NSObject
@property (nonatomic,copy)NSString *title;//名称
@property (nonatomic,copy)NSString *remark;//备注
@property (nonatomic,copy)NSString *department;//部门
@property (nonatomic,copy)NSString *staff;//职工
@property (nonatomic,assign) CGRect titleF;
@property (nonatomic,assign) CGRect remarkF;
@property (nonatomic,assign) CGRect departmentF;
@property (nonatomic,assign) CGRect staffF;
@property (nonatomic,assign) CGFloat cellH;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
