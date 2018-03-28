//
//  TKButton.m
//  泰行销
//
//  Created by edz on 2017/5/27.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKButton.h"

@implementation TKButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (CGRect)imageRectForContentRect:(CGRect)contentRect{

    return self.bounds;
}

-(CGRect)titleRectForContentRect:(CGRect)contentRect{
    
    return CGRectZero;
}

@end
