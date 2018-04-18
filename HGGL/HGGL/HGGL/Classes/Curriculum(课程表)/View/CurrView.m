//
//  CurrView.m
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrView.h"
#import "Date.h"
#import "TimerTransform.h"
#import "WeekToolBar.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "ImageRightBut.h"
#define ZKRCurrFont [UIFont systemFontOfSize:14]
//#import "CurrTableViewController.h"
@interface CurrView()


@property (nonatomic,weak) UILabel *lab;
@property(nonatomic, weak) UILabel *zhuLab;


@end
@implementation CurrView


-(WeekToolBar *)toolBar
{
    if (_toolBar == nil) {
        WeekToolBar *toolBar = [[WeekToolBar alloc]init];
//        WeakSelf
//        toolBar.weekDayClick = ^(NSString *date) {
//            
//        };
        [self addSubview:toolBar];
        [toolBar layoutIfNeeded];
        _toolBar = toolBar;
    }
    return _toolBar;
}
-(UIButton *)but
{
    if (_but == nil) {
        UIButton *but = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        [but setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
        [but setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
        but.titleLabel.font = ZKRCurrFont;
//        but.backgroundColor = [UIColor redColor];
        [but setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(butClick) forControlEvents:UIControlEventTouchUpInside];
        //[self.arr addObject:but];
        _but = but ;
        [self addSubview:but];
    }

    return _but;
}
-(UILabel *)lab
{
    if (_lab == nil) {
        UILabel *lab = [[UILabel alloc]init];
        lab.numberOfLines = 0;
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        lab.font = ZKRCurrFont;
        
        lab.text = @"请选择";
        _lab = lab;
        [self addSubview:lab];
    }
    return _lab;
}
-(UILabel *)zhuLab
{
    if (_zhuLab == nil) {
        UILabel *lab = [[UILabel alloc]init];
        lab.backgroundColor = [UIColor whiteColor];
        lab.text = @"注:点击资源类型选择你想要选的类型,点击占用情况查看每个教室的占用详情信息";
        lab.textColor = [UIColor redColor];
        
        lab.numberOfLines = 2;
        lab.font = [UIFont systemFontOfSize:11];
        lab.textAlignment = NSTextAlignmentCenter;
        _zhuLab = lab;
        [self addSubview:lab];
    }
    return _zhuLab;
}
-(void)setWeekOfYear:(Date *)weekOfYear
{
    _weekOfYear = weekOfYear;
 
    [self.but setTitle:[NSString stringWithFormat:@"第%@周 %@--%@",weekOfYear.week,weekOfYear.weekStar,weekOfYear.weekEnd] forState:UIControlStateNormal];
}
-(void)setToday:(NSString *)today
{
    //NSLog(@"toolbar");
    _today = today;
     NSArray *arr = [TimerTransform AllDayOfThisWeek:today];
    //[self.toolBar setDate:arr];
    self.toolBar.date = arr;

    
}
-(void)butClick
{
    self.but.selected = !self.but.selected;
    if (self.but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            
            [CurrImageView  dismiss];
            self.but.selected = NO;
        
        };
        if (_datePicker) {
            _datePicker();
        }
    }else{
        [CurrImageView dismiss];
    }
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
       
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //NSLog(@"进来了currview");
    [self setButtonFrame];
    [self setToolBarFrame];
}
-(void)setButtonFrame
{
//    CGFloat x = self.bounds.size.width /3;
    CGFloat y = 3;
//
    [self.lab sizeToFit];
    CGFloat width = self.lab.width+5*2;
    CGFloat heigh = 34;

    self.lab.frame = CGRectMake(0, y, width, heigh);
    _but.frame = CGRectMake(self.lab.maxX, y, self.width-self.lab.width-3, heigh);
    //self.rect = _but.frame;
    
}
-(void )setToolBarFrame
{
    CGFloat x = 0;
    CGFloat y = self.lab.maxY+3;
    CGFloat width = self.bounds.size.width;
    CGFloat heigh = 50;
    
    self.toolBar.frame = CGRectMake(x, y, width, heigh);
//    self.zhuLab.frame = CGRectMake(5, 90, HGScreenWidth-10, 27);

}
@end
