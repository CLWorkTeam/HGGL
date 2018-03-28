//
//  HGTabBarButton.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTabBarButton.h"
#import "HGBadgeView.h"
#define HGImageRadio 0.7
#define HGTabBarButtonMargin 5
@interface HGTabBarButton ()
@property(nonatomic,weak)HGBadgeView *badgeView;
@end

@implementation HGTabBarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView.contentMode = UIViewContentModeCenter;
        
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor orangeColor] forState:UIControlStateSelected];
        
    }
    return self;
}
-(HGBadgeView *)badgeView
{
    if (_badgeView == nil) {
        HGBadgeView *but = [[HGBadgeView alloc]init];
        [self addSubview:but];
        _badgeView = but;
    }
    return _badgeView;
}
-(void)setItem:(UITabBarItem *)item
{
    _item =item;
    //下面这个方法是在item的badegeValue、image、selectedImage、title等有变化的时候就会调用
    [self observeValueForKeyPath:nil ofObject:nil change:nil context:nil];
    //实时监控badgeValue的变化
    [item addObserver:self forKeyPath:@"badgeValue" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"image" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"selectedImage" options:NSKeyValueObservingOptionNew context:nil];
    [item addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    //self.badgeView.badgeValue = _item.badgeValue;
    [self  setImage:_item.image forState:UIControlStateNormal];
    [self setImage:_item.selectedImage forState:UIControlStateSelected];
    [self setTitle:_item.title forState:UIControlStateNormal];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置按钮imageview的frame
    CGFloat imageX = 0;
    CGFloat imageY = 0;
    CGFloat imageH = self.bounds.size.height*HGImageRadio;
    CGFloat imageW = self.bounds.size.width;
    //CGFloat BC = imageH>=imageW?imageW:imageH;
    //[self.imageView sizeToFit];
    self.imageView.bounds = CGRectMake(imageX, imageY, imageW/1.5, imageH/1.5);
    self.imageView.center = CGPointMake(imageW/2, imageH/2);
    //设置按钮title的frame
    CGFloat titleX = 0;
    CGFloat titleY = self.bounds.size.height*HGImageRadio;
    CGFloat titleW = self.bounds.size.width;
    CGFloat titleH = self.bounds.size.height*(1 - HGImageRadio);
    self.titleLabel.frame = CGRectMake(titleX, titleY, titleW, titleH);
    //设置badgeview的frame
    //    CGFloat x = self.bounds.size.width- self.badgeView.bounds.size.width -ZKRTabBarButtonMargin;
    //    CGRect frame = self.badgeView.frame;
    //    frame.origin.x = x;
    //    self.badgeView.frame = frame;
    
}
-(void)dealloc
{
    [_item removeObserver:self forKeyPath:@"badgeValue" ];
    [_item removeObserver:self forKeyPath:@"image"];
    [_item removeObserver:self forKeyPath:@"selectedImage"];
    [_item removeObserver:self forKeyPath:@"title"];
    
}
//取消高亮状态
-(void)setHighlighted:(BOOL)highlighted
{
}

@end
