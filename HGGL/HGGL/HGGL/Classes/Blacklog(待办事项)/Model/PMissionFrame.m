//
//  PMissionFrame.m
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PMissionFrame.h"
#import "MissonList.h"
#import "TextFrame.h"
#define Width 35
//#define magin 15
#define butH 60
#define TitleFont [UIFont systemFontOfSize:16]
#define ContexFont [UIFont systemFontOfSize:14]

@implementation PMissionFrame
-(void)setML:(MissonList *)ML
{
    
    _ML = ML;
    CGFloat W = HGScreenWidth    - 2*CellWMargin-65-butH;
    CGFloat h = [TextFrame frameOfText:ML.task_content With:[UIFont systemFontOfSize:HGFont] Andwidth:W].height;
    HGLog(@"---%f",h);
    CGFloat contentH = h>=minH?h:minH;
    _contentF = CGRectMake(65+CellWMargin, minH+2*CellHMargin, W, contentH);
    _cellH = 3*CellHMargin+minH+contentH;
    
}
@end
