//
//  TKWebProgressView.h
//  泰行销
//
//  Created by edz on 2017/9/14.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKWebProgressView : UIView

//进度条颜色
@property (nonatomic,strong) UIColor  *lineColor;

//开始加载
-(void)startLoadingAnimation;

//结束加载
-(void)endLoadingAnimation;

@end
