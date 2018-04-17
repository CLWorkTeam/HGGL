//
//  ZKRImageview.m
//  SYDX_2
//
//  Created by Lei on 15/9/24.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ZKRImageview.h"

@implementation ZKRImageview

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = YES;
        //self.backgroundColor = [UIColor redColor];
    }
    return self;
}
+(instancetype)showInRect:(CGRect)rect
{
    ZKRImageview *pop = [[ZKRImageview alloc]init];
    pop.frame = rect;
    
    return pop;
}
-(void)setContentView:(UIView *)contentView
{
    _contentView = contentView;
    
    //contentView.backgroundColor = [UIColor clearColor];
    
    [self addSubview:contentView];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat x = 0;
    CGFloat y = 0;
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    _contentView.frame = CGRectMake(x, y, w, h);
}
@end
