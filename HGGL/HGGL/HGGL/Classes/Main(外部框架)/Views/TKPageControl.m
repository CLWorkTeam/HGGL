//
//  TKPageControl.m
//  泰行销
//
//  Created by 磊陈 on 2017/5/3.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKPageControl.h"
@interface TKPageControl ()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,weak) UIButton *currentButton;
@end
@implementation TKPageControl
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
        
    }
    return _array;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setNumberOfPages:(NSInteger)numberOfPages
{
    _numberOfPages = numberOfPages;
    for (int i = 0; i<numberOfPages; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 700+i;
        [self addSubview:button];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.array addObject:button];
    }
    
}
-(void)clickButton:(UIButton *)button
{
    if ([button isEqual:self.currentButton]) {
        return;
    }else
    {
        self.currentButton.selected = NO;
        self.currentButton.backgroundColor = self.pageIndicatorTintColor;
        button.selected = YES;
        button.backgroundColor = self.currentPageIndicatorTintColor;
        self.currentButton  = button;
        
    }
}

-(void)setCurrentPage:(NSInteger)currentPage
{
    _currentPage = currentPage;
    for (UIButton *button in self.array) {
        if ((button.tag-700) == currentPage) {
            [self clickButton:button];
        }
    }
}
-(void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor
{
    _pageIndicatorTintColor = pageIndicatorTintColor;
    for (UIButton *button in self.array) {
        if (button.selected == NO) {
            button.backgroundColor = pageIndicatorTintColor;
        }
    }
}
-(void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor
{
    _currentPageIndicatorTintColor = currentPageIndicatorTintColor;
    for (UIButton *button in self.array) {
        if (button.selected == YES) {
            button.backgroundColor = currentPageIndicatorTintColor;
        }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    for (int i = 0; i<self.array.count; i++) {
        UIButton *button = self.array[i];
        CGFloat width = WIDTH_PT(14);
        CGFloat margin = WIDTH_PT(20);
        button.frame = CGRectMake((width+margin)*i, 0, width, width);
        button.layer.masksToBounds = YES;
        button.layer.cornerRadius = width/2;
    }
    self.contentSize = CGSizeMake(self.array.count*(WIDTH_PT(20)+WIDTH_PT(10))-WIDTH_PT(10), HEIGHT_PT(20));
}
@end
