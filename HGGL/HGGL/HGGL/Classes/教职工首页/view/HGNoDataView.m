//
//  HGNoDataView.m
//  HGGL
//
//  Created by taikang on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGNoDataView.h"

@interface HGNoDataView ()

@end

@implementation HGNoDataView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self addLabel];
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickLab:)];
        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (void)addLabel{
    
    UILabel *alertLab = [[UILabel alloc]init];
    alertLab.text = @"暂无数据";
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    alertLab.textColor = [UIColor lightGrayColor];
    self.label = alertLab;
    [self addSubview:alertLab];
    
}

- (void)clickLab:(UITapGestureRecognizer *)ges{
    if (self.block) {
        self.block();
    }
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.label.frame = self.bounds;
}

@end
