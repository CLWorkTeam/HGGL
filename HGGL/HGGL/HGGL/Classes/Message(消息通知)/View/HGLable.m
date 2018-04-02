//
//  HGLable.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/31.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGLable.h"

@implementation HGLable

+(UILabel *)lableWithAlignment:(NSTextAlignment)alignment Font:(NSInteger)font Color:(UIColor *)color
{
    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    lab.textAlignment = alignment;
    lab.textColor = color;
    lab.font = [UIFont systemFontOfSize:font];
    return lab;
}

@end
