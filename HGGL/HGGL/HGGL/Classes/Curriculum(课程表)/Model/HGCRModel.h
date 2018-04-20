//
//  HGCRModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGCRModel : NSObject
@property (nonatomic,copy) NSString *receptionId;//接待单据id
@property (nonatomic,copy) NSString *receptionName;//接待单据名称
@property (nonatomic,copy) NSString *principle;//负责人
@property (nonatomic,copy) NSString *startTime;//开始时间
@property (nonatomic,copy) NSString *endTime;//结束时间
@property (nonatomic,copy) NSString *receptionUrl;//接待确认单url
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
