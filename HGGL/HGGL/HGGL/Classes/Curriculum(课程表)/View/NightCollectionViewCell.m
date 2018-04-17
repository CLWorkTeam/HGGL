//
//  NightCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-4.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "NightCollectionViewCell.h"
@interface NightCollectionViewCell ()
@property (nonatomic, weak) UIButton *but;
@end
@implementation NightCollectionViewCell
-(UIButton *)but
{
    if (_but == nil) {
        //NSLog(@"蓝色");
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        but.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        but.titleLabel.textAlignment = NSTextAlignmentLeft;
        but.backgroundColor = [UIColor blueColor];
        [but addTarget:self action:@selector(clickBut) forControlEvents:UIControlEventTouchUpInside];
        _but = but;
        [self addSubview:but];
        
        
    }
    return  _but;
}
-(void)clickBut
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.but.frame = self.bounds;
}
@end
