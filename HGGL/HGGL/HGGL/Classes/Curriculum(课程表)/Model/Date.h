//
//  Date.h
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject
@property (nonatomic,copy) NSString *week;
@property (nonatomic,copy) NSString *weekStar;
@property (nonatomic,copy) NSString *weekEnd;
+(instancetype)dateWithDict:(NSDictionary *)dict;
@end
