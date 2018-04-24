//
//  WeekDayCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "WeekDayCollectionViewCell.h"
@interface WeekDayCollectionViewCell ()
@property (nonatomic,weak) UILabel *day;

@end
@implementation WeekDayCollectionViewCell
-(UILabel *)day
{
    if (_day == nil) {
        UILabel *lab = [[UILabel alloc]init];
        lab.textAlignment = NSTextAlignmentCenter;
        [_day setText:_str];
        _day = lab;
        lab.backgroundColor = [UIColor greenColor];
        [self addSubview:lab];
        
    }
    return _day;
}
-(void)setStr:(NSString *)str
{
    _str = str;
    HGLog(@"%@",str);
    self.day.text = self.str;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.day.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
}
@end
