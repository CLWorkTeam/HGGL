//
//  TKBDPickerView.m
//  泰行销
//
//  Created by usee on 2017/12/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKBDPickerView.h"
#import "NSDate+Additions.h"
@interface TKBDPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
//布局相关
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UIButton *button;
@property (nonatomic,weak) UIPickerView *picker;

//时间相关
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDateFormatter *formatter;
@property (nonatomic,strong) NSDateFormatter *fomatter1;
@property (nonatomic,strong) NSMutableArray *dayArray;

//算法相关
@property (nonatomic,assign) NSInteger thisYear;//起始年
@property (nonatomic,assign) NSInteger thisMonth;//起始月
@property (nonatomic,assign) NSInteger thisDay;//起始日
@property (nonatomic,assign) NSInteger endYear;//终止年
@property (nonatomic,assign) NSInteger endMonth;//终止月
@property (nonatomic,assign) NSInteger endDay;//终止日
@property (nonatomic,assign) NSInteger fristRow;
@property (nonatomic,assign) NSInteger secondRow;
@property (nonatomic,assign) NSInteger thirdRow;
@property (nonatomic,assign) NSInteger monthCount;

//判断所有属性是不是都已经设置完成
@property (nonatomic,assign) NSInteger propetyCount;
@end
@implementation TKBDPickerView

-(NSCalendar *)calendar
{
    if (_calendar == nil) {
        _calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    }
    return _calendar;
}
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"YYYY年MM月dd日"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(NSDateFormatter *)fomatter1
{
    if (_fomatter1 == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"YYYY-MM-dd"];
        _fomatter1 = fomatter;
    }
    return _fomatter1;
}
-(NSMutableArray *)dayArray
{
    if (_dayArray == nil) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.propetyCount = 0;
        self.backgroundColor = [UIColor whiteColor];
        
        UIPickerView *pickView = [[UIPickerView alloc]init];
        pickView.dataSource = self;
        pickView.delegate = self;
        pickView.backgroundColor = [UIColor whiteColor];
        [self addSubview:pickView];
        self.picker = pickView;
    }
    return self;
}
-(void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
    self.propetyCount += 1;
    if (self.propetyCount == 3) {
        [self setData];
        
    }
    
}
-(void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    self.propetyCount += 1;
    if (self.propetyCount == 3) {
        [self setData];
        
    }
}
-(void)setIsOrder:(int)isOrder
{
    _isOrder = isOrder;
    self.propetyCount += 1;
    if (self.propetyCount == 3) {
        [self setData];
        
    }
}
-(void)setData
{
    NSArray *arr = [self.startTime componentsSeparatedByString:@"-"];
    
    NSArray *endArr = [self.endTime componentsSeparatedByString:@"-"];
    
    self.thisYear = [arr.firstObject integerValue];
    
    self.thisMonth = [arr[1] integerValue];
    
    self.thisDay = [arr.lastObject integerValue];
    
    self.endYear = [endArr.firstObject integerValue];
    
    self.endMonth = [endArr[1] integerValue];
    
    self.endDay = [endArr.lastObject integerValue];
    
    if (self.isOrder) {
        self.fristRow = 0;
        self.secondRow = 0;
        self.thirdRow = 0;
        self.monthCount = 12 - self.thisMonth +1;
        [self setDaysWith:[self.fomatter1 dateFromString:self.startTime]];
    }else{
        self.fristRow = self.endYear - self.thisYear;
        
        self.secondRow = self.endMonth - 1;
        
        self.thirdRow = self.endDay - 1;
        
        self.monthCount = self.endMonth ;
        
        [self setDaysWith:[self.fomatter1 dateFromString:self.endTime]];
        
    }
    
    [self.picker reloadAllComponents];
    
    [self.picker selectRow:self.fristRow inComponent:0 animated:NO];
    [self.picker selectRow:self.secondRow inComponent:1 animated:NO];
    if (self.Components>2) {
        [self.picker selectRow:self.thirdRow inComponent:2 animated:NO];
    }
    
}

// 返回多少列
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return self.Components;
    
}
// 返回多少行
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return  self.endYear - self.thisYear +1;
        
    }else if (component == 1)
    {
        return self.monthCount;
    }else
    {
        return self.dayArray.count;
    }
}
- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
    return HGScreenWidth/self.Components;
}
//每行高度
- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        if (self.fristRow == row) {
            return;
        }
        self.fristRow = row;
        self.secondRow = 0;
        self.thirdRow = 0;
        [self.dayArray removeAllObjects];
        
        
        NSString *year = [self pickerView:pickerView attributedTitleForRow:row forComponent:0].string;
        NSArray *arr = [year componentsSeparatedByString:@"年"];
        NSString *month = @"1月";
        if (self.thisYear == [arr.firstObject integerValue]) {
            month = [NSString stringWithFormat:@"%zd月",self.thisMonth];
            
            
            self.monthCount =12- self.thisMonth +1;
            
            
            
            
        }else if (self.endYear == [arr.firstObject integerValue])
        {
            
            self.monthCount = self.endMonth;
            
            
        }else
        {
            self.monthCount = 12;
        }
        
        [self setDaysWith:[self.formatter dateFromString:[[year stringByAppendingString:month] stringByAppendingString:@"2日"] ]];
        
        [pickerView reloadComponent:0];
        [pickerView selectRow:self.fristRow inComponent:0 animated:NO];
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:NO];
        if (self.Components>2) {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
        
    }else if (component == 1) {
        if (self.secondRow == row) {
            return;
        }
        [self.dayArray removeAllObjects];
        self.secondRow = row;
        self.thirdRow = 0;
        NSString *year = [self pickerView:pickerView attributedTitleForRow:[self.picker selectedRowInComponent:0] forComponent:0].string;
        NSString *month = [self pickerView:pickerView attributedTitleForRow:row forComponent:component].string;
        [self setDaysWith:[self.formatter dateFromString:[[year stringByAppendingString:month] stringByAppendingString:@"2日"] ]];
        [pickerView reloadComponent:1];
        [pickerView selectRow:self.secondRow inComponent:1 animated:NO];
        if (self.Components>2) {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:NO];
        }
        
        
    }else{
        if (self.thirdRow == row) {
            return;
        }
        self.thirdRow = row;
        [pickerView reloadComponent:2];
        [pickerView selectRow:self.thirdRow inComponent:2 animated:NO];
    }
    
    [self sure];
    
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(nullable UIView *)view
{
    
    UILabel *pickerLabel = (UILabel*)view;
    if (!pickerLabel) {
        pickerLabel = [[UILabel alloc]init];
        //    label.tintColor
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setFont:[UIFont systemFontOfSize:14]];
        pickerLabel.textColor = [UIColor colorWithHexString:@"#666666"];
    }
    if (component == 0) {
        if (row == self.fristRow) {
            pickerLabel.attributedText = [self pickerView:pickerView attributedTitleForRow:self.fristRow forComponent:component];
        }else
        {
            pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
        
    }else if (component == 1)
    {
        if (row == self.secondRow) {
            pickerLabel.attributedText = [self pickerView:pickerView attributedTitleForRow:self.secondRow forComponent:component];
        }else
        {
            pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
    }else
    {
        if (row == self.thirdRow) {
            pickerLabel.attributedText = [self pickerView:pickerView attributedTitleForRow:self.thirdRow forComponent:component];
        }else
        {
            pickerLabel.text = [self pickerView:pickerView titleForRow:row forComponent:component];
        }
    }
    
    return pickerLabel;
    
}
- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component{
    NSString *str;
    if (component == 0) {
        
        str = [NSString stringWithFormat:@"%zd年",self.thisYear+row];
        
        
    }else if (component == 1)
    {
        NSString *year = [self pickerView:pickerView attributedTitleForRow:[self.picker selectedRowInComponent:0] forComponent:0].string;
        NSArray *arr1 = [year componentsSeparatedByString:@"年"];
        if (self.thisYear == [arr1.firstObject integerValue]) {
            
            str = [NSString stringWithFormat:@"%zd月",self.thisMonth+row];
            
            
        }else
        {
            str = [NSString stringWithFormat:@"%zd月",row+1];
        }
        
    }else if (component == 2)
    {
        str = self.dayArray[row];
    }
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:str];
    
    NSRange range = [str rangeOfString:str];
    
    [attributedString addAttribute:NSForegroundColorAttributeName value:HGMainColor range:range];
    return attributedString;
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if (component == 0) {
        NSString *str;
        
        str = [NSString stringWithFormat:@"%zd年",self.thisYear+row];
        
        return str;
    }else if (component == 1)
    {
        NSString *str;
        NSString *year = [self pickerView:pickerView attributedTitleForRow:[self.picker selectedRowInComponent:0] forComponent:0].string;
        NSArray *arr1 = [year componentsSeparatedByString:@"年"];
        if (self.thisYear == [arr1.firstObject integerValue]) {
            
            str = [NSString stringWithFormat:@"%zd月",self.thisMonth+row];
            
            
        }else
        {
            str = [NSString stringWithFormat:@"%zd月",row+1];
        }
        return  str;
    }else
    {
        return self.dayArray[row];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.picker.frame = CGRectMake(0, 0, self.width, self.height);
}


//获取该时间所在月份总共有多少天并设置日的数组
-(void)setDaysWith:(NSDate *)date
{
    NSInteger num;
    NSInteger startDya;
    [self.dayArray removeAllObjects];
    BOOL isThisday = [self isSameDay:date date2:[self.fomatter1 dateFromString:self.startTime]];
    
    BOOL isEndDay = [self isSameDay:date date2:[self.fomatter1 dateFromString:self.endTime]];
        
    if (isThisday&&(!isEndDay)) {
        num = [self getNumOfDayOfMonth:date];
        
        startDya = self.thisDay;
        
    }else if ((!isThisday)&&isEndDay)
    {
        num = self.endDay;
        
        startDya = 1;
        
    }else
    {
        startDya =  1;
        num = [self getNumOfDayOfMonth:date];
    }
    
    
    for (NSInteger i = startDya;i<=num ; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%zd日",i]];
    }
}
- (void)setCurrentTime:(NSString *)currentTime{
    _currentTime = currentTime;
    NSArray *arr1 = [currentTime componentsSeparatedByString:@"-"];
    NSInteger currentYear = [arr1[0] integerValue];
    NSInteger currentMonth = [arr1[1] integerValue];
    NSInteger currentDay = [arr1[2] integerValue];
//    UIPickerView
    self.fristRow = currentYear - self.thisYear;
    self.secondRow = currentMonth - 1;
    self.thirdRow = currentDay - 1;
    NSString *year = arr1.firstObject;
//    NSArray *arr = [year componentsSeparatedByString:@"年"];
    NSString *month = @"1月";
    if (self.thisYear == [year integerValue]) {
        month = [NSString stringWithFormat:@"%zd月",self.thisMonth];
        
        self.monthCount =12- self.thisMonth +1;
        
        self.secondRow = currentMonth-self.thisMonth;
        
        
        
        if (currentMonth == self.thisMonth) {
            
            self.thirdRow = currentDay-self.thisDay;
            
        }else
        {
            self.thirdRow = currentDay - 1;
        }
        
        
        
        
    }else if (self.endYear == [year integerValue])
    {
        
        self.monthCount = self.endMonth;
        
        
        
        
    }else
    {
        self.monthCount = 12;
    }
    
    
    [self setDaysWith:[self.formatter dateFromString:[[[year stringByAppendingString:@"年"] stringByAppendingString:month] stringByAppendingString:@"2日"]]];
    
    [self setDaysWith:[NSDate dateFromString:currentTime withFormat:@"yyyy-MM-dd"]];
    [self.picker reloadAllComponents];
    [self.picker selectRow:self.fristRow inComponent:0 animated:NO];
    [self.picker selectRow:self.secondRow inComponent:1 animated:NO];
    [self.picker selectRow:self.thirdRow inComponent:2 animated:NO];
    

}
//获取这个月有多少天
-(NSInteger)getNumOfDayOfMonth:(NSDate *)date
{
    NSRange range = [self.calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return range.length;
}
//判断两个日期是否是同一天
- (BOOL)isSameDay:(NSDate *)date1 date2:(NSDate *)date2
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    unsigned unitFlag = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay;
    NSDateComponents *comp1 = [calendar components:unitFlag fromDate:date1];
    NSDateComponents *comp2 = [calendar components:unitFlag fromDate:date2];
    if (( ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]))) {
        return YES;
    }else
    {
        return  NO;
    }
    //    return (([comp1 day] == [comp2 day]) && ([comp1 month] == [comp2 month]) && ([comp1 year] == [comp2 year]));
}
-(void)sure
{
    NSString *year;
    NSString *month;
    NSString *day;
    year = [self pickerView:self.picker attributedTitleForRow:[self.picker selectedRowInComponent:0] forComponent:0].string;
    month = [self pickerView:self.picker attributedTitleForRow:[self.picker selectedRowInComponent:1] forComponent:1].string;
    year = [year componentsSeparatedByString:@"年"].firstObject;
    month = [month componentsSeparatedByString:@"月"].firstObject;
    if (self.Components >2) {
        day = [self pickerView:self.picker attributedTitleForRow:[self.picker selectedRowInComponent:2] forComponent:2].string;
        day = [day componentsSeparatedByString:@"日"].firstObject;
    }
    
    if (month.length == 1) {
        month = [NSString stringWithFormat:@"0%@",month];
    }
    if (day.length == 1) {
        day = [NSString stringWithFormat:@"0%@",day];
    }
    NSString *time;
    if (self.Components>2) {
        time = [NSString stringWithFormat:@"%@-%@-%@",year,month,day];
    }else
    {
        time = [NSString stringWithFormat:@"%@-%@",year,month];
    }
    
    
    if (_returnTimeBlock) {
        _returnTimeBlock(time);
    }
}
@end
