//
//  HGTeachRecord.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGTeachRecord : NSObject
@property (nonatomic,copy) NSString *recordId;//授课记录id
@property (nonatomic,copy) NSString *recordDate;//授课时间
@property (nonatomic,copy) NSString *courseName;//课程名称
@property (nonatomic,copy) NSString *projectName;//课程所属项目名称
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
