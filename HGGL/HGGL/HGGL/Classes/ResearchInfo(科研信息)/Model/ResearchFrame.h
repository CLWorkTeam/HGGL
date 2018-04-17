//
//  ResearchFrame.h
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ResearchList;
@interface ResearchFrame : NSObject
@property (nonatomic,strong) ResearchList *RL;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@end
