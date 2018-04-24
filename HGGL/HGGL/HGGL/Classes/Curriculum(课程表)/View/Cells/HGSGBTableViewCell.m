//
//  HGSGBTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSGBTableViewCell.h"
#import "HGSRBModel.h"
#import "HGLable.h"
@interface HGSGBTableViewCell ()
@property (nonatomic,weak) UILabel *nameL;
@property (nonatomic,weak) UILabel *telL;
@property (nonatomic,weak) UILabel *classL;
@property (nonatomic,weak) UILabel *endL;
@property (nonatomic,weak) UILabel *numL;
@end
@implementation HGSGBTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.nameL = nameL;
        [self.contentView addSubview:nameL];
        
        UILabel *telL = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.telL = telL;
        [self.contentView addSubview:telL];
        
        UILabel *classL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.classL = classL;
        [self.contentView addSubview:classL];
        
        UILabel *endL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.endL = endL;
        [self.contentView addSubview:endL];
        
        UILabel *numL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.numL = numL;
        [self.contentView addSubview:numL];
        
        
    }
    return self;
}
-(void)setModel:(HGSRBModel *)model
{
    _model = model;
    self.nameL.text = model.name;
    self.telL.text = model.phone;
    self.classL.text = [NSString stringWithFormat:@"所在班级：%@",model.department];
    self.endL.text = [NSString stringWithFormat:@"项目结束时间：%@",model.endTime];
    self.numL.text = [NSString stringWithFormat:@"待归还数量：%@",model.borrowNum];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat mar = 5;
    CGFloat H = 30;
    [self.telL sizeToFit];
    self.telL.frame = CGRectMake(self.width-CellWMargin-self.telL.width, 0, self.telL.width, H);
    self.nameL.frame = CGRectMake(self.width-2*CellWMargin-mar, self.telL.y, self.width-2*CellWMargin-mar-self.telL.width, H);
    self.classL.frame = CGRectMake(CellWMargin, self.nameL.maxY, self.width-2*CellWMargin, H);
    self.endL.frame = CGRectMake(CellWMargin, self.classL.maxY, self.classL.width, H);
    self.numL.frame = CGRectMake(CellWMargin, self.endL.maxY, self.classL.width, H);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGSGBTableViewCell";
    HGSGBTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGSGBTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
