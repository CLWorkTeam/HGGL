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

    UILabel *key = [[UILabel alloc]init];
    key.textAlignment = NSTextAlignmentLeft;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:HGFont];
    self.key = key;
    [self.contentView addSubview:key];
    
    
    UILabel *value = [[UILabel alloc]init];
//    value.numberOfLines = 0;
    value.textAlignment = NSTextAlignmentRight;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    self.value = value;
    
    [self.contentView addSubview:value];
}
-(void)setName:(NSString *)name
{
   // NSLog(@"arr");
    _name = name;
    
    
    self.key.text = name;
    


}
-(void)setNameV:(NSString *)nameV
{
    _nameV = nameV;
    self.value.text = nameV;
    
    


    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.key sizeToFit];
    CGFloat mar = 5;
    self.key.frame = CGRectMake(CellWMargin, CellHMargin, self.key.width, minH);
    CGSize size1 = [TextFrame frameOfText:self.nameV With:self.value.font Andwidth:self.width-self.key.width-2*CellWMargin-mar];
    
    CGFloat he = ((size1.height+2*CellHMargin)>(minH+2*CellHMargin))?(size1.height+2*CellHMargin):(minH+2*CellHMargin);
    if (he>cellHigh) {
//        self.value.textAlignment = NSTextAlignmentLeft;
    }
    self.value.frame = CGRectMake(self.key.maxX+mar, CellHMargin, self.width-2*CellWMargin-mar-self.key.width, minH);
    self.key.center = CGPointMake(self.key.center.x, self.height/2);
    self.value.center = CGPointMake(self.value.center.x, self.height/2);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    BaseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
@end
