//
//  TKUpDownButton.m
//  泰行销
//
//  Created by taikang on 2018/3/27.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import "TKUpDownButton.h"
#import "TKButton.h"

@interface TKUpDownButton ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UIView *backV;

@property (nonatomic,strong) TKButton *clickB;

@end


@implementation TKUpDownButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }
//        [self setupSubviews];
    }
    return self;
}

- (instancetype)initWithImage:(UIImage *)image title:(NSString *)title color:(UIColor *)color{
    
    self = [super init];
    
    if (self) {
        
        for (UIView *subview in self.subviews) {
            [subview removeFromSuperview];
        }

        UIView *backV = [[UIView alloc]init];
        backV.backgroundColor = color;
        backV.layer.masksToBounds = YES;
        backV.layer.cornerRadius = 30;
        self.backV = backV;
        [self addSubview:backV];
        
        UIImageView *imageV = [[UIImageView alloc]init];
        self.imageV = imageV;
        imageV.image = image;
        imageV.userInteractionEnabled = YES;
        [backV addSubview:imageV];
        
        UILabel *label = [[UILabel alloc]init];
        label.text = title;
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor colorWithHexString:@"#333333"];
        [label sizeToFit];
        self.titleLab = label;
        [self addSubview:label];
        
        TKButton *clickB = [TKButton buttonWithType:UIButtonTypeCustom];
        clickB.backgroundColor = [UIColor clearColor];
        self.clickB = clickB;
        [self addSubview:clickB];
    }
    return self;
}



-(void)layoutSubviews{
    [super layoutSubviews];
    self.backV.width = self.backV.height = 60;
    self.backV.centerX = self.width/2;
    self.backV.centerY = self.height/2 -10;
    self.imageV.width = self.imageV.height = 44;
    self.imageV.centerX = self.backV.width/2;
    self.imageV.centerY = self.backV.height/2;
    self.titleLab.centerX = self.width/2;
    self.titleLab.y = self.backV.maxY + 5;
    self.clickB.frame = self.bounds;
}

-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents{
    self.clickB.titleLab  = self.titleLab;
    [self.clickB addTarget:target action:action forControlEvents:controlEvents];
}

@end
