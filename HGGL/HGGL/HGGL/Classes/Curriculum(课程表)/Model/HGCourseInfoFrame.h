//
//  HGCourseInfoFrame.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>
@class HGCourseInfo;
@interface HGCourseInfoFrame : NSObject
//@property (nonatomic,copy)NSString *course_classroom;
@property (nonatomic,strong) HGCourseInfo *CL;
//cell高度数组
@property (nonatomic,strong) NSMutableArray *frameArr;
//基本信息内需要的内容数组
@property (nonatomic,strong) NSArray *baseArr;
@property (nonatomic,assign) CGFloat maxW;
@end
