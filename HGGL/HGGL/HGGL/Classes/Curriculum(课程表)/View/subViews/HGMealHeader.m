//
//  HGMealHeader.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMealHeader.h"
#import "TeachToolBar.h"
#import "HcdDateTimePickerView.h"
@interface HGMealHeader ()
@property (nonatomic,weak) TeachToolBar *toolBar;
@property (nonatomic,weak) UIButton *dateButton;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end
@implementation HGMealHeader
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        TeachToolBar *toolBar = [[TeachToolBar alloc]init];
        toolBar.backgroundColor = [UIColor whiteColor];
        WeakSelf
        toolBar.clickChange = ^(NSInteger page) {
            
            switch (page) {
                case 0:
                {
                    weakSelf.type = @"1";
                }
                    break;
                case 1:
                {
                    weakSelf.type = @"2";
                }
                    break;
                case 2:
                {
                    weakSelf.type = @"3";
                }
                    break;
                    
                default:
                    break;
            }
            if (weakSelf.clickBlock) {
                
                weakSelf.clickBlock(weakSelf.type,weakSelf.date);
                
            }
            
        };
        toolBar.arr = [NSArray arrayWithObjects:@"早餐",@"午餐",@"晚餐", nil];
        self.toolBar = toolBar;
        [self addSubview:toolBar];
        
        NSString *currentDate = [self.formatter stringFromDate:[NSDate date]];
        UIButton *dateButton = [self creatButtonWithTitle:currentDate];
        dateButton.tag = 201;
        [self addSubview:dateButton];
        self.dateButton  = dateButton ;
        
        
        
    }
    return self;
}
-(UIButton *)creatButtonWithTitle:(NSString *)title
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [but setTitleColor:HGMainColor forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:12];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:but];
    [but setBackgroundColor:HGColor(0, 209, 255, 1)];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    return but;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.dateButton.frame = CGRectMake(10, 6.5, self.width-2*10, 30);
    self.toolBar.frame = CGRectMake(0, self.dateButton.maxY, self.width, 43);
    
    
}
-(void)clickBut:(UIButton *)button
{
    switch (button.tag-200) {
        case 1:
        {
            [self showTimeView];
        }
            break;
            
            
        default:
            break;
    }
}
-(void)showTimeView
{
    HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        
        NSDate *date = [self.formatter dateFromString:datetimeStr];
        [self.dateButton setTitle:[self.formatter stringFromDate:date] forState:UIControlStateNormal];
        self.date = [self.formatter stringFromDate:date];
        
        
        if (_clickBlock) {
            _clickBlock(self.type,self.date);
        }
    };
    [HGKeywindow addSubview:dateTimePickerView];
    [dateTimePickerView showHcdDateTimePicker];
}


@end
