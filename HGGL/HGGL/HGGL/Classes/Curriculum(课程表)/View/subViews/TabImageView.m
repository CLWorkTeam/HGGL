//
//  TabImageView.m
//  SYDX_2
//
//  Created by mac on 15-6-9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TabImageView.h"

@implementation TabImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)showInRect:(CGRect)rect
{
    TabImageView *pop = [[TabImageView alloc]init];
    pop.frame = rect;
    return pop;
}
@end
