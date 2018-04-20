//
//  HGClassRHeader.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassRHeader.h"
//#import "PopTableViewController.h"
#import "HGPopView.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HGCRParama.h"
@interface HGClassRHeader ()
@property (nonatomic,strong) NSMutableArray *buttonArray;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,strong) NSDateFormatter *formatter;
@property (nonatomic,strong) UIView *accessoryView;
@property (nonatomic,weak) UIButton *cancle;
@property (nonatomic,weak) UIButton *sure;
@property (nonatomic,assign) BOOL left;
@property (nonatomic,strong) UIButton *Y;
@end
@implementation HGClassRHeader
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
-(NSMutableArray *)buttonArray
{
    if (_buttonArray == nil) {
        _buttonArray = [NSMutableArray array];
    }
    return  _buttonArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        NSArray *arr = @[@"项目类型",@"开始时间",@"结束时间",@"恢复默认"];
        for (int i = 0; i<arr.count; i++) {
            
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [button setTitle:arr[i] forState:UIControlStateNormal];
            
            
            
            button.titleLabel.font = ZKRButFont;
            
            button.tag = 200+i;
            
            [button  addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i<arr.count-1) {
                button.layer.masksToBounds = YES;
                button.layer.cornerRadius = 5;
                button.layer.borderColor = HGMainColor.CGColor;
                button.layer.borderWidth = 0.5;
                [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
                
            }else
            {
                [button setTitleColor:HGMainColor forState:UIControlStateNormal];
            }
            
            [self.buttonArray addObject:button];
            [self addSubview:button];
        }
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Wmarg = 8;
    CGFloat HMarg = 5;
    CGFloat buttonH = 30;
    CGFloat lastW = [TextFrame frameOfText:@"恢复默认" With:ZKRButFont AndHeigh:1100].width ;
    CGFloat W = (self.width-5*Wmarg-lastW)/3;
    for (NSInteger i = 0; i<self.buttonArray.count; i++) {
        UIButton *but = (UIButton *)self.buttonArray[i];
        if (i<self.buttonArray.count-1) {
            but.frame = CGRectMake(Wmarg+i*(Wmarg+W), HMarg, W, buttonH);
        
        }else
        {
            CGFloat H = [TextFrame frameOfText:@"恢复默认" With:ZKRButFont Andwidth:1000].height;
            but.frame = CGRectMake(self.width-lastW-Wmarg, self.height-H-HMarg, lastW, H);
        }
        if ((i == 1 )||(i == 2)) {
//             = self.accessoryView;
        }
    }
}
-(void)clickButton:(UIButton *)button
{
    NSInteger tag = button.tag-200;
    
    switch (tag) {
        case 0:
            {
                [self showPopView:button];
            }
            break;
        case 1:
        {
            [self showTimeView:YES];
        }
            break;
        case 2:
        {
            [self showTimeView:NO];
        }
            break;
        case 3:
        {
            self.parama.page = @"1";
            self.parama.pageSize = @"10";
            self.parama.startTime = @"";
            self.parama.endTime = @"";
            self.parama.type = @"";
            if (_clickBlock) {
                _clickBlock(self.parama);
            }
        }
            break;
            
        default:
            break;
    }
    
}
-(void)showPopView:(UIButton *)but
{
    UIButton *button = self.buttonArray[0];
    CGRect r = [self convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*4);
    
    HGPopView *pop = [HGPopView setPopViewWith:rect And:[NSArray arrayWithObjects:@"全部",@"调训",@"委托",@"集中工作", nil] selectBlock:^(NSString *str) {
        
        [but setTitle:str forState:UIControlStateNormal];
        
        if ([str isEqual:@"全部"]) {
            self.parama.type = @"";
        }else if ([str isEqual:@"调训"])
        {
            self.parama.type = @"1";
        }else if([str isEqual:@"委托"])
        {
            self.parama.type = @"2";
        }else if ([str isEqual:@"集中工作"])
        {
            self.parama.type = @"3";
        }
        if (_clickBlock) {
            _clickBlock(self.parama);
        }
        
    }];
    
    
}
-(void)showTimeView:(BOOL)isStart
{
    UIButton *but = (UIButton *)self.buttonArray[2];
    [but becomeFirstResponder];
    if (isStart) {
        
        [self.Y removeTarget:self action:@selector(sureB) forControlEvents:UIControlEventTouchUpInside];
        [self.Y addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
    }else
    {
        [self.Y removeTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        [self.Y addTarget:self action:@selector(sureB) forControlEvents:UIControlEventTouchUpInside];
    }
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
    UIButton *but = (UIButton *)self.buttonArray[1];
    [but setTitle:date forState:UIControlStateNormal];
    self.parama.startTime = date;
    [self endEditing:YES];
    if (_clickBlock) {
        _clickBlock(self.parama);
    }
}
-(void)sureB
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    UIButton *but = (UIButton *)self.buttonArray[2];
    [but setTitle:date forState:UIControlStateNormal];
    self.parama.endTime = date;
    [self endEditing:YES];
    if (_clickBlock) {
        _clickBlock(self.parama);
    }
}
@end
