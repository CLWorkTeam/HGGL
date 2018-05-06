//
//  TeachToolBar.m
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachToolBar.h"
#import "UIView+Frame.h"
#define bothMargin 10
@interface TeachToolBar()

@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UIButton *selectedBut;
@end

@implementation TeachToolBar

-(NSMutableArray *)butArr
{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self == [super initWithFrame:frame])
    {
        self.backgroundColor = [UIColor whiteColor];
//        [self setSubviews];
    }
    return self;
}
-(void)setArr:(NSArray *)arr
{
    _arr = arr;
    for (int i = 0; i<arr.count; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:[arr objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:HGMainColor forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.titleLabel.font = ZKRButFont;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[but setTintColor:[UIColor purpleColor]];
        but.tag = i;
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        [but setBackgroundColor:HGGrayColor];
        but.layer.masksToBounds = YES;
        but.layer.cornerRadius = 5;
        
        if (i == 0) {

            [self clickBut:but];

        }
        [self.butArr addObject:but];
    }

    
    
    
}
-(void)clickBut:(UIButton *)but
{
    if ([but isEqual:_selectedBut]) {
        return;
    }
    _selectedBut.selected = !_selectedBut.selected;
    but.selected = !but.selected;
    _selectedBut.backgroundColor = HGGrayColor;
    _selectedBut = but;
    but.backgroundColor = HGMainColor;

    CGFloat w = (self.bounds.size.width-10)/self.arr.count;
    [UIView animateWithDuration:0.5 animations:^{
        self.ima.x = but.tag*w;

    }];
    if (_clickChange) {
        _clickChange(but.tag);
        
    }
}
-(void)clickbutWith:(NSInteger) tag
{
    UIButton *but = [self.butArr objectAtIndex:tag];
    [self clickBut:but];

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = (self.bounds.size.width-(self.arr.count+1)*bothMargin)/self.arr.count;
    CGFloat h = 30;
    CGFloat y = (self.height -h)/2;
    int i = 0;
    
    for (UIButton *but in self.butArr) {
        but.frame = CGRectMake(bothMargin + i*(w+bothMargin), y, w, h);
        i++;
    }
//    for (id view in self.subviews) {
//        if ([view isKindOfClass:(NSClassFromString(@"_UIToolbarContentView"))]) {
//            UIView *testView = view;
//            testView.userInteractionEnabled = NO;
//        }
//    }
}
@end
