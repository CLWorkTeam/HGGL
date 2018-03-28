//
//  HGTabbar.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTabbar.h"
#import "HGTabBarButton.h"
@interface HGTabbar ()
@property (nonatomic ,weak)UIButton *selectedBut;
@property (nonatomic,strong)NSMutableArray *butArray;
@end
@implementation HGTabbar

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //        UIImageView *ima = [[UIImageView alloc]init];
        //        self.ima = ima;
        //        ima.image = [UIImage imageNamed:@"bottom"];
        //        //ima.backgroundColor = [UIColor grayColor];
        //        self.ima.userInteractionEnabled = YES;
        //        [self addSubview:ima];
        self.backgroundColor = HGColor(244, 244, 244);
    }
    return self;
}
-(NSMutableArray *)butArray
{
    if (_butArray == nil) {
        _butArray = [NSMutableArray array];
    }
    return _butArray;
}
-(void)addButtonWith:(UITabBarItem *)item
{
    HGTabBarButton *but = [[HGTabBarButton alloc]init];
    but.item = item;
    but.tag = self.butArray.count;
    [but addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    if (but.tag == 0) {
        [self clickButton:but];
    }
    [self   addSubview:but];
    [self.butArray addObject:but];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.ima.frame = self.bounds;
    NSInteger count = self.butArray.count ;
    CGFloat high = self.bounds.size.height;
    CGFloat width = self.bounds.size.width/count;
    CGFloat x = 0;
    CGFloat y = 0;
    int i = 0;
    for (UIButton *but in self.butArray) {
        x = i*width;
        but.frame = CGRectMake(x, y, width, high);
        i++;
    }
}
-(void)clickButton:(UIButton *)but
{
    _selectedBut.selected = NO;
    but.selected = YES;
    _selectedBut = but;
    if (_tabBarBlock) {
        _tabBarBlock(but.tag);
    }
    //ZKRLog(@"%ld",but.tag);
    
}

@end
