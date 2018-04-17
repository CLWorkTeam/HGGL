//
//  TeachToolBar.m
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachToolBar.h"
#import "UIView+Frame.h"

@interface TeachToolBar()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UIButton *selectedBut;
@end

@implementation TeachToolBar
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"基本信息",@"档案/介绍",@"教授课程",@"授课评分", nil];
    }
    return _arr;
}
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
        [self setSubviews];
    }
    return self;
}
-(void)setSubviews
{
    for (int i = 0; i<self.arr.count; i++) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:[self.arr objectAtIndex:i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.titleLabel.font = ZKRButFont;
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        //[but setTintColor:[UIColor purpleColor]];
        but.tag = i;
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        if (i == 0) {
            [UIImage imageNamed:@"red_btn_pressed.9"];
            [self clickBut:but];
            [but setBackgroundImage:[UIImage resizableLeftImageWithName:@"tab_left_normal"] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage resizableLeftImageWithName:@"tab_left_pressed"] forState:UIControlStateSelected];
        }else if(i == self.arr.count-1)
        {
            [but setBackgroundImage:[UIImage resizableRightImageWithName:@"tab_right_normal"] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage resizableRightImageWithName:@"tab_right_pressed"] forState:UIControlStateSelected];
        }else
        {
            UIImage *ima = [UIImage imageNamed:@"tab_white"];
            UIImage *image = [ima stretchableImageWithLeftCapWidth:ima.size.width*0.5 topCapHeight:ima.size.height*0.5];
            [but setBackgroundImage:image forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage resizableImageWithName:@"tab_red"] forState:UIControlStateSelected];
        }
        [self.butArr addObject:but];
    }
//    UIImageView *ima = [[UIImageView alloc]init];
//    ima.backgroundColor = [UIColor redColor];
//    self.ima = ima;
//    [self addSubview:ima];
    
    
    
}
-(void)clickBut:(UIButton *)but
{
    _selectedBut.selected = !_selectedBut.selected;
    but.selected = !but.selected;
    _selectedBut = but;
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
    _selectedBut.selected = !_selectedBut.selected;
    but.selected = !but.selected;
    _selectedBut = but;
    CGFloat w = (self.bounds.size.width-10)/self.arr.count;
    [UIView animateWithDuration:0.5 animations:^{
        self.ima.x = but.tag*w;
        
    }];

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = (self.bounds.size.width-10)/self.arr.count;
    CGFloat h = 30;
    CGFloat y = (self.height -30)/2;
//    CGFloat x = (HGScreenWidth - w*3)/2;
    int i = 0;
    for (UIButton *but in self.butArr) {
        but.frame = CGRectMake(5 + i*w, y, w, h);
        i++;
    }
    //self.ima.frame = CGRectMake(0, h, w, 3);
}
@end
