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
}

- (void)addWeekView{
    
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, 100)];
    weekView.backgroundColor = [UIColor whiteColor];
    self.weekView = weekView;
    [self.view addSubview:weekView];
    
    CGFloat x = 10;
    CGFloat y = 10;
    CGFloat w = (HGScreenWidth-20)/7;
    CGFloat h = w;
    
    for (int i =0; i<7; i++) {
        
        x = 10 + i *w;
        NSString *day = self.dayAry[i];
        NSString *week = self.weekAry[i];
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeTitleFrame:btn.bounds];
        btn.titleLabel.numberOfLines = 0;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = w/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSString *title = [NSString stringWithFormat:@"%@\n%@",week,day];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [weekView addSubview:btn];
        
        if (i==0) {
            btn.selected = YES;
        }
        [self.weekBtnAry addObject:btn];
    }
    
    weekView.height = 20 + h ;
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, weekView.maxY, HGScreenWidth, 10)];
    lineV.backgroundColor = HGGrayColor;
    [self.view addSubview:lineV];
}

- (void)addMenuView{
    
    
}

- (void)clickMenu:(UIButton *)sender{

    sender.selected = !sender.isSelected;
    for (UIButton *btn in self.weekBtnAry) {
        if (btn==sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
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
