//
//  CourseFrame.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CourseFrame.h"
#import "CourseList.h"
#import "TextFrame.h"
#define Width 35
//#define magin 15

#define TitleFont [UIFont fontWithName:@"Helvetica-Bold" size:HGFont]
#define ContexFont [UIFont systemFontOfSize:HGFont]
//#define minH  [TextFrame frameOfText:@"备注:" With:ContexFont Andwidth:Width].height
@implementation CourseFrame
-(void)setCourse:(CourseList *)course
{
    _course = course;
    CGFloat W = HGScreenWidth - 2*CellWMargin;
    CGFloat w = HGScreenWidth-2*CellWMargin-CellHMargin;
    CGFloat nameH = [TextFrame frameOfText:course.course_name With:TitleFont Andwidth:W].height;
    //HGLog(@"111%@",course.course_name);
    CGFloat h = nameH>minH?nameH:minH;
    _course_nameF = CGRectMake(CellWMargin, CellHMargin,W , h);
    CGFloat decH = [TextFrame frameOfText:course.course_dec With:ContexFont Andwidth:w-Width].height;
    CGFloat DH = decH>minH?decH:minH;
    _course_decF = CGRectMake(CellWMargin+Width+CellHMargin, CGRectGetMaxY(_course_nameF)+CellHMargin, w-Width, DH);
    CGFloat noteH = [TextFrame frameOfText:course.course_note With:ContexFont Andwidth:w-Width].height;
    _course_noteF = CGRectMake(CellWMargin+CellHMargin+Width, CGRectGetMaxY(_course_decF)+CellHMargin, w-Width, minH>=noteH?minH:noteH);
    _cellH = CGRectGetMaxY(_course_noteF)+CellHMargin;
    
    
}

@end
