//
//  MenteeToolBar.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeToolBar.h"
@interface MenteeToolBar()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UIButton *selectedBut;
@end
@implementation MenteeToolBar

-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"基本信息",@"参与项目信息", nil];
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
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = ZKRButFont;
        //[but setTintColor:[UIColor purpleColor]];
        //but setBackgroundImage:[UIImage] forState:<#(UIControlState)#>
        //UIImage imageNamed:@"tab_right_normal"
        but.tag = i;
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        [self.butArr addObject:but];
        if (i == 0) {
            [self clickBut:but];
            [but setBackgroundImage:[UIImage resizableLeftImageWithName:@"tab_left_normal"] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage resizableLeftImageWithName:@"tab_left_pressed"] forState:UIControlStateSelected];
        }else if (i == self.arr.count-1)
        {
            [but setBackgroundImage:[UIImage resizableRightImageWithName:@"tab_right_normal"] forState:UIControlStateNormal];
            [but setBackgroundImage:[UIImage resizableRightImageWithName:@"tab_right_pressed" ] forState:UIControlStateSelected];
        }
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
    CGFloat w = self.bounds.size.width/2;
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
    CGFloat w = self.bounds.size.width/2;
    [UIView animateWithDuration:0.5 animations:^{
        self.ima.x = but.tag*w;
        
    }];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = 100;
    CGFloat h = 30;
    CGFloat y = (self.height-h)/2;
    CGFloat x = (HGScreenWidth-self.arr.count*100)/2;
    int i = 0;
    for (UIButton *but in self.butArr) {
        but.frame = CGRectMake(x+i*w, y, w, h);
        i++;
    }
    self.ima.frame = CGRectMake(0, h, w, 3);
}

@end
