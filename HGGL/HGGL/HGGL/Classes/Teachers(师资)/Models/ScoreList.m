//
//  ScoreList.m
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ScoreList.h"
#import "TextFrame.h"
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation ScoreList
+(instancetype)scoreWithDict:(NSDictionary *)dict
{
    ScoreList *score = [[ScoreList alloc]init];
    score.projectCourse_id = dict[@"projectCourse_id"];
    score.course_name = dict[@"course_name"];
    score.project_name = dict[@"project_name"];
    score.course_name = dict[@"course_name"];
    score.course_score = dict[@"course_score"];
    score.course_date = dict[@"course_date"];
    CGFloat ch = [TextFrame frameOfText:score.course_name With:[UIFont systemFontOfSize:14] Andwidth:HGScreenWidth-Width-CellWMargin*2-CellHMargin].height;
    score.courseNameH = ch>=minH?ch:minH;
    CGFloat ph = [TextFrame frameOfText:score.project_name With:[UIFont systemFontOfSize:14] Andwidth:HGScreenWidth-Width-CellWMargin*2-CellHMargin].height;
    score.projectNameH = ph>=minH?ph:minH;
    HGLog(@"22222%f",score.projectNameH);
    score.cellH = 2*minH +score.projectNameH+score.courseNameH+5*CellHMargin;
    
    return score;
}
@end
