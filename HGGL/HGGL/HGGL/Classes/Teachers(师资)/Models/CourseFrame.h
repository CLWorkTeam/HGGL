//
//  CourseFrame.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CourseList;
@interface CourseFrame : NSObject
//课程对象
@property (nonatomic,strong) CourseList *course;
//课程名称frame
@property (nonatomic,assign) CGRect course_nameF;
//项目简介frame
@property (nonatomic,assign) CGRect course_decF;
//项目备注frame
@property (nonatomic,assign) CGRect course_noteF;
//cell高度
@property (nonatomic,assign) CGFloat cellH;
@end
