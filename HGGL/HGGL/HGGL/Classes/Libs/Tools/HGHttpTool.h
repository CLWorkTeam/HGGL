//
//  HGHttpTool.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface HGHttpTool : NSObject
+(void)POSTWithURL:(NSString *)URLString parameters:(id)parameters success:(void (^)(id responseObject))success failure:(void (^)(NSError *error ))failure;
+(void)PostWithURL:(NSString *)URLString parameters:(id)parameters withImage:(UIImage *)image success:(void (^)(id responseObject))success failure:(void (^)(NSError *error))failure;
@end
