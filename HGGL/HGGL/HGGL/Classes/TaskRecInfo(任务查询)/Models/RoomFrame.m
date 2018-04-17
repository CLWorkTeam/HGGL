//
//  RoomFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "RoomFrame.h"
#import "room.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height

@implementation RoomFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setR:(room *)r
{
    _r = r;
    self.baseArr = @[r.accom_name,r.accom_sex,r.accom_position,r.accom_floor,r.accom_num,r.accom_price,r.accom_otherprice,r.accom_status,r.accom_type];
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
