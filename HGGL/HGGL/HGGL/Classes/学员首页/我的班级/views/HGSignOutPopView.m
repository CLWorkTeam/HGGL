//
//  HGSignOutPopView.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/6.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSignOutPopView.h"
#import "ZKRCover.h"
#import "ImageRightBut.h"
#import "HGLable.h"
#import "HGPopView.h"
#import "TimerTransform.h"
#import "HGHttpTool.h"
@interface HGSignOutPopView ()
@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UILabel *timeLable;
@property (nonatomic,weak) UILabel *typeLable;
@property (nonatomic,weak) UIButton *timeButton;
@property (nonatomic,weak) UIButton *typeButton;
@property (nonatomic,weak) UIButton *sureButton;
@property (nonatomic,weak) UIButton *cancleButton;
@property (nonatomic,strong) NSMutableArray *weekArray;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end
@implementation HGSignOutPopView
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(NSMutableArray *)weekArray
{
    if (_weekArray == nil) {
        _weekArray = [NSMutableArray array];
    }
    return _weekArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = HGColor(0, 0, 0, 0.3);
        
        
        UIView *contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor whiteColor];
        [self addSubview:contentView];
        self.contentView  = contentView;
        
        UILabel *titleLable = [HGLable  lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:HGColor(0, 209, 255, 1)];
        [self.contentView addSubview:titleLable];
        titleLable.text = @"请选择签退信息";
        self.titleLable = titleLable;;
        
        UILabel *timeLable = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        [self.contentView addSubview:timeLable];
        timeLable.text = @"时间：";
        self.timeLable = timeLable;;
        
        UIButton *timeButton = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
        [timeButton setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
        [timeButton setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
        [timeButton setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
        [timeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        timeButton.titleLabel.font = ZKRButFont;
        timeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        timeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [timeButton setTitle:[self getRightTime] forState:UIControlStateNormal];
        [timeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:timeButton];
        self.timeButton = timeButton;
        timeButton.tag = 400;
        
        UILabel *typeLable = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        [self.contentView addSubview:typeLable];
        typeLable.text = @"类型：";
        self.typeLable = typeLable;;
        
        
        UIButton *typeButton = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
        [typeButton setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
        [typeButton setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
        [typeButton setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
        [typeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        typeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        typeButton.titleLabel.font = ZKRButFont;
        typeButton.titleLabel.textAlignment = NSTextAlignmentLeft;
        [typeButton setTitle:@"全部" forState:UIControlStateNormal];
        [typeButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:typeButton];
        self.typeButton = typeButton;
        typeButton.tag = 401;
        
        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.backgroundColor = HGColor(0, 209, 255, 1);
        sureButton.titleLabel.font = ZKRButFont;
        [sureButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sureButton setTitle:@"确定" forState:UIControlStateNormal];
        sureButton.tag = 402;
        [sureButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:sureButton];
        self.sureButton = sureButton ;
        
        UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancleButton.backgroundColor = HGColor(0, 209, 255, 1);
        cancleButton.titleLabel.font = ZKRButFont;
        [cancleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancleButton setTitle:@"取消" forState:UIControlStateNormal];
        cancleButton.tag = 403;
        [cancleButton addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:cancleButton];
        self.cancleButton = cancleButton ;
        
        
        [self getRightTime];
        
        
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat H = 30;
    CGFloat Hmar = 8;
    CGFloat Wmar = 15;
    
    self.contentView.bounds = CGRectMake(0, 0, 260, 5*30+8*3+15);
    self.contentView.center = CGPointMake(self.width/2, self.height/2);
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.cornerRadius = 5;
    self.titleLable.frame = CGRectMake(0, Hmar, self.contentView.width, H);
    [self.timeLable sizeToFit];
    self.timeLable.frame = CGRectMake(Wmar, self.titleLable.maxY+Hmar, self.timeLable.width, H);
    self.timeButton.frame = CGRectMake(self.timeLable.maxX, self.timeLable.y, self.contentView.width-2*Wmar-self.timeLable.width, H);
    self.typeLable.frame = CGRectMake(self.timeLable.x, self.timeLable.maxY+Hmar, self.timeLable.width, H);
    self.typeButton.frame = CGRectMake(self.typeLable.maxX, self.typeLable.y, self.contentView.width-2*Wmar-self.typeLable.width, H);
    self.sureButton.frame = CGRectMake(Wmar, self.typeButton.maxY+H, (self.contentView.width-3*Wmar)/2, H);
    self.cancleButton.frame = CGRectMake(self.sureButton.maxX+Wmar, self.sureButton.y, self.sureButton.width, H);
    self.sureButton.layer.masksToBounds = YES;
    self.sureButton.layer.cornerRadius = 5;
    self.cancleButton.layer.masksToBounds = YES;
    self.cancleButton.layer.cornerRadius = 5;
    
    
}
-(void)clickButton:(UIButton *)button
{
    button.selected = !button.selected;
    NSInteger tag = button.tag - 400;
    switch (tag) {
        case 0:
        {
            [self showWeek];
        }
            break;
        case 1:
        {
            [self showMeal];
        }
            break;
        case 2:
        {
            [self request];
        }
            break;
        case 3:
        {
            [HGSignOutPopView disMiss];
        }
            break;
            
        default:
            break;
    }
    
}
-(void)request
{
    NSString *str = [self.typeButton titleForState:UIControlStateNormal];
    NSString *type = @"";
    NSString *time = @"";
    if ([str isEqual:@"全部"]) {
        type = @"0";
    }else if ([str isEqual:@"早餐"])
    {
        type = @"1";
    }else if([str isEqual:@"午餐"])
    {
        type = @"2";
    }else if ([str isEqual:@"晚餐"])
    {
        type = @"3";
    }
    
    NSString *str1 = [self.timeButton titleForState:UIControlStateNormal];
    time = [str1 componentsSeparatedByString:@"/"].lastObject;
    
    NSString *url = [HGURL stringByAppendingString:@"Banner/stuSignOut.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"time":time,@"user_id":[HGUserDefaults objectForKey:HGUserID],@"type":type} success:^(id responseObject) {
        //        NSString *status = ;
        if ([[responseObject objectForKey:@"status"] integerValue] == 1 ) {
            [SVProgressHUD showSuccessWithStatus:@"签退成功"];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
        [HGSignOutPopView disMiss];
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    
}
-(void)showWeek
{
    
    CGRect rect = CGRectMake(HGScreenWidth/2-150/2, HGScreenHeight/2-(self.weekArray.count*44)/2, 150, self.weekArray.count*44);
    
    [HGPopView setPopViewWith:rect And:self.weekArray andShowKey:nil  selectBlock:^(NSString *str) {
        self.timeButton.selected = NO;
        if (![str isEqualToString:@""]) {
            [self.timeButton setTitle:str forState:UIControlStateNormal];
        }
        
        
        
    }];
    
}
-(void)showMeal
{
    NSArray *arr = @[@"全部",@"早餐",@"午餐",@"晚餐"];
    
    CGRect rect = CGRectMake(HGScreenWidth/2-100/2, HGScreenHeight/2-(arr.count*44)/2, 100, arr.count*44);
    
    [HGPopView setPopViewWith:rect And:arr andShowKey:nil  selectBlock:^(NSString *str) {
        self.typeButton.selected = NO;
        if (![str isEqualToString:@""]) {
            [self.typeButton setTitle:str forState:UIControlStateNormal];
        }
        
        
        
    }];
}

-(void)getWeekArray
{
    if (self.weekArray.count) {
        return;
    }
    
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
    NSString *currentDate = [fomatter stringFromDate:nextDate];
    
    NSArray *arr = [TimerTransform AllDayOfThisWeek:currentDate];
    NSString *day;
    NSString *dayDate;
    for (NSInteger i = 0; i<arr.count; i++) {
        NSDictionary *dict = arr[i];
        
        if ([dict[@"weekday"] isEqualToString:@"1"]) {
            
            day = @"周一";
            
        }else if ([dict[@"weekday"] isEqualToString:@"2"])
        {
            day = @"周二";
        }else if ([dict[@"weekday"] isEqualToString:@"3"])
        {
            day = @"周三";
        }else if ([dict[@"weekday"] isEqualToString:@"4"])
        {
            day = @"周四";
        }else if ([dict[@"weekday"] isEqualToString:@"5"])
        {
            day = @"周五";
        }else if ([dict[@"weekday"] isEqualToString:@"6"])
        {
            day = @"周六";
        }else if ([dict[@"weekday"] isEqualToString:@"7"])
        {
            day = @"周日";
        }
        dayDate = [self.formatter stringFromDate:[fomatter dateFromString:dict[@"date"]]];
        [self.weekArray addObject:[NSString stringWithFormat:@"%@/%@",day,dayDate]];
    }
    
    
}

-(NSString *)getRightTime
{
    [self getWeekArray];
    NSDate *nextDate = [NSDate dateWithTimeInterval:24*60*60 sinceDate:[NSDate date]];
    NSString *datestr = [self.formatter stringFromDate:nextDate];
    NSString *string = @"";
    for (NSString *str in self.weekArray) {
        if ([str containsString:datestr]) {
            string = str;
            break;
        }
    }
    return string;
}


+(instancetype)show
{
    
    HGSignOutPopView *popView = [[HGSignOutPopView alloc]init];
    popView.frame = HGKeywindow.bounds;
    [HGKeywindow addSubview:popView];
    return popView;
}
+(void)disMiss
{
    
    for (UIView *view in HGKeywindow.subviews) {
        if ([view isKindOfClass:self]) {
            [view removeFromSuperview];
        }
    }
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    CGPoint point = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(self.contentView.frame, point)) {
        [HGSignOutPopView disMiss];
    }
    
}
@end
