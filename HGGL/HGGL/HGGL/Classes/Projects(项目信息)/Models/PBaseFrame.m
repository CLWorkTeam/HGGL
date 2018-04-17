//
//  PBaseFrame.m
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PBaseFrame.h"
#import "TextFrame.h"
#import "ProjectList.h"
#define cellHigh minH+2*CellHMargin
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:HGFont]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height

@implementation PBaseFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setPList:(ProjectList *)PList
{
   
    _PList = PList;
    self.baseArr = @[PList.project_name,PList.running_status,PList.project_id,PList.project_type,PList.project_nature,PList.project_classroom,[NSString stringWithFormat:@"%@至%@",PList.project_start,PList.project_end],PList.project_manager,PList.project_courseManager,PList.project_planNum,PList.project_factNum,PList.project_director,PList.projectUrl_confirm_list];
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<self.baseArr.count; i++) {
        NSString *str = [self.baseArr objectAtIndex:i];
        CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+CellHMargin*2;
        CGFloat height = (he>=cellHigh?he:cellHigh);
        NSNumber *hei = [NSNumber numberWithFloat:height];
        [self.frameArr addObject:hei];
    }
}
@end
