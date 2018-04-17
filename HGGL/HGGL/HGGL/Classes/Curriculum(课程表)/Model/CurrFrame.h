//
//  CurrFrame.h
//  SYDX_2
//
//  Created by mac on 15-8-7.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CurrseList;
@interface CurrFrame : NSObject
@property (nonatomic,copy)NSString *course_classroom;
@property (nonatomic,strong) CurrseList *CL;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@end
