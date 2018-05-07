//
//  CurrView.h
//  SYDX_2
//
//  Created by mac on 15-5-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class Date;
@class WeekToolBar;
@interface CurrView : UIView
@property (nonatomic,copy) NSString *weekOfYear;
@property (nonatomic,copy) NSString *today;
@property (nonatomic,copy) void(^datePicker)();
@property (nonatomic,assign)CGRect rect;
@property (nonatomic ,weak) UIButton *but;
@property (nonatomic,weak) WeekToolBar *toolBar;
@end
