//
//  HGRSHeader.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRSHeader.h"
#import "HGRSParama.h"
#import "TeachToolBar.h"
#import "HGLable.h"
#import "TextFrame.h"
#import "HGHttpTool.h"
#import "HGPopView.h"
#import "HcdDateTimePickerView.h"
#define bothMargin 10

@interface HGRSHeader ()
@property (nonatomic,weak) TeachToolBar *toolBar;
@property (nonatomic,weak) UIView *grayView;
@property (nonatomic,strong) NSMutableArray *carArray;
@property (nonatomic,strong) NSMutableArray *classArray;
@property (nonatomic,weak) UILabel *carLable;
@property (nonatomic,weak) UIButton *carBut;
@property (nonatomic,weak) UILabel *dateLable;
@property (nonatomic,weak) UIButton *dateButton;
@property (nonatomic,weak) UIButton *classButton;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end
@implementation HGRSHeader
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(NSMutableArray *)carArray
{
    if (_carArray == nil) {
        _carArray = [NSMutableArray arrayWithObject:@{@"carName":@"全部",@"carId":@""}];
    }
    return  _carArray;
}
-(NSMutableArray *)classArray
{
    if (_classArray == nil) {
        _classArray = [NSMutableArray arrayWithObject:@{@"project_id":@"",@"project_serial_num":@"",@"project_name":@"全部",@"project_start":@"",@"project_end":@"",@"running_status":@"",@"project_contact":@"",@"contact_phone":@"",@"course_hour":@""}];
    }
    return _classArray;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        TeachToolBar *toolBar = [[TeachToolBar alloc]init];
        WeakSelf
        toolBar.clickChange = ^(NSInteger page) {
            
            if (page) {
                weakSelf.parama.fillType = @"1";
                
            }else
            {
                weakSelf.parama.fillType = @"2";
            }
            if (weakSelf.clickBlock) {
                
                weakSelf.clickBlock(weakSelf.parama);
                
            }
            
        };
        toolBar.arr = [NSArray arrayWithObjects:@"接站",@"送站", nil];
        self.toolBar = toolBar;
        [self addSubview:toolBar];
        
        UIView *grayView = [[UIView alloc]init];
        grayView.backgroundColor = HGGrayColor;
        self.grayView = grayView;
        [self addSubview:grayView];
        
        UILabel *carLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:12 Color:[UIColor blackColor]];
        carLable.text = @"车辆：";
        [self addSubview:carLable];
        self.carLable = carLable;
        
        UIButton *carBut = [self creatButtonWithTitle:@"全部"];
        carBut.tag = 201;
        [self addSubview:carBut];
        self.carBut = carBut;
        
        UILabel *dateLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:12 Color:[UIColor blackColor]];
        dateLable.text = @"日期：";
        [self addSubview:dateLable];
        self.dateLable = dateLable;
        
        NSString *currentDate = [self.formatter stringFromDate:[NSDate date]];
        UIButton *dateButton = [self creatButtonWithTitle:currentDate];
        dateButton.tag = 202;
        [self addSubview:dateButton];
        self.dateButton  = dateButton ;
        
        UIButton *classBut = [self creatButtonWithTitle:@"全部"];
        classBut.tag = 203;
        [self addSubview:classBut];
        self.classButton = classBut ;
        
        
        
        
        
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
-(void)clickBut:(UIButton *)button
{
    switch (button.tag-200) {
        case 1:
        {
            [self getCar];
        }
            break;
        case 2:
        {
            [self showTimeView];
        }
            break;
        case 3:
        {
            [self getClass];
        }
            break;
            
        default:
            break;
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.toolBar.frame = CGRectMake(0, 0, self.width, 43);
    
    CGFloat Hmargin = 6.5;
    
    CGFloat buttonH = 30;
    
    self.grayView.frame = CGRectMake(0, self.toolBar.maxY, self.width, 8);
    
    CGFloat lableW = [TextFrame frameOfText:self.carLable.text With:self.carLable.font AndHeigh:1000].width;
    
    self.carLable.frame = CGRectMake(bothMargin , self.grayView.maxY+Hmargin , lableW, buttonH);
    
    self.carBut.frame = CGRectMake(self.carLable.maxX,self.carLable.y , self.width/2-bothMargin/2 -self.carLable.maxX , buttonH);
    
    self.dateLable.frame = CGRectMake(self.carBut.maxX+bothMargin, self.carLable.y, lableW, buttonH);
    
    self.dateButton.frame = CGRectMake(self.dateLable.maxX, self.carLable.y,self.width/2-bothMargin/2-self.carLable.maxX , buttonH);
    
    self.classButton.frame = CGRectMake(self.carLable.x,self.carBut.maxY+Hmargin , self.width-2*bothMargin, buttonH);
    
    
}
-(void)getCar
{
    if (_carArray) {
        [self showCar];
        return;
    }
    NSString *url = [HGURL stringByAppendingString:@"Reception/getCar.do"];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [HGHttpTool POSTWithURL:url parameters:@{} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            self.carArray = nil;
            [self.carArray addObjectsFromArray:array];
            [self showCar];
        }
            
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}
-(void)showCar
{
    UIButton *button = self.carBut;
    CGRect r = [self convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*((self.carArray.count<5)?self.carArray.count:5));
    
    [HGPopView setPopViewWith:rect And:self.carArray andShowKey:@"carName"  selectBlock:^(NSDictionary *dict) {
        
        NSString *str = dict[@"carName"];
        
        
        
        [button setTitle:str forState:UIControlStateNormal];
        
        if ([str isEqualToString:@"全部"]) {
            str = @"";
        }
        self.parama.carInfo = str;
        if (_clickBlock) {
            _clickBlock(self.parama);
        }
        
    }];
}
-(void)getClass
{
    if (_classArray) {
        [self showClass];
        return;
    }
    
    NSString *url = [HGURL stringByAppendingString:@"Project/getSomeCourse.do"];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [HGHttpTool POSTWithURL:url parameters:@{} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            self.classArray = nil;
            [self.classArray addObjectsFromArray:array];
            [self showClass];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}
-(void)showClass
{
    UIButton *button = self.classButton;
    CGRect r = [self convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*((self.classArray.count<5)?self.classArray.count:5));
    
    [HGPopView setPopViewWith:rect  And:self.classArray andShowKey:@"project_name"  selectBlock:^(NSDictionary *dict) {
        
        [button setTitle:dict[@"project_name"] forState:UIControlStateNormal];
        
        self.parama.classId = dict[@"project_id"];
        if (_clickBlock) {
            _clickBlock(self.parama);
        }
        
    }];
}
-(void)showTimeView
{
    HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        
        NSDate *date = [self.formatter dateFromString:datetimeStr];
        [self.dateButton setTitle:[self.formatter stringFromDate:date] forState:UIControlStateNormal];
        self.parama.date = [self.formatter stringFromDate:date];
        
        
        if (_clickBlock) {
            _clickBlock(self.parama);
        }
    };
    [HGKeywindow addSubview:dateTimePickerView];
    [dateTimePickerView showHcdDateTimePicker];
}
@end
