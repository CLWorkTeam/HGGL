//
//  TeacBaseFrame.m
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacBaseFrame.h"
#import "teacBaseInfo.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:HGFont]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@implementation TeacBaseFrame
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setBaseInfo:(teacBaseInfo *)baseInfo
{
    _baseInfo = baseInfo;
    
    NSArray *array1 = [NSArray arrayWithObjects:baseInfo.teacher_national,baseInfo.teacher_bith,baseInfo.teacher_cerType,baseInfo.teacher_cerNum, nil];
    NSArray *array2 = [NSArray arrayWithObjects:baseInfo.teacher_type,baseInfo.teacher_prof,baseInfo.teacher_class,baseInfo.teacher_pay, nil];
    NSArray *array3 = [NSArray arrayWithObjects:baseInfo.teacher_workUnit,baseInfo.teacher_workPlace,baseInfo.teacher_title, nil];
    NSArray *array4 = [NSArray arrayWithObjects:baseInfo.teacher_tel,baseInfo.teacher_oficTel,baseInfo.teacher_fax,baseInfo.teacher_mail,baseInfo.teacher_zipCode, nil];
    self.baseArr = [NSArray arrayWithObjects:array2,array3,array1,array4, nil];
   
    
}

-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<baseArr.count; i++) {
        NSArray *arr = [baseArr objectAtIndex:i];
        NSMutableArray *array = [[NSMutableArray array] mutableCopy];
        for (int j = 0 ; j<arr.count; j++) {
            NSString *str = [arr objectAtIndex:j];
            
//            CGFloat valueWidth = HGScreenWidth*0.65-magin;
//            CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+(cellHigh-keyHigh)/2;
//            CGFloat height = (he>=cellHigh?he:cellHigh);
//            NSNumber *hei = [NSNumber numberWithFloat:height];
            
            CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
            CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+2*CellHMargin;
            CGFloat height = (he>=minH+2*CellHMargin?he:minH+2*CellHMargin);
            NSNumber *hei = [NSNumber numberWithFloat:height];
            [array addObject:hei];
        }
        
        [self.frameArr addObject:array];

       
    }
    
}
@end
