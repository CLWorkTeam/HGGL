//
//  MenteeFrame.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeFrame.h"
#import "TextFrame.h"
#import "Mentee.h"
@implementation MenteeFrame
#define cellHigh minH+2*CellHMargin
#define keyWidth 70
//#define magin 8
#define valueFont [UIFont systemFontOfSize:HGFont]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setBaseInfo:(Mentee *)baseInfo
{
    _baseInfo = baseInfo;
    
    NSArray *array1 = [NSArray arrayWithObjects:baseInfo.mentee_workUnit,baseInfo.mentee_duty,baseInfo.mentee_degree,baseInfo.mentee_politicsStatus, nil];
    NSArray *array2 = [NSArray arrayWithObjects:baseInfo.mentee_nation,baseInfo.mentee_birthday,baseInfo.mentee_age,baseInfo.mentee_idCard,baseInfo.mentee_place, nil];
    NSArray *array3 = [NSArray arrayWithObjects:baseInfo.mentee_email,baseInfo.mentee_note, nil];
    HGLog(@"%@",array2);
    self.baseArr = [NSArray arrayWithObjects:array1,array2,array3, nil];
    
    
}

-(void)setBaseArr:(NSArray *)baseArr
{
    _baseArr = baseArr;
    for (int i = 0; i<baseArr.count; i++) {
        NSArray *arr = [baseArr objectAtIndex:i];
        NSMutableArray *array = [[NSMutableArray array] mutableCopy];
        for (int i = 0 ; i<arr.count; i++) {
            NSString *str = [arr objectAtIndex:i];
            
            CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
            CGFloat he = [TextFrame frameOfText:str With:valueFont Andwidth:valueWidth].height+2*CellHMargin;
            CGFloat height = (he>=cellHigh?he:cellHigh);
            NSNumber *hei = [NSNumber numberWithFloat:height];
            //HGLog(@"%f",he);
            [array addObject:hei];
        }
        
        [self.frameArr addObject:array];
        
        
    }
    
}
@end
