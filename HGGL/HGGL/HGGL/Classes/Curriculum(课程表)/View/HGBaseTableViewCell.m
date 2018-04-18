//
//  HGBaseTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBaseTableViewCell.h"
#import "TextFrame.h"
#import "TeacViewController.h"
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGFont] Andwidth:60].height
#define cellHigh 44
#define keyWidth 70
@interface HGBaseTableViewCell  ()
@property (nonatomic,weak) UILabel *key;
@property (nonatomic,weak) UILabel *value;
@property (nonatomic,weak) UIButton *but;
@end
@implementation HGBaseTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
//    _name = name;
    UILabel *key = [[UILabel alloc]init];
    key.textAlignment = NSTextAlignmentLeft;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:HGFont];
    self.key = key;
//    key.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth*0.35-CellWMargin, minH);
//    key.text = name;
    [self.contentView addSubview:key];
    
    
    
    UILabel *value = [[UILabel alloc]init];
    value.numberOfLines = 0;
    value.textAlignment = NSTextAlignmentLeft;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    self.value = value;
//    value.text = nameV;
//    CGSize size1 = [TextFrame frameOfText:nameV With:self.value.font Andwidth:HGScreenWidth*0.65-CellWMargin];
//    value.frame = CGRectMake(HGScreenWidth*0.35, CellHMargin, HGScreenWidth*0.65-CellWMargin, size1.height);
//    CGFloat he = size1.height+2*CellHMargin;
//    if (he>cellHigh) {
//        value.textAlignment = NSTextAlignmentLeft;
//    }
    [self.contentView addSubview:value];
}
-(void)setNameV:(NSString *)nameV
{
    _nameV = nameV;
    self.value.text = nameV;
    if ([self.name isEqualToString:@"授课教师:"]) {
        if (nameV&&(nameV.length>0)&&self.objID) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
            [but setTitle:@"教师详情>" forState:UIControlStateNormal];
            [but setTitleColor:HGMainColor forState:UIControlStateNormal];
            [but addTarget:self action:@selector(infoClick) forControlEvents:UIControlEventTouchUpInside];
            self.but = but;
            [self.contentView addSubview:but];
            but.titleLabel.font = [UIFont systemFontOfSize:HGFont];
        }
    }
    [self layoutSubviews];
}
-(void)setName:(NSString *)name
{
    
    _name = name;
    NSAttributedString *attStr = [TextFrame bothLeftAndRightAlignmentWithSymbolWithString:name WithFont:self.key.font AndWidth:self.maxW];
    self.key.attributedText = attStr;
    
    [self layoutSubviews];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.key.frame = CGRectMake(CellWMargin, CellHMargin, self.maxW, minH);
    CGSize size1 = [TextFrame frameOfText:self.value.text With:self.value.font Andwidth:self.width-self.key.width-3*CellWMargin];
    self.value.frame = CGRectMake(self.key.maxX+CellWMargin, CellHMargin, self.width-self.key.width-3*CellWMargin, size1.height);
    if ([self.name isEqualToString:@"授课教师:"]) {
        if (self.nameV&&(self.nameV.length>0)&&self.objID) {
            
            if (self.but) {
                [self.but sizeToFit];
                CGSize size2 = [TextFrame frameOfText:self.value.text With:self.value.font Andwidth:self.width-self.key.width-self.but.width-4*CellWMargin];
                self.value.frame = CGRectMake(self.key.maxX+CellWMargin, CellHMargin, self.width-self.key.width-self.but.width-4*CellWMargin, size2.height);
                self.but.frame = CGRectMake(self.width-CellWMargin-self.but.width, 0 , self.but.width, self.height);
            }
            
        }
    }
    self.key.center = CGPointMake(self.key.center.x, self.height/2);
    self.value.center = CGPointMake(self.value.center.x, self.height/2);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGBaseTableViewCell";
    
    HGBaseTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell = [[HGBaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        cell.objID = nil;
        cell.but = nil;
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    
    return cell;
}
-(void)infoClick
{
    if (_clickBlock) {
        _clickBlock(self.objID);
    }
}
@end
