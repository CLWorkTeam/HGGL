//
//  ProjectTime.m
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProjectTime.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HcdDateTimePickerView.h"
#define magin 5
@interface ProjectTime()<UITextFieldDelegate>
@property (nonatomic,weak) UIButton *start;
@property (nonatomic,weak) UIButton *end;
@property (nonatomic,weak) UIButton *defaut;
@property (nonatomic,weak) UILabel *lab;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end
@implementation ProjectTime

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
        self.backgroundColor = HGGrayColor;
        UIButton *start = [UIButton buttonWithType:UIButtonTypeCustom];
        start.titleLabel.font = [UIFont systemFontOfSize:12];
        [start setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.start = start;
        start.tag = 300;
        [self addSubview:start];
        
        UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:12 Color:[UIColor blackColor]];
        lab.text = @"--";
        self.lab = lab;
        [self addSubview:lab];
        
        UIButton *end = [UIButton buttonWithType:UIButtonTypeCustom];
        end.titleLabel.font = [UIFont systemFontOfSize:12];
        [end setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.end = end;
        end.tag = 301;
        [self addSubview:end];
        
        UIButton *defaut = [UIButton buttonWithType:UIButtonTypeCustom];
        [defaut setTitle:@"恢复默认" forState:UIControlStateNormal];
        defaut.titleLabel.font = [UIFont systemFontOfSize:12];
        [defaut setTitleColor:HGMainColor forState:UIControlStateNormal];
        self.defaut = defaut;
        defaut.tag = 302;
        [self addSubview:defaut];
        
        [self.start addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.end addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.defaut addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}


-(void)clickButton:(UIButton *)but
{
    NSInteger tag = but.tag;
    
    switch (tag) {
        case 300:
        {
            [self showTimeView:YES];
        }
            break;
        case 301:
        {
            [self showTimeView:NO];
        }
            break;
        case 302:
        {
            [self.start setTitle:@"" forState:UIControlStateNormal];
            [self.end setTitle:@"" forState:UIControlStateNormal];
            self.parama.project_start = @"";
            self.parama.project_end = @"";
            if (_popBlock) {
                _popBlock(self.parama);
            }
        }
            break;
            
        default:
            break;
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    
    
    [self.lab sizeToFit];
    
    [self.defaut sizeToFit];
    
    self.defaut.frame = CGRectMake(self.width-CellWMargin-self.defaut.width, self.height-magin-self.defaut.height, self.defaut.width, self.defaut.height);
    
    self.lab.bounds = CGRectMake(0, 0, self.lab.width+2*magin, self.height-2*magin);
    
    CGFloat buttonW = (self.width-self.defaut.width-3*CellWMargin-self.lab.width)/2;
    
    self.start.frame = CGRectMake(CellWMargin, magin, buttonW, self.height-2*magin);
    self.lab.center = CGPointMake(self.start.maxX+self.lab.width/2, self.height/2);
    self.end.frame = CGRectMake(self.lab.maxX, magin, buttonW, self.height-2*magin);
    
    self.start.layer.masksToBounds = YES;
    self.start.layer.cornerRadius = self.start.height/2;
    self.start.layer.borderColor = [UIColor grayColor].CGColor;
    self.start.layer.borderWidth = 1;
    
    self.end.layer.masksToBounds = YES;
    self.end.layer.cornerRadius = self.end.height/2;
    self.end.layer.borderColor = [UIColor grayColor].CGColor;
    self.end.layer.borderWidth = 1;

}
-(void)showTimeView:(BOOL)isStart
{
    HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [fomatter dateFromString:datetimeStr];
        datetimeStr = [fomatter stringFromDate:date];
        if (isStart) {
            UIButton *but = self.start;
            [but setTitle:datetimeStr forState:UIControlStateNormal];
            self.parama.project_start = datetimeStr;
            [self endEditing:YES];
        }else
        {
            UIButton *but = self.end;
            [but setTitle:datetimeStr forState:UIControlStateNormal];
            self.parama.project_end = datetimeStr;
            [self endEditing:YES];
        }
        if (_popBlock) {
            _popBlock(self.parama);
        }
    };
    [HGKeywindow addSubview:dateTimePickerView];
    [dateTimePickerView showHcdDateTimePicker];
}
@end



