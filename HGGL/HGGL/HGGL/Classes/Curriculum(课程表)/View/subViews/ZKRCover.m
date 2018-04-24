//
//  ZKRCover.m
//  SYDX_2
//
//  Created by mac on 15-6-10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ZKRCover.h"

@implementation ZKRCover

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)show
{
    ZKRCover *cover = [[ZKRCover alloc]initWithFrame:HGScreenSize];
    [HGKeywindow addSubview:cover];
    return cover;
}
-(void)setDimBackGround:(BOOL)dimBackGround
{
    _dimBackGround = dimBackGround;
    if (_dimBackGround) {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.3;
    }else{
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1;
        
    }
}
+(void)dismiss
{
    for (UIView *view in HGKeywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [ZKRCover dismiss];
    if (_ZKRCoverDismiss) {
        _ZKRCoverDismiss();
    }
}
@end
