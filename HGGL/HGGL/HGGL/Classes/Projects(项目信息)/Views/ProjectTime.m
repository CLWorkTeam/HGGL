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
#define magin 5
@interface ProjectTime()<UITextFieldDelegate>
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
@implementation ProjectTime
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
        
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        //cancle.backgroundColor = [UIColor redColor];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
        cancle.bounds = CGRectMake(0, 0, 60, 30);
        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:cancle];
        
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeRoundedRect   ];
        //sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        self.Y = sure;
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
//        UIButton *sea = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//        sea.backgroundColor = [UIColor redColor];
//        sea.titleLabel.font = [UIFont systemFontOfSize:14];
//        [sea setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        [sea setTitle:@"搜索" forState:UIControlStateNormal];
//        [sea addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
//        sea.bounds = CGRectMake(0, 0, 60, 30);
//        sea.center = CGPointMake(accessoryView.width/2, accessoryView.height/2);
//        [accessoryView addSubview:sea];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _accessoryView = accessoryView;
        
    }
    return _accessoryView;
}
//-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//{
//    if (textField == self.start) {
//        self.left = YES;
//    }else
//    {
//        self.left = NO;
//    }
//    return YES;
//}
-(void)cancleA
{
    [self endEditing:YES];
    self.start.text = @"";
    self.end.text = @"";
    if (_popBlock) {
        _popBlock(self.start.text,self.end.text);
    }
    [ZKRCover dismiss];
}
-(void)sureA
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.start.text = date;
    if (self.start.text.length||self.end.text.length) {
        if (_popBlock) {
            _popBlock (self.start.text,self.end.text);
        }
    }
    [self endEditing:YES];
}
-(void)sureB
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.end.text = date;
    if ([self.start.text isEqualToString:@""]&& [self.end.text isEqualToString:@""]) {

    }else
    {
        if (_popBlock) {
            _popBlock (self.start.text,self.end.text);
        }
    }
    [self endEditing:YES];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UITextField *start = [[UITextField alloc]init];
        start.borderStyle = UITextBorderStyleRoundedRect;
        [start setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        //start.text = [self.formatter stringFromDate:[NSDate date]];
        start.inputView = self.datePicker;
        start.inputAccessoryView = self.accessoryView;
        self.start = start;
        start.delegate = self;
        start.tag = 0;
        [self addSubview:start];
        UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor redColor]];
        lab.text = @"至";
        self.lab = lab;
        [self addSubview:lab];
        UITextField *end = [[UITextField alloc] init];
        end.borderStyle = UITextBorderStyleRoundedRect;
        [end setValue:[UIFont boldSystemFontOfSize:12] forKeyPath:@"_placeholderLabel.font"];
        //end.text = [self.formatter stringFromDate:[NSDate date]];
        end.inputView = self.datePicker;
        end.delegate = self;
        end.tag = 1;
        self.end = end;
        end.inputAccessoryView = self.accessoryView;
        [self addSubview:end];
//        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
//        cancle.backgroundColor = [UIColor redColor];
//        cancle.titleLabel.font = [UIFont systemFontOfSize:14    ];
//        [cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [cancle setTitle:@"取消" forState:UIControlStateNormal ];
//        [cancle addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchUpInside];
//        self.cancle = cancle;
//        [self addSubview:cancle];
//        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
//        sure.backgroundColor = [UIColor redColor];
//        sure.titleLabel.font = [UIFont systemFontOfSize:14    ];
//        [sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        [sure setTitle:@"确定" forState:UIControlStateNormal ];
//       [sure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
//        self.sure = sure;
//        [self addSubview:sure];
    }
    return self;
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
    //HGLog(@"bianji");
    return YES;
}
-(void)clickCancle:(UIButton *)but
{
    [self endEditing:YES];
    if (_cancleBlock) {
        _cancleBlock();
    }
    [ZKRCover dismiss];
    [CurrImageView dismiss];
}
-(void)clickSure:(UIButton *)but
{

    if (_popBlock) {
        _popBlock(self.start.text,self.end.text);
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //self.start.frame = CGRectMake(20, 5, 120, 40);
    self.lab.bounds = CGRectMake(0, 0, 20, 40);
    self.lab.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    self.start.frame = CGRectMake(self.lab.frame.origin.x-120-magin, magin, 120, 40);
    self.end.frame = CGRectMake(CGRectGetMaxX(self.lab.frame)+magin, magin, 120, 40);
//    self.cancle.frame = CGRectMake(self.frame.size.width-40*2-20*2, CGRectGetMaxY(self.start.frame)+20, 40, 25);
//    self.sure.frame = CGRectMake(self.frame.size.width-40-20, CGRectGetMaxY(self.start.frame)+20, 40, 25);
}
@end



