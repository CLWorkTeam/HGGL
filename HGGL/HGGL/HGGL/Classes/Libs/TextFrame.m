//
//  TextFrame.m
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TextFrame.h"

@implementation TextFrame

+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font Andwidth:(CGFloat) width andLineSpace:(NSInteger) space
{
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = font;
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc]init];
    style.lineSpacing = space;
    att[NSParagraphStyleAttributeName] =style;
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    return rect.size;
}
+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font AndHeigh:(CGFloat) heigh
{
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = font;
    CGRect rect = [str boundingRectWithSize:CGSizeMake(MAXFLOAT, heigh) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    return rect.size;
}
+(CGSize)frameOfText:(NSString *)str With:(UIFont *)font Andwidth:(CGFloat) width
{
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = font;
    CGRect rect = [str boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    return rect.size;
}
+(NSMutableAttributedString *)bothLeftAndRightAlignmentWithOutSybolWithString:(NSString *)str WithFont:(UIFont *)font AndWidth:(CGFloat) width
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:str];
    CGSize attStringSize = [attString.string sizeWithAttributes:@{NSFontAttributeName:font}];
    NSNumber *space = [NSNumber numberWithFloat:(width-attStringSize.width)/(str.length-1)];
    //    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,str.length-1)];
    [attString addAttribute:NSKernAttributeName value:space range:NSMakeRange(0,str.length-1)];
    return attString;
    
}
+(NSMutableAttributedString *)bothLeftAndRightAlignmentWithSymbolWithString:(NSString *)str WithFont:(UIFont *)font AndWidth:(CGFloat) width
{
    NSMutableAttributedString *attString = [[NSMutableAttributedString alloc]initWithString:str];
    CGSize attStringSize = [attString.string sizeWithAttributes:@{NSFontAttributeName:font}];
    NSNumber *space = [NSNumber numberWithFloat:(width-attStringSize.width)/(str.length-2)];
    //    [attString addAttribute:NSFontAttributeName value:font range:NSMakeRange(0,str.length-1)];
    [attString addAttribute:NSKernAttributeName value:space range:NSMakeRange(0,str.length-2)];
    return attString;
    
}
@end
