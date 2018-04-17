//
//  MListTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MListTableViewCell.h"
#import "Mentee.h"
#import "HGLable.h"
#import "TextFrame.h"
//#define butH 25
//#define margin 8
@interface MListTableViewCell()

@end
@implementation MListTableViewCell

-(void)setMentee:(Mentee *)mentee
{
    _mentee = mentee;
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    name.text = mentee.mentee_name;
    [self.contentView  addSubview:name];
    name.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth*0.3-CellWMargin, minH);
    UILabel *sex = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
    sex.text = mentee.mentee_sex;
    sex.frame = CGRectMake(CGRectGetMaxX(name.frame), CellHMargin, HGScreenWidth*0.2, minH);
    [self.contentView addSubview:sex];
    UILabel *tel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    tel.text = mentee.mentee_tel;
    tel.frame = CGRectMake(CGRectGetMaxX(sex.frame), CellHMargin, HGScreenWidth*0.5-CellWMargin, minH);
    [self.contentView addSubview:tel];
    UILabel *unit = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    unit.text = @"单位/职务:";
    unit.frame = CGRectMake(CellWMargin, minH+2*CellHMargin, HGScreenWidth*0.3-CellWMargin, minH);
    [self.contentView addSubview:unit];
    
    UILabel *unitV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    unitV.text = [NSString stringWithFormat:@"%@  %@", mentee.mentee_workUnit, mentee.mentee_duty];
    unitV.frame = CGRectMake(CGRectGetMaxX(unit.frame), minH+CellHMargin*2, HGScreenWidth*0.7-CellWMargin, minH);
    [self.contentView addSubview:unitV];
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    MListTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MListTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
