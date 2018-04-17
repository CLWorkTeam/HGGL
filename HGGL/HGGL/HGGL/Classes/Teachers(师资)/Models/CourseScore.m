//
//  CourseScore.m
//  SYDX_2
//
//  Created by mac on 15-7-27.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CourseScore.h"
#import "TextFrame.h"
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation CourseScore
+(instancetype)courseScoreWithDict:(NSDictionary *)dict
{
    CourseScore *cs = [[CourseScore alloc]init];
    cs.student_name = dict[@"student_name"];
    cs.student_satisf = dict[@"student_satisf"];
    cs.student_evaluation = dict[@"student_evaluation"];
    cs.student_date = dict[@"student_date"];
    CGFloat h = [TextFrame frameOfText:cs.student_evaluation With:[UIFont systemFontOfSize:14] Andwidth:HGScreenWidth-Width-2*CellWMargin-CellHMargin].height;
    cs.evaluateH = h>=minH?h:minH;
    //HGLog(@"111111%f",h);
    cs.cellH = 3*minH +cs.evaluateH+5*CellHMargin;
    return cs;
}
@end
