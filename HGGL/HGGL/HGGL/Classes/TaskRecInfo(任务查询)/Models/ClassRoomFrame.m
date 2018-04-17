//
//  ClassRoomFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ClassRoomFrame.h"
#import "ClassRoom.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation ClassRoomFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setCr:(ClassRoom *)cr
{
    _cr = cr;
    self.baseArr = @[cr.classroom_num,cr.classroom_use,cr.classroom_start,cr.classroom_end,cr.classroom_price,cr.classroom_note];
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<self.baseArr.count; i++) {
        NSString *str = [self.baseArr objectAtIndex:i];
        CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+2*CellHMargin;
        CGFloat height = (he>=minH+2*CellHMargin?he:minH+2*CellHMargin);
        NSNumber *hei = [NSNumber numberWithFloat:height];
        
        [self.frameArr addObject:hei];    }
}
@end
