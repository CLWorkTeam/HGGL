//
//  IntroTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-21.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "IntroTableViewCell.h"
#import "TextFrame.h"
//#define cellHigh 60
#define keyWidth 65
//#define keyHigh [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:keyWidth].height
@interface IntroTableViewCell()
@property (nonatomic,weak) UILabel *key;
@property (nonatomic,weak) UILabel *value;
@end
@implementation IntroTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    UILabel *key = [[UILabel alloc]init];
//    key.textAlignment = NSTextAlignmentCenter;
//    key.textColor = [UIColor blackColor];
//    key.font = [UIFont systemFontOfSize:14];
//    self.key = key;
//    [self addSubview:key];
//    UILabel *value = [[UILabel alloc]init];
//    value.textAlignment = NSTextAlignmentLeft;
//    value.textColor = [UIColor blackColor];
//    value.font = [UIFont systemFontOfSize:12];
//    self.value = value;
//    [self addSubview:value];

    
}
-(void)setName:(NSString *)name
{
    _name = name;
    UILabel *key = [[UILabel alloc]init];
    key.textAlignment = NSTextAlignmentCenter;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:14];
    self.key = key;
    [self addSubview:key];
    self.key.text = name;
    self.key.frame = CGRectMake(CellWMargin, CellHMargin, keyWidth, minH);
    
    
}
-(void)setInfo:(NSString *)info
{
    _info = info;
    UILabel *value = [[UILabel alloc]init];
    value.textAlignment = NSTextAlignmentLeft;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    value.numberOfLines = 0;
    self.value = value;
    value.text = info;
    [self addSubview:value];
    CGFloat H = [TextFrame frameOfText:info With:[UIFont systemFontOfSize:HGFont] Andwidth:HGScreenWidth-keyWidth-2*CellWMargin-CellHMargin].height;
    
    CGFloat height = H >= minH? H:minH;
    self.value.frame = CGRectMake(keyWidth+CellHMargin+CellWMargin, CellHMargin , HGScreenWidth-keyWidth-CellWMargin*2-CellHMargin, height);


}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    IntroTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[IntroTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
