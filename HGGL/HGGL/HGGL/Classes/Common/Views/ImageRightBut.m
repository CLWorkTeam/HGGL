//
//  ImageRightBut.m
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ImageRightBut.h"
//#define longg 20
//#define magin 5
@implementation ImageRightBut

+(UIButton *)initWithColor:(UIColor *)color andSelColor:(UIColor *)selColor andTColor:(UIColor *)TColor andFont:(UIFont *)font
{
    UIButton *but = [ImageRightBut buttonWithType:UIButtonTypeCustom];
    [but setTitleColor:TColor forState:UIControlStateNormal];
    but.imageView.contentMode = UIViewContentModeCenter;
    
    but.titleLabel.font = font;
    
    return but;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮imageview的frame
//    CGPoint center = self.imageView.center;
//
//    self.imageView.center =CGPointMake(self.frame.size.width-center.x, self.frame.size.height/2);
//    //设置按钮title的frame
//    CGPoint lab = self.titleLabel.center;
//    self.titleLabel.center = CGPointMake(self.frame.size.width-lab.x, self.frame.size.height/2);
//    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    CGFloat W = self.imageView.bounds.size.width;
    CGFloat H = self.imageView.bounds.size.height;
    CGFloat TW = self.bounds.size.width-W-3*CellHMargin;
    CGFloat TH = self.titleLabel.bounds.size.height;
    self.imageView.bounds = CGRectMake(0, 0, W, H);
    self.imageView.center = CGPointMake(self.frame.size.width-CellHMargin-W/2, self.frame.size.height/2);
    self.titleLabel.bounds = CGRectMake(0, 0, TW, TH);
    self.titleLabel.center = CGPointMake(CellHMargin+TW/2, self.frame.size.height/2);
//    self.titleLabel.textAlignment = self.contentVerticalAlignment;
}


@end
