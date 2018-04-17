//
//  TeacIntroInfo.h
//  SYDX_2
//
//  Created by mac on 15-7-21.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacIntroInfo : NSObject
//教师简介
@property (nonatomic,copy)NSString *teacher_dec;
//判别依据
@property (nonatomic,copy)NSString *teacher_judge;
//师资来源
@property (nonatomic,copy)NSString *teacher_source;
//学习经历
@property (nonatomic,copy)NSString *teacher_studyExp;
//工作经历
@property (nonatomic,copy)NSString *teacher_workExp;
//备注
@property (nonatomic,copy)NSString *teacher_note;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
