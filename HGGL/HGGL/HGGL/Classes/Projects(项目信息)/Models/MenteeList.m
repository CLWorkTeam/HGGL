//
//  MenteeList.m
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeList.h"
#import "TextFrame.h"
//#define margin 8
//#define labHeigh 25
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@implementation MenteeList
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.mentee_name = dict[@"mentee_name"];
        self.mentee_sex = dict[@"mentee_sex"];
        self.mentee_group = dict[@"mentee_group"];
        self.mentee_tel = dict[@"mentee_tel"];
        self.mentee_workUnit = dict[@"mentee_workUnit"];
        self.mentee_duty = dict[@"mentee_duty"];
        CGFloat H = [TextFrame frameOfText:[NSString stringWithFormat:@"%@/%@",self.mentee_workUnit,self.mentee_duty] With:[UIFont systemFontOfSize:HGFont] Andwidth:(HGScreenWidth-2*CellWMargin-CellHMargin-Width)].height;
        self.unitDutyH = H>=minH?H:minH;
        self.cellH = minH+self.unitDutyH+3*CellHMargin;
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
@end
