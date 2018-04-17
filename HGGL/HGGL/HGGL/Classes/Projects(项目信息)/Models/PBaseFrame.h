//
//  PBaseFrame.h
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ProjectList;
@interface PBaseFrame : NSObject
@property (nonatomic,strong) ProjectList *PList;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@end
