//
//  HGSRBModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGSRBModel : NSObject
@property (nonatomic,copy) NSString *borrowUserId;//借阅学员用户id
@property (nonatomic,copy) NSString *name;//学员名称
@property (nonatomic,copy) NSString *phone;//电话
@property (nonatomic,copy) NSString *department;//学员所在班级
@property (nonatomic,copy) NSString *endTime;//项目结束时间
@property (nonatomic,copy) NSString *borrowNum;//待归还数量
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
