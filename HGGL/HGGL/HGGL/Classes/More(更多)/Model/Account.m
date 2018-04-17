//
//  Account.m
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "Account.h"
#import "User.h"
#import "TextFrame.h"
//#define cellHigh 44
#define keyWidth 70
//#define magin 8
//#define valueFont [UIFont systemFontOfSize:14]
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height

@implementation Account
-(NSMutableArray *)frameArr
{
    if (_frameArr == nil) {
        _frameArr = [NSMutableArray array];
    }
    return _frameArr;
}
-(void)setUser:(User *)user
{
    _user = user;
    NSMutableArray *arr1 = [NSMutableArray arrayWithObjects:user.user_name,user.user_sex,user.user_idCard,user.user_duty, nil];
    NSMutableArray *arr2 = [NSMutableArray arrayWithObjects:user.user_tel,user.user_phone,user.user_email,user.user_note, nil];
    self.baseArr = [NSMutableArray arrayWithObjects:arr1,arr2, nil];
}
-(void)setBaseArr:(NSMutableArray *)baseArr
{
    _baseArr = baseArr;

    for (int i = 0; i<self.baseArr.count; i++) {
        NSArray *arr = [baseArr objectAtIndex:i];
        NSMutableArray *array = [[NSMutableArray array] mutableCopy];
        for (NSString *str in arr) {

            CGFloat valueWidth = HGScreenWidth*0.65-CellWMargin;
            CGFloat he = [TextFrame frameOfText:str With:[UIFont systemFontOfSize:HGFont] Andwidth:valueWidth].height + 2*CellHMargin;
            CGFloat height = (he>=(minH+2*CellHMargin)?he:(minH+2*CellHMargin));
            HGLog(@"12345--%f",height);
            NSNumber *hei = [NSNumber numberWithFloat:height];
            [array addObject:hei];

        }
        
        [self.frameArr addObject:array];
    }
}
@end
