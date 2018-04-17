//
//  MenteeFrame.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Mentee;
@interface MenteeFrame : NSObject
//base的全部内容
@property (nonatomic,strong) Mentee *baseInfo;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@end
