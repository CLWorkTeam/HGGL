//
//  CurrFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-7.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrFrame.h"
#import "CurrseList.h"
#import "TextFrame.h"
#define cellHigh 44
#define keyWidth 70
#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation CurrFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setCL:(CurrseList *)CL
{
    _CL = CL;
    self.baseArr = @[CL.project_name,CL.course_name,self.course_classroom,CL.course_teacher,CL.teacher_pickup,[NSString stringWithFormat:@"%@-%@",CL.course_start,CL.course_end],CL.teacher_info,CL.course_info,CL.course_remark];
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (NSString *str in baseArr) {
        CGFloat valueWidth = HGScreenWidth*0.65-magin;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+(cellHigh-keyHigh)/2;
        CGFloat height = (he>=cellHigh?he:cellHigh);
        HGLog(@"curr%f",height);
        NSNumber *hei = [NSNumber numberWithFloat:height];
        [self.frameArr  addObject:hei];
    }
}
@end
