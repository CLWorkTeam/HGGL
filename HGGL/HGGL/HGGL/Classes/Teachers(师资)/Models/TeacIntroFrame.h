//
//  TeacIntroFrame.h
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TeacIntroInfo;
@interface TeacIntroFrame : NSObject
@property (nonatomic,strong) TeacIntroInfo *info;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@end
