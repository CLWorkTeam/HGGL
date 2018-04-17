//
//  PCourse.m
//  SYDX_2
//
//  Created by mac on 15-8-6.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PCourse.h"
#import "TextFrame.h"
//#define margin 8
//#define labHeigh 25
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation PCourse
+(instancetype)initWithDict:(NSDictionary *)dict
{
    PCourse *PC = [[PCourse alloc]init];
    PC.course_name = dict[@"course_name"];
    PC.course_teacher = dict[@"course_teacher"];
    PC.course_start = dict[@"course_start"];
    CGFloat h = [TextFrame frameOfText:PC.course_name With:[UIFont fontWithName:@"Helvetica-Bold" size:14] Andwidth:(HGScreenWidth-2*CellWMargin)].height;
    PC.CnameH = h>=minH?h:minH;
    PC.cellH = minH+PC.CnameH+3*CellHMargin;
    return PC;
}
@end
