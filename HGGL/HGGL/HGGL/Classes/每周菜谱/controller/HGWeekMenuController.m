//
//  HGWeekMenuController.m
//  HGGL
//
//  Created by taikang on 2018/3/29.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWeekMenuController.h"

@interface HGWeekMenuController ()

@property (nonatomic,strong) NSMutableArray *weekAry;
@property (nonatomic,strong) NSMutableArray *dayAry;
@property (nonatomic,strong) NSMutableArray *weekBtnAry;


@property (nonatomic,strong) UIView *weekView;
@property (nonatomic,strong) anyButton *menuBtn;
@property (nonatomic,strong) UIView *dinnerView;//选择早、中、晚餐的弹窗view
@property (nonatomic,strong) NSArray *dinnerAry;





@end

@implementation HGWeekMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"每周菜谱";
    self.rightBtn.hidden = YES;
    self.weekAry = [NSMutableArray array];
    self.dayAry  = [NSMutableArray array];
    self.weekBtnAry = [NSMutableArray array];
    self.dinnerAry = @[@"早餐",@"午餐",@"晚餐"];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = @"MM.dd";
    for (int i =1; i<=7; i++) {
       NSDate *newDate = [date dateByAddingTimeInterval:24*60*60*i];
        NSString *dayStr = [dateFor stringFromDate:newDate];
        [self.weekAry addObject:[self weekdayStringFromDate:newDate]];
        [self.dayAry addObject:dayStr];
    }
    [self addWeekView];
    [self addMenuView];
    [self addNextButton];
}

-(UIView *)dinnerView{
    
    if (_dinnerView==nil) {
        
        UIView *backV = [[UIView alloc]initWithFrame:self.view.bounds];
        backV.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:backV];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [backV addGestureRecognizer:tapGes];
        
        UIView *listV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10), self.menuBtn.maxY, self.menuBtn.width, HEIGHT_PT(44)*3+HEIGHT_PT(2))];
        listV.backgroundColor = [UIColor clearColor];
        [backV addSubview:listV];
        
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_pop_middle"] forState:UIControlStateNormal];
            [btn setTitle:self.dinnerAry[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(18)];
            btn.frame = CGRectMake(0, i * (HEIGHT_PT(44)+HEIGHT_PT(1)), listV.width, HEIGHT_PT(44));
            [btn addTarget:self action:@selector(clickDetailDinner:) forControlEvents:UIControlEventTouchUpInside];
            [listV addSubview:btn];
        }
        
        _dinnerView = backV;
    }
    return _dinnerView;
}

- (void)addWeekView{
    
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, HEIGHT_PT(100))];
    weekView.backgroundColor = [UIColor whiteColor];
    self.weekView = weekView;
    [self.view addSubview:weekView];
    
    CGFloat x = WIDTH_PT(10);
    CGFloat y = HEIGHT_PT(10);
    CGFloat w = (HGScreenWidth-WIDTH_PT(20))/7;
    CGFloat h = w;
    
    for (int i =0; i<7; i++) {
        
        x = WIDTH_PT(10) + i *w;
        NSString *day = self.dayAry[i];
        NSString *week = self.weekAry[i];
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeTitleFrame:btn.bounds];
        btn.titleLabel.numberOfLines = 0;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = w/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(12)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSString *title = [NSString stringWithFormat:@"%@\n%@",week,day];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickDay:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [weekView addSubview:btn];
        
        if (i==0) {
            btn.selected = YES;
        }
        [self.weekBtnAry addObject:btn];
    }
    
    weekView.height = HEIGHT_PT(20) + h ;
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, weekView.maxY, HGScreenWidth, HEIGHT_PT(10))];
    lineV.backgroundColor = HGGrayColor;
    [self.view addSubview:lineV];
}

- (void)addMenuView{
    
    UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.weekView.maxY+HEIGHT_PT(10), HGScreenWidth, HEIGHT_PT(20))];
    alertLab.textColor = HGMainColor;
    alertLab.font = [UIFont systemFontOfSize:FONT_PT(13)];
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.text = @"注：需提前一天订餐";
    [alertLab sizeToFit];
    alertLab.centerX = self.view.centerX;
    alertLab.y = alertLab.y + HEIGHT_PT(5);
    [self.view addSubview:alertLab];
    
    anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDTH_PT(10), alertLab.maxY+HEIGHT_PT(5), HGScreenWidth-WIDTH_PT(20), HEIGHT_PT(40));
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitle:@"早餐" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setImage:[UIImage imageNamed:@"icon_btn_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_btn_up"] forState:UIControlStateSelected];
    [btn changeTitleFrame:CGRectMake(0, 0, btn.width*0.9, btn.height)];
    [btn changeImageFrame:CGRectMake(btn.width-WIDTH_PT(20), (btn.height-HEIGHT_PT(8))/2, WIDTH_PT(13), HEIGHT_PT(8))];
    [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = btn;
    [self.view addSubview:btn];
}

- (void)addNextButton{
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0,HGScreenHeight-HEIGHT_PT(50), HGScreenWidth ,HEIGHT_PT(50));
    [nextBtn setTitle:@"订餐" forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(18)]];
    [nextBtn addTarget:self action:@selector(bookDinner:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nextBtn];
    
}


- (void)clickDay:(UIButton *)sender{

    sender.selected = !sender.isSelected;
    for (UIButton *btn in self.weekBtnAry) {
        if (btn==sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
}

- (void)clickMenu:(anyButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [self.view addSubview:self.dinnerView];
    }else{
        if (self.dinnerView.superview) {
            [self.dinnerView removeFromSuperview];
        }
    }
}

- (void)tapView{
    
    if (self.dinnerView.superview) {
        [self.dinnerView removeFromSuperview];
        self.menuBtn.selected = NO;
    }
}

- (void)clickDetailDinner:(UIButton *)sender{
    
    [self.menuBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    
    if (self.dinnerView.superview) {
        [self.dinnerView removeFromSuperview];
        self.menuBtn.selected = NO;
    }

}

#pragma mark -订餐
- (void)bookDinner:(UIButton *)sender{
    
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
