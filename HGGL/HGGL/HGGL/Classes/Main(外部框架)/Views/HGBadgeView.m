//
//  HGBadgeView.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBadgeView.h"

@implementation HGBadgeView

-(void)setBadgeValue:(NSString *)badgeValue
{
    _badgeValue = [badgeValue copy];
    if ([_badgeValue isEqualToString:@"0"]||_badgeValue.length == 0) {
        self.hidden = YES;
    }else{
        self.hidden = NO;
    }
    NSMutableDictionary *textAtt = [NSMutableDictionary dictionary];
    textAtt[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    //计算文字的尺寸
    CGSize size = [_badgeValue sizeWithAttributes:textAtt];
    if ([_badgeValue integerValue] >=100) {
        _badgeValue = @"99+";
        
    }
    [self setTitle:_badgeValue forState:UIControlStateNormal];
    // NSLog(@"badge");
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.userInteractionEnabled = NO;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setBackgroundColor:[UIColor redColor]];
        [self sizeToFit];
    }
    return self;
}

@end
