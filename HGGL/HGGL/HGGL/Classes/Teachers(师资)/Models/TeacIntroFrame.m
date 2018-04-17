//
//  TeacIntroFrame.m
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacIntroFrame.h"
#import "TeacIntroInfo.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation TeacIntroFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setInfo:(TeacIntroInfo *)info
{
    _info = info;
    self.baseArr = [NSArray arrayWithObjects:info.teacher_dec,info.teacher_judge,info.teacher_source,info.teacher_studyExp,info.teacher_workExp,info.teacher_note, nil];
    
}
-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<self.baseArr.count; i++) {
        NSString *str = [self.baseArr objectAtIndex:i];
        CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+2*CellHMargin;
        CGFloat height = (he>=(minH+2*CellHMargin)?he:minH+2*CellHMargin);
        NSNumber *hei = [NSNumber numberWithFloat:height];
        [self.frameArr addObject:hei];
    }
}
//    _arr = arr;
//    for (int i = 0; i<self.arr.count; i++) {
//        NSString *str = [self.arr objectAtIndex:i];
//        CGFloat valueWidth = HGScreenWidth*0.65-magin;
//        CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+(cellHigh-keyHigh)/2;
//        CGFloat height = (he>=cellHigh?he:cellHigh);
//        NSNumber *hei = [NSNumber numberWithFloat:height];
//        [self.frameArr addObject:hei];
//    }
//}
@end
