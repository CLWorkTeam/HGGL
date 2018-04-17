//
//  CurrImageView.m
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrImageView.h"

@implementation CurrImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(void)dismiss
{
    for (UIView *view in HGKeywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}
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
    CurrImageView *pop = [[CurrImageView alloc]init];
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
