//
//  TKBDPickerView.h
//  泰行销
//
//  Created by usee on 2017/12/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKBDPickerView : UIView
@property (nonatomic,assign) NSInteger Components;

@property (nonatomic,copy) NSString *startTime;//形如2017-01-02

@property (nonatomic,copy) NSString *endTime;//形如2017-03-09

@property (nonatomic,assign) BOOL isOrder; //yes 代表正序 NO 代表倒叙 //请先设置此属性

@property (nonatomic,copy) void(^returnTimeBlock)(NSString *time);//返回形如2017-03-05

@property (nonatomic, copy) NSString *currentTime;//当前选中的时间

+(instancetype)showInRect:(CGRect)rect SureBlock:(void(^)(NSString *time))sureBlock;
+(void)disMiss;
@end
