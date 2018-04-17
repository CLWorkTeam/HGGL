//
//  MenteeProject.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeProject.h"
#import "TextFrame.h"
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation MenteeProject
+(instancetype)MFWithDict:(NSDictionary *)dict
{
    MenteeProject *MP = [[MenteeProject alloc]init];
    MP.project_name = dict[@"project_name"];
    MP.project_star = dict[@"project_star"];
//    MP.project_end = dict[@"project_end"];
    MP.mentee_class = dict[@"mentee_class"];
    CGFloat h = [TextFrame frameOfText:MP.project_name With:[UIFont systemFontOfSize:HGFont] Andwidth:HGScreenWidth-Width-2*CellWMargin].height;
    MP.projectNameH = h>=minH?h:minH;
    //HGLog(@"22222%f",score.projectNameH);
    MP.cellH = minH+MP.projectNameH+3*CellHMargin;
    return MP;
}
@end
