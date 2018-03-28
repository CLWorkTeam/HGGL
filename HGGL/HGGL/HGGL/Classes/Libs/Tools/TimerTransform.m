//
//  TimerTransform.m
//  timeTransfer
//
//  Created by mac on 15-5-20.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import "TimerTransform.h"

@implementation TimerTransform
+(id)timerTransform:(NSString *)time
{
    //规定时间显示格式
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [fomatter dateFromString:time];
    //获取公历日历对象
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    //确定日期组成方式
    NSDateComponents *dc = [calendar components:NSCalendarUnitYear|NSCalendarUnitMonth|NSCalendarUnitDay|NSCalendarUnitHour|NSCalendarUnitMinute|NSCalendarUnitSecond|NSCalendarUnitWeekday|NSCalendarUnitWeekOfYear fromDate:date];
    //返回日期组成让接受者自己解析自己需要的东西
    
    return dc;
    
}
//输入一个日期 返回当年所有周的数组（里面内容是字典 第几周，这一周的开始日期和结束时间）
+(NSArray *)AllWeeksOfThisYear:(NSInteger)year
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSString *firstOfYear = [NSString stringWithFormat:@"%ld.1.1",year];
    //NSLog(@"%@",firstOfYear);
    NSDate *date = [fomatter dateFromString:firstOfYear];
    //NSString *str = [fomatter stringFromDate:date];
    //获得今年第一天所在周的第一天的日期
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 2;
    __autoreleasing NSDate  *dateOut = [NSDate date];
    __autoreleasing NSDate **sDate = &dateOut;
    NSTimeInterval intOut;
    NSTimeInterval *intervalOut = &intOut;
    NSMutableArray *yearArr = [NSMutableArray array];
    if ([calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:sDate interval:intervalOut forDate:date]) {
        NSString *weekStar = [fomatter stringFromDate:*sDate];
        NSDateComponents *intervalDay = [[NSDateComponents alloc]init];
        [intervalDay setDay:6];
        NSDate *eDate = [calendar dateByAddingComponents:intervalDay toDate:*sDate options:0];
        NSString *weekEnd = [fomatter stringFromDate:eDate];
        NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        [dict1 setValue:weekStar forKey:@"weekStar"];
        [dict1 setValue:@"1" forKey:@"week"];
        [dict1 setValue:weekEnd forKey:@"weekEnd"];
        [yearArr addObject:dict1];
        //NSLog(@"%p",dict1);
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[fomatter dateFromString:[NSString stringWithFormat:@"%ld.2.2",year]]];
        NSDateComponents *dc1 =[TimerTransform timerTransform:[fomatter stringFromDate:date]];
        NSInteger weekday = dc1.weekday;
        // NSLog(@"%ld - %ld",weekday,range.location);
        NSDateComponents *d = [[NSDateComponents alloc]init];
        [d setDay:7];
        //NSLog(@"%@",yearArr.lastObject);
        //NSLog(@"%ld - %ld",weekday,range.length);
//        if (!(weekday == 2&&range.length == 29)) {
        //NSLog(@"%d",(weekday == 1&&range.length == 29)? 54:53);
            for (int i = 1; i< ((weekday == 1&&range.length == 29)? 54:53) ; i++) {
                NSDictionary *dict = [[yearArr lastObject] mutableCopy];
                //NSLog(@"%@",dict);
                NSDate *da = [fomatter dateFromString:[dict objectForKey:@"weekStar"]];
                NSDate *da1 = [fomatter dateFromString:[dict objectForKey:@"weekEnd"] ];
                NSDate *date1 = [calendar dateByAddingComponents:d toDate: da options:0];
                NSDate *date2 = [calendar dateByAddingComponents:d toDate:da1 options:0];
                NSString *weekStr = [NSString stringWithFormat:@"%d",i+1];
                [dict setValue:[fomatter stringFromDate:date1] forKey:@"weekStar"];
                [dict setValue:weekStr forKey:@"week"];
                [dict setValue:[fomatter stringFromDate:date2] forKey:@"weekEnd"];
                //NSLog(@"%@",dict);
                [yearArr addObject:dict];
                //NSLog(@"%@",dict);
               
                            }
            return yearArr;
        
    }
    else{
        return nil ;
    }
    
}
//根据一天的日期返回这个日期所在星期的所有天
+(NSArray *)AllDayOfThisWeek:(NSString *)time
{
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSDate *date = [fomatter dateFromString:time];
    NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    calendar.firstWeekday = 2;
    __autoreleasing NSDate  *dateOut = [NSDate date];
    __autoreleasing NSDate **sDate = &dateOut;
    NSTimeInterval intOut;
    NSTimeInterval *intervalOut = &intOut;
    NSMutableArray *weekArr = [NSMutableArray array];
    if ([calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:sDate interval:intervalOut forDate:date]) {
        NSString *weekStar = [fomatter stringFromDate:*sDate];
       // NSLog(@"%@",weekStar);
        NSDateComponents *intervalDay = [[NSDateComponents alloc]init];
        [intervalDay setDay:1];
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        //[dict setValue:@"周1" forKey:weekStar];
        [dict setValue:weekStar forKey:@"date"];
        [dict setValue:@"1" forKey:@"weekday"];
        [weekArr addObject:dict];
        for (int i = 0; i<6; i++) {
            NSDictionary *dict1 = [[weekArr lastObject]mutableCopy];
            NSDate *da = [fomatter dateFromString:[dict1 objectForKey:@"date"]];
            NSDate *eDate = [calendar dateByAddingComponents:intervalDay toDate:da  options:0];
            [dict1 setValue:[NSString stringWithFormat:@"%d",i+2] forKey:@"weekday"];
            //NSLog(@"%d",i+2);
            [dict1 setValue:[fomatter stringFromDate:eDate] forKey:@"date"];
            [weekArr addObject:dict1];
        }
        return weekArr;
        
        
    }else
    {return nil;}
    
}
@end
