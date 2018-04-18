//
//  Report.m
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "Report.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#define margin 20
#define W 60
#define H 30
#define LW 150
@interface Report()<UITextFieldDelegate>
@property (nonatomic,weak) UILabel *tit;
@property (nonatomic,weak) UILabel *researchName;
@property (nonatomic,weak) UILabel *researchNameV;
@property (nonatomic,weak) UILabel *reportName;
@property (nonatomic,weak) UITextField *reportNameV;
@property (nonatomic,weak) UILabel *reportD;
@property (nonatomic,weak) UITextField *reportDV;
@property (nonatomic,strong) UIView *accessoryView;
@property (nonatomic,strong) NSDateFormatter *formatter;
@property (nonatomic,strong) UIDatePicker *datePicker;
@property (nonatomic,weak) UIButton *cancle;
@property (nonatomic,weak) UIButton *sure;

//申报日期
@property (nonatomic,copy)NSString *reportDate;
@end
@implementation Report
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
        //cancle.backgroundColor = [UIColor redColor];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
        cancle.bounds = CGRectMake(0, 0, 60, 30);
        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        //sure.backgroundColor = [UIColor redColor];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        _accessoryView = accessoryView;
    }
    return _accessoryView;
}
-(void)cancleA
{
    [self endEditing:YES];
    [ZKRCover dismiss];
}
-(void)sureA
{
    NSString *date = [self.formatter stringFromDate:self.datePicker.date];
    self.reportDV.text = date;
    [self endEditing:YES];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *tit = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        tit.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14];
        tit.text = @"申报";
        self.tit = tit;
        [self addSubview:tit];
        UILabel *researchName = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        researchName.text = @"课题名称";
        self.researchName = researchName;
        [self addSubview:researchName];
        UILabel *researchNameV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
        self.researchNameV = researchNameV;
        [self addSubview:researchNameV];
        UILabel *reportName = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        self.reportName = reportName;
        reportName.text = @"申报人";
        [self addSubview:reportName];
        UITextField *reportNameV = [[UITextField alloc]init];
        reportNameV.returnKeyType =UIReturnKeyDone;
        reportNameV.text = [HGUserDefaults stringForKey:@"userName"];
        reportNameV.delegate = self;
        reportNameV.borderStyle = UITextBorderStyleRoundedRect;
        [reportNameV setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        self.reportNameV = reportNameV;
        [self addSubview:reportNameV];
        UILabel *reportDate = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        self.reportD = reportDate;
        reportDate.text = @"申报日期";
        [self addSubview:reportDate];
        UITextField *reprotDV = [[UITextField alloc]init];
        reprotDV.borderStyle = UITextBorderStyleRoundedRect;
        [reprotDV setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
        reprotDV.text = [self.formatter stringFromDate:[NSDate date]];
        reprotDV.inputView = self.datePicker;
        reprotDV.inputAccessoryView = self.accessoryView;
        self.reportDV = reprotDV;
        [self addSubview:reprotDV];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        cancle.backgroundColor = [UIColor redColor];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14    ];
        //[cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancle setTitle:@"取消" forState:UIControlStateNormal ];
        [cancle addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchUpInside];
        self.cancle = cancle;
        [self addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14    ];
       // [sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sure setTitle:@"确定" forState:UIControlStateNormal ];
        [sure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
        self.sure = sure;
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
-(void)clickCancle:(UIButton *)but
{
    [self endEditing:YES];
    [ZKRCover dismiss];
    [CurrImageView dismiss];
    
}
-(void)clickSure:(UIButton *)but
{
    NSString *url = [HGURL stringByAppendingString:@"Research/doReport.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"research_id":self.research_id,@"name":self.reportNameV.text,@"reportDate":self.reportDV.text,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD  showSuccessWithStatus:[responseObject objectForKey:@"message"]];
            if (_sureBlock) {
                _sureBlock();
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    [self endEditing:YES];
    [ZKRCover dismiss];
    [CurrImageView dismiss];
}
-(void)setResearch_name:(NSString *)research_name
{
    _research_name = research_name;
    self.researchNameV.text = research_name;
}
//-(void)setName:(NSString *)name
//{
//    _name = name;
//    self.reportNameV.text = name;
//}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //取消成为第一响应者（取消的话 键盘就会消失）
    [textField resignFirstResponder];
    

    return YES;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tit.frame = CGRectMake(0, 0, self.frame.size.width, H);
    self.researchName.frame =  CGRectMake(margin, CGRectGetMaxY(self.tit.frame), W, H);
    self.researchNameV.frame = CGRectMake(CGRectGetMaxX(self.researchName.frame), CGRectGetMaxY(self.tit.frame),LW , H);
    self.reportName.frame = CGRectMake(margin, CGRectGetMaxY(self.researchName.frame), W, H);
    self.reportNameV.frame = CGRectMake(CGRectGetMaxX(self.reportName.frame), CGRectGetMaxY(self.researchName.frame), LW, H);
    self.reportD.frame = CGRectMake(margin, CGRectGetMaxY(self.reportName.frame), W, H);
    self.reportDV.frame = CGRectMake(CGRectGetMaxX(self.reportD.frame), CGRectGetMaxY(self.reportName.frame), LW, H);
    self.cancle.frame = CGRectMake(self.frame.size.width-40*2-20*2, CGRectGetMaxY(self.reportD.frame)+margin, 40, 25);
    self.sure.frame = CGRectMake(self.frame.size.width-40-20, CGRectGetMaxY(self.reportD.frame)+margin, 40, 25);
}
@end
