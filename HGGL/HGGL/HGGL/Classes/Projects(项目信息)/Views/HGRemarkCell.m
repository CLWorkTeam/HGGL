//
//  HGRemarkCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/4.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRemarkCell.h"
#import "HGLable.h"
@interface HGRemarkCell ()
@property (nonatomic,weak) UILabel *titleL;
@property (nonatomic,weak) UILabel *remarkL;
@property (nonatomic,weak) UILabel *nameL;
@property (nonatomic,weak) UILabel *departL;
@property (nonatomic,weak) UIView *line;
@end
@implementation HGRemarkCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setUpAllSubviews];
        
    }
    return self;
}
-(void)setUpAllSubviews
{
    
    
    
    
    
    UILabel *titleL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGTipFont Color:[UIColor blackColor]];
    [self.contentView  addSubview:titleL];
    self.titleL = titleL;
    titleL.numberOfLines = 0;
    
    UILabel *remarkL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGTipFont Color:[UIColor blackColor]];
    [self.contentView  addSubview:remarkL];
    self.remarkL = remarkL;
    remarkL.numberOfLines = 0;
    
    UILabel *nameL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGTipFont Color:[UIColor blackColor]];
    [self.contentView  addSubview:nameL];
    self.nameL = nameL;
    nameL.numberOfLines = 0;
    
    UILabel *departL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGTipFont Color:[UIColor blackColor]];
    [self.contentView  addSubview:departL];
    self.departL = departL;
    departL.numberOfLines = 0;
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = [UIColor grayColor];
    self.line = line;
    [self.contentView addSubview:line];
    
    
    
    
    
}
-(void)setModel:(HGPBRemarkModel *)model
{
    self.titleL.text = model.title;
    self.remarkL.text = model.remark;
    self.nameL.text = model.staff;
    self.departL.text = model.department;
    self.titleL.frame = model.titleF;
    self.remarkL.frame = model.remarkF;
    self.nameL.frame = model.staffF;
    self.departL.frame = model.departmentF;
    self.line.frame = CGRectMake(CellWMargin, 0, HGScreenWidth-2*CellWMargin, 1);
}
-(void)setIsFirst:(BOOL)isFirst
{
    _isFirst = isFirst;
    
    if (isFirst) {
        self.titleL.font =  [UIFont fontWithName:@"Helvetica-Bold" size:HGTipFont];
        self.remarkL.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGTipFont];
        self.nameL.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGTipFont];
        self.departL.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGTipFont];
        self.line.hidden = YES;
    }else
    {
        self.titleL.font = [UIFont systemFontOfSize:HGTipFont];
        self.remarkL.font = [UIFont systemFontOfSize:HGTipFont];
        self.nameL.font = [UIFont systemFontOfSize:HGTipFont];
        self.departL.font = [UIFont systemFontOfSize:HGTipFont];
        self.line.hidden = NO;
    }
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGRemarkCell";
    HGRemarkCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGRemarkCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
