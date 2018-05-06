//
//  TimerTransform.h
//  timeTransfer
//
//  Created by mac on 15-5-20.
//  Copyright (c) 2015年 CL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimerTransform : NSObject
//换算当前日期的各项日历转换数据
+(id)timerTransform:(NSString *)time;
+(NSArray *)AllWeeksOfThisYear:(NSInteger)year;
+(NSArray *)AllDayOfThisWeek:(NSString *)time;
+(NSString *)dayOfWeek:(NSDate *)date;
//
@end
