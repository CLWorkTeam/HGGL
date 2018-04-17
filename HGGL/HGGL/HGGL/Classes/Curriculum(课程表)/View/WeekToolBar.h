//
//  WeekToolBar.h
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Date;

@interface WeekToolBar : UIToolbar
@property (nonatomic,copy) NSArray *date;
@property (nonatomic,copy) void(^weekDayClick)(NSString *date);
@end
