//
//  HGCourseInfoFrame.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCourseInfoFrame.h"
#import "HGCourseInfo.h"
#import "TextFrame.h"
#define cellHigh 44
#define keyWidth 70
#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation HGCourseInfoFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setCL:(HGCourseInfo *)CL
{
    _CL = CL;
    self.baseArr = @[CL.project_name?CL.project_name:@"",CL.course_name?CL.course_name:@"",CL.course_classroom?CL.course_classroom:@"",CL.course_teacher?CL.course_teacher:@"",CL.teacher_pickup?CL.teacher_pickup:@"",[NSString stringWithFormat:@"%@--%@",CL.course_start?CL.course_start:@"",CL.course_end?CL.course_end:@""],CL.teacher_info?CL.teacher_info:@"",CL.course_info?CL.course_info:@"",CL.course_remark?CL.course_remark:@""];
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (NSString *str in baseArr) {
        CGFloat valueWidth = HGScreenWidth-CellWMargin*3-self.maxW;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+(cellHigh-keyHigh)/2;
        CGFloat height = (he>=cellHigh?he:cellHigh);
        HGLog(@"curr%f",height);
        NSNumber *hei = [NSNumber numberWithFloat:height];
        [self.frameArr  addObject:hei];
    }
    
}
@end
