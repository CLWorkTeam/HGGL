//
//  TextFrame.h
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TextFrame : NSObject

//给出行距之后算出最小的尺寸
+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font Andwidth:(CGFloat) width andLineSpace:(NSInteger) space;
//定高算最小尺寸
+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font AndHeigh:(CGFloat) heigh;
//定宽算最小尺寸
+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font Andwidth:(CGFloat) width;
//不带符号左右对齐
+(NSMutableAttributedString *)bothLeftAndRightAlignmentWithOutSybolWithString:(NSString *)str WithFont:(UIFont *)font AndWidth:(CGFloat) width;
//带符号对齐 只限于最后一个是符号
+(NSMutableAttributedString *)bothLeftAndRightAlignmentWithSymbolWithString:(NSString *)str WithFont:(UIFont *)font AndWidth:(CGFloat) width;
@end
