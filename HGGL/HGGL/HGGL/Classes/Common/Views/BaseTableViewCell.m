//
//  BaseTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BaseTableViewCell.h"
#import "TextFrame.h"
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGFont] Andwidth:60].height
#define cellHigh minH+2*CellHMargin
#define keyWidth 70
//#define keyHigh [TextFrame frameOfText:@"工作单位" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
//#define magin 8
@interface BaseTableViewCell()
@property (nonatomic,weak) UILabel *key;
@property (nonatomic,weak) UILabel *value;
//@property (nonatomic,weak) UILabel *key2;
//@property (nonatomic,weak) UILabel *value2;
@end
@implementation BaseTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    UILabel *key1 = [[UILabel alloc]init];
//    key1.textAlignment = NSTextAlignmentCenter;
//    key1.textColor = [UIColor blackColor];
//    key1.font = [UIFont systemFontOfSize:14];
//    self.key1 = key1;
//    [self.contentView addSubview:key1];
//    UILabel *value1 = [[UILabel alloc]init];
//    value1.numberOfLines = 0;
//    value1.textAlignment = NSTextAlignmentLeft;
//    value1.textColor = [UIColor blackColor];
//    value1.font = [UIFont systemFontOfSize:12];
//    self.value1 = value1;
//    [self.contentView addSubview:value1];
//    UILabel *key2 = [[UILabel alloc]init];
//    key2.textAlignment = NSTextAlignmentCenter;
//    key2.textColor = [UIColor blackColor];
//    key2.font = [UIFont systemFontOfSize:14];
//    self.key2 = key2;
//    [self.contentView addSubview:key2];
//    UILabel *value2 = [[UILabel alloc]init];
//    value2.numberOfLines = 0;
//    value2.textAlignment = NSTextAlignmentLeft;
//    value2.textColor = [UIColor blackColor];
//    value2.font = [UIFont systemFontOfSize:12];
//    self.value2 = value2;
//    [self.contentView addSubview:value2];
    
}
-(void)setName:(NSString *)name
{
   // NSLog(@"arr");
    _name = name;
    UILabel *key = [[UILabel alloc]init];
    key.textAlignment = NSTextAlignmentLeft;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:HGFont];
    self.key = key;
    key.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth*0.35-CellWMargin, minH);
    key.text = name;
    [self.contentView addSubview:key];
//    UILabel *key2 = [[UILabel alloc]init];
//    key2.textAlignment = NSTextAlignmentCenter;
//    key2.textColor = [UIColor blackColor];
//    key2.font = [UIFont systemFontOfSize:14];
//    self.key2 = key2;
//    [self.contentView addSubview:key2];
//    NSString *str1 = arr.firstObject;
//    self.key1.text = str1;
//
//    self.key1.frame = CGRectMake(0, 0, keyWidth, keyHigh);
//    //self.key1.center = CGPointMake(keyWidth/2, cellHigh/2);
//    if (arr.count==2) {
//        NSString *str2 = arr.lastObject;
//        self.key2.text = str2;
//        CGFloat valueWidth = (HGScreenWidth-2*keyWidth)/2;
//        self.key2.frame = CGRectMake(keyWidth+valueWidth, 0, keyWidth, keyHigh);
//       // self.key2.center = CGPointMake(keyWidth+valueWidth+keyWidth/2, cellHigh/2);
//    }

}
-(void)setNameV:(NSString *)nameV
{
    _nameV = nameV;
    UILabel *value = [[UILabel alloc]init];
    value.numberOfLines = 0;
    value.textAlignment = NSTextAlignmentRight;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    self.value = value;
    value.text = nameV;
    CGSize size1 = [TextFrame frameOfText:nameV With:self.value.font Andwidth:HGScreenWidth*0.65-CellWMargin];
    value.frame = CGRectMake(HGScreenWidth*0.35, CellHMargin, HGScreenWidth*0.65-CellWMargin, size1.height);
    CGFloat he = size1.height+2*CellHMargin;
    if (he>cellHigh) {
        value.textAlignment = NSTextAlignmentLeft;
    }
    [self.contentView addSubview:value];
//    UILabel *value2 = [[UILabel alloc]init];
//    value2.numberOfLines = 0;
//    value2.textAlignment = NSTextAlignmentLeft;
//    value2.textColor = [UIColor blackColor];
//    value2.font = [UIFont systemFontOfSize:12];
//    self.value2 = value2;
//    [self.contentView addSubview:value2];
//
//    CGFloat valueWidth = (infoArr.count == 1?(HGScreenWidth - keyWidth):(HGScreenWidth-2*keyWidth)/2);
//    //self.key1.frame = CGRectMake(0, 0, keyWidth, cellHigh);
//    NSString *str1 = [infoArr firstObject];
//    
//    CGSize size1 = [TextFrame frameOfText:str1 With:self.value1.font Andwidth:valueWidth];
//    CGFloat heigh1 = size1.height <= cellHigh ? cellHigh:size1.height ;
//    self.value1.text = infoArr.firstObject;
//    //self.value1.bounds = CGRectMake(0, 0, valueWidth, heigh1);
//    self.value1.frame = CGRectMake(keyWidth,0, valueWidth, size1.height>=keyHigh?size1.height:keyHigh);
//    if (infoArr.count == 2) {
//        
//        
//        NSString *str2 = [infoArr lastObject];
//        CGSize size2 = [TextFrame frameOfText:str2 With:self.value2.font Andwidth:valueWidth];
//        CGFloat heigh2 = size2.height <= cellHigh ? cellHigh:size2.height;
//        self.value2.text = infoArr.lastObject ;
//        self.value2.frame = CGRectMake(2*keyWidth+valueWidth, 0, valueWidth, size2.height>=keyHigh?size2.height:keyHigh);
//    }

    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    BaseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }

    return cell;
}
@end
