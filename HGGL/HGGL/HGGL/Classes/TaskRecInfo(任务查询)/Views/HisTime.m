//
//  HisTime.m
//  SYDX_2
//
//  Created by mac on 15-8-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "HisTime.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
@interface HisTime()<UITextFieldDelegate>
@property (nonatomic,weak) UITextField *start;
@property (nonatomic,weak) UITextField *end;
@property (nonatomic,weak) UILabel *lab;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) NSDateFormatter *formatter;
@property (nonatomic,strong) UIView *accessoryView;
@property (nonatomic,weak) UIButton *cancle;
@property (nonatomic,weak) UIButton *sure;
@property (nonatomic,assign) BOOL left;
@property (nonatomic,strong) UIButton *Y;

@end
@implementation HisTime
-(UIDatePicker *)datePicker
{
    if (_datePicker == nil) {
        UIDatePicker *picker = [[UIDatePicker alloc]init];
        //设置为中文
        picker.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh-Hans"];
        
        //显示的模式
        picker.datePickerMode = UIDatePickerModeDate;
        _datePicker = picker;
    }
    return _datePicker;
}
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(UIView *)accessoryView
{
    if (_accessoryView == nil) {
        UIView *accessoryView = [[UIView alloc]init];
        accessoryView.frame = CGRectMake(0, 0, HGScreenWidth, 30);
        accessoryView.backgroundColor = [UIColor lightGrayColor];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = [UIColor redColor];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];

        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
        cancle.bounds = CGRectMake(0, 0, 60, 30);
        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        self.Y = sure;
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
        _accessoryView = accessoryView;
        
    }
    return _accessoryView;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (textField.tag == 0) {
        [self.Y removeTarget:self action:@selector(sureB) forControlEvents:UIControlEventTouchUpInside];
        [self.Y addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        [self.Y removeTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        [self.Y addTarget:self action:@selector(sureB) forControlEvents:UIControlEventTouchUpInside];
    }
    HGLog(@"bianji");
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    HGLog(@"did");
}
-(void)cancleA
{
    [self endEditing:YES];
    //[ZKRCover dismiss];
    //[CurrImageView dismiss];
}
-(void)sureA
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.start.text = date;
    
    [self endEditing:YES];
}
-(void)sureB
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.end.text = date;
    [self endEditing:YES];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITextField *start = [[UITextField alloc]init];
        start.borderStyle = UITextBorderStyleRoundedRect;
        [start setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        start.text = [self.formatter stringFromDate:[NSDate date]];
        start.inputView = self.datePicker;
        start.delegate = self;
        start.inputAccessoryView = self.accessoryView;
        self.start = start;
        start.tag = 0;
        [self addSubview:start];
        UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor redColor]];
        //lab.text = @"至";
        self.lab = lab;
        [self addSubview:lab];
//        UITextField *end = [[UITextField alloc] init];
//        end.borderStyle = UITextBorderStyleRoundedRect;
//        [end setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
//        end.text = [self.formatter stringFromDate:[NSDate date]];
//        end.inputView = self.datePicker;
//        self.end = end;
//        end.delegate = self;
//        end.tag = 1;
//        end.inputAccessoryView = self.accessoryView;
//        [self addSubview:end];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = [UIColor redColor];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14    ];
        
        [cancle setTitle:@"取消" forState:UIControlStateNormal ];
        [cancle addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchUpInside];
        self.cancle = cancle;
        [self addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14    ];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitle:@"确定" forState:UIControlStateNormal ];
        [sure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
        self.sure = sure;
        
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [self addSubview:sure];
    }
    return self;
}
-(void)setName:(NSString *)name
{
    _name = name;
    self.lab.text = name;
    
}
-(void)clickCancle:(UIButton *)but
{
    [self endEditing:YES];
    [ZKRCover dismiss];
    if (_cancleBlock) {
        _cancleBlock();
    }
    [CurrImageView dismiss];
}
-(void)clickSure:(UIButton *)but
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.start.text = date;
    [self endEditing:YES];

    
    if (_popBlock) {
        _popBlock(self.start.text);
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.start.frame = CGRectMake(20+80, 20, 180, 40);
    self.lab.frame = CGRectMake(20, 20, 80, 40);
    //self.end.frame = CGRectMake(140+20, 20, 120, 40);
    self.cancle.frame = CGRectMake(self.frame.size.width-40*2-20*2, CGRectGetMaxY(self.start.frame)+20, 40, 25);
    self.sure.frame = CGRectMake(self.frame.size.width-40-20, CGRectGetMaxY(self.start.frame)+20, 40, 25);
}
@end
