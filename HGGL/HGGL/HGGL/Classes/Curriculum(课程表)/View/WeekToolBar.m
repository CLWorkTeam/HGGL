//
//  WeekToolBar.m
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "WeekToolBar.h"
#import "TimerTransform.h"
#import "Date.h"
@interface WeekToolBar ()
@property (nonatomic,strong) NSMutableArray *butArray;
@property (nonatomic,weak) UIButton *selectedBut;
@property (nonatomic,strong)NSArray *dateArr;
@end
@implementation WeekToolBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(NSArray *)butArray
{
    if (_butArray == nil) {
        _butArray = [NSMutableArray array];
        
    }
    return _butArray;
}
-(void)setDate:(NSArray *)date
{
    _date = date;
    //NSLog(@"tool");
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSString *str2 = [fomatter stringFromDate:[NSDate date]];
    //NSString *str3 = @"2015.06.16";
//    for (int i = 0; i<7; i++) {
//        UIButton *but =[[UIButton alloc]init];
//        but.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
//        NSDictionary *dict = [_date objectAtIndex:i];
//        NSString *str = [dict objectForKey:@"date"];
//        NSString *str1 = [str substringFromIndex:5];
//
//        [but setTitle:[NSString stringWithFormat:@"周%@\n%@",[dict objectForKey:@"weekday"],str1] forState:UIControlStateNormal];
//        if ([str isEqualToString:str2]) {
//            [self butClick:but];
//        }
//        but.tag = i;
//        but.titleLabel.textAlignment = NSTextAlignmentCenter;
//        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
//        [self.butArray addObject:but];
//        [self addSubview:but];
//        //NSLog(@"setdate");
//        
//    }
    int i = 0;
    int j = 0;
    for (UIButton *but in self.butArray) {
        NSDictionary *dict = [_date objectAtIndex:i];
        NSString *str = [dict objectForKey:@"date"];
        NSString *str1 = [str substringFromIndex:5];
        but.contentMode = UIViewContentModeCenter;
        
        [but setBackgroundImage:[UIImage imageNamed:@"date_bg"] forState:UIControlStateSelected];
        [but setTitle:[NSString stringWithFormat:@"周%@\n%@",[dict objectForKey:@"weekday"],str1] forState:UIControlStateNormal];
        //NSString *s = [NSString stringWithFormat:@"周%@\n%@",[dict objectForKey:@"weekday"],str1];
        //HGLog(@"%d,,,,,%d",[s rangeOfString:str1].location,[s rangeOfString:str1].length);
        if ([str isEqualToString:str2]) {
            [self butClick:but];
             //NSLog(@"进来了,%ld,%@",but.tag,str);
            j++;
        }

        i++;
    }
    if (!j) {
        UIButton *butt = [self.butArray objectAtIndex:0];
        [self butClick:butt];
        HGLog(@"星期一%d",j);
    }
    
}
-(void)butClick:(UIButton *)but
{
    _selectedBut.selected = NO;
    //[_selectedBut  setBackgroundColor:[UIColor whiteColor]];
    but.selected = YES;
    _selectedBut  = but;
    //[_selectedBut setBackgroundColor:[UIColor redColor]];
    HGLog(@"%@",_weekDayClick);
    if (_weekDayClick) {
        NSString *str1 = [but.titleLabel.text substringWithRange:NSMakeRange(3, 2)];
        NSString *str2 = [but.titleLabel.text substringWithRange:NSMakeRange(6, 2)];
        NSString *str = [NSString stringWithFormat:@"-%@-%@",str1,str2];
        _weekDayClick(str);
    }
   
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        for (int i = 0; i<7; i++) {
            UIButton *but =[[UIButton alloc]init];
            but.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            but.titleLabel.font = [UIFont systemFontOfSize:14];
            //[but.titleLabel setTextColor:[UIColor blackColor]];
            but.tag = i;
            but.titleLabel.textAlignment = NSTextAlignmentCenter;
            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.butArray addObject:but];
            [self addSubview:but];
            if (i>4) {
                [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            }

        }
    
    }
    return self;
}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    [self setButFrame];
}
-(void)setButFrame
{
    CGFloat y = 0;
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width/7;
    CGFloat x = 0;
    int i = 0;
    for (UIButton *but in self.butArray) {
        but.frame = CGRectMake(x+i*width, y, width, height);
        i++;
    }
    
}
@end
