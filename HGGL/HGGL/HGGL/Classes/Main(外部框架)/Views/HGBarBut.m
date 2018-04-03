//
//  HGBarBut.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBarBut.h"
#define HGImageRadio 0.7
@implementation HGBarBut

+(instancetype)initWithColor:(UIColor *)color andSelColor:(UIColor *)selColor andTColor:(UIColor *)TColor andFont:(UIFont *)font
{
    HGBarBut *but = [HGBarBut buttonWithType:UIButtonTypeCustom];
    [but setTitleColor:TColor forState:UIControlStateNormal];
    but.imageView.contentMode = UIViewContentModeScaleAspectFit;
    but.titleLabel.font = font;
    
    return but;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮imageview的frame
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = self.bounds.size.height*HGImageRadio;
    CGFloat imageW = self.bounds.size.width;
    CGFloat BC = imageH>=imageW?imageW:imageH;
    //    if (ZKRScreenScale == 2) {
    //        self.imageView.bounds = CGRectMake(imageX, imageY, BC/1.5, BC/1.5);
    //    }else if (ZKRScreenScale == 3)
    //    {
    self.imageView.bounds = CGRectMake(imageX, imageY, BC*HGImageRadio ,BC*HGImageRadio);
    //    }
    
    self.imageView.center =CGPointMake(imageW/2, imageH/2);
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    //设置按钮title的frame
    CGFloat titleX = 0;
    CGFloat titleY = imageH;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height*(1 - HGImageRadio);
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    if (!self.highlighted) {
        //self.backgroundColor = ZKRColor(205, 0, 36);
    }else
    {
        self.backgroundColor = HGMainColor;
    }
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
-(void)setHighlighted:(BOOL)highlighted
{
}

@end
