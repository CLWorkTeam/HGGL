//
//  ResearchFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchFrame.h"
#import "ResearchList.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 15
#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation ResearchFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setRL:(ResearchList *)RL
{
    _RL = RL;
    self.baseArr = @[RL.research_name,RL.research_type,RL.research_manager,RL.research_status,RL.research_category,RL.research_funds,RL.research_has_funds,RL.research_not_funds];
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<self.baseArr.count; i++) {
        NSString *str = [self.baseArr objectAtIndex:i];
        CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+2*CellHMargin;
        CGFloat height = (he>=(minH+2*CellHMargin)?he:(minH+CellHMargin*2));
        NSNumber *hei = [NSNumber numberWithFloat:height];
        [self.frameArr addObject:hei];
    }
}
@end
