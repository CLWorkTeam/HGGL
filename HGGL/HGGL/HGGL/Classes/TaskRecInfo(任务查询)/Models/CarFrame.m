//
//  CarFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CarFrame.h"
#import "Car.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height

@implementation CarFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setC:(Car *)c
{
    _c = c;
    self.baseArr = @[c.car_peoplename,c.car_mobile,c.car_start,c.car_end,c.car_waitplace,c.car_place,c.car_peoplenum,c.car_name,c.car_num,c.car_driver,c.car_drivermobile,c.car_approvalstart,c.car_approvalend ];
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
