//
//  Account.h
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class User;
@interface Account : NSObject
@property (nonatomic,strong) User *user;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSMutableArray *baseArr;
@end
