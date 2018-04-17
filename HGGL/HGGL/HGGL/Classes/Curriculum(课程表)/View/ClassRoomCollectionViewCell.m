//
//  ClassRoomCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ClassRoomCollectionViewCell.h"
@interface ClassRoomCollectionViewCell ()
@property (nonatomic,weak) UILabel *lab;
@end
@implementation ClassRoomCollectionViewCell
-(UILabel *)lab
{
    if (_lab == nil) {
        //NSLog(@"红色");
        UILabel *lab = [[UILabel alloc]init];
        lab.text = @"教室";
        _lab = lab;
        lab.backgroundColor = [UIColor redColor];
        [self addSubview:lab];
    }
    return _lab;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.width);
    
}
@end
