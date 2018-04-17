//
//  ClassNumCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ClassNumCollectionViewCell.h"
@interface ClassNumCollectionViewCell ()
@property (nonatomic,weak) UILabel *lab;
@end
@implementation ClassNumCollectionViewCell
-(UILabel *)lab
{
    if (_lab == nil) {
        UILabel *lab = [[UILabel alloc]init];
        lab.text = _num;
        _lab = lab;
        lab.backgroundColor = [UIColor orangeColor];
        [self addSubview:lab];
        
    }
    return  _lab;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lab.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height );
                                
}
@end
