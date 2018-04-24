//
//  HGTRBTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTRBTableViewCell.h"
#import "HGLable.h"
#import "HGTRBModel.h"
@interface HGTRBTableViewCell ()
@property (nonatomic,weak) UILabel *nameL;
@property (nonatomic,weak) UILabel *telL;

@property (nonatomic,weak) UILabel *endL;
@property (nonatomic,weak) UILabel *numL;
@end
@implementation HGTRBTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *nameL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.nameL = nameL;
        [self.contentView addSubview:nameL];
        
        UILabel *telL = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.telL = telL;
        [self.contentView addSubview:telL];
        
        
        UILabel *endL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.endL = endL;
        [self.contentView addSubview:endL];
        
        UILabel *numL = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.numL = numL;
        [self.contentView addSubview:numL];
        
        
    }
    return self;
}
-(void)setModel:(HGTRBModel *)model
{
    _model = model;
    self.nameL.text = model.name;
    self.telL.text = model.phone;
    self.endL.text = [NSString stringWithFormat:@"部门：%@",model.department];
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
    [self.numL sizeToFit];
    self.numL.frame = CGRectMake(self.width-CellWMargin-self.numL.width, self.nameL.maxY, self.numL.width, H);
    self.endL.frame = CGRectMake(CellWMargin, self.numL.y, self.width-2*CellWMargin-mar-self.numL.width,H );
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGTRBTableViewCell";
    HGTRBTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGTRBTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
