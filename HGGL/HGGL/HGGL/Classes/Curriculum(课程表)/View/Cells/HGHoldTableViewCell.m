//
//  HGHoldTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/24.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGHoldTableViewCell.h"
#import "HGLable.h"
#import "HGHoldRMDModel.h"
@interface HGHoldTableViewCell ()
@property (nonatomic,weak) UILabel *PNameL;
@property (nonatomic,weak) UILabel *CNameL;
@property (nonatomic,weak) UILabel *numL;
@property (nonatomic,weak) UILabel *timeL;
@property (nonatomic,weak) UILabel *contactL;
@property (nonatomic,weak) UILabel *telL;
@end
@implementation HGHoldTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *PNameL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.PNameL = PNameL;
        [self.contentView addSubview:PNameL];
        
        UILabel *CNameL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.CNameL = CNameL;
        [self.contentView addSubview:CNameL];
        
        UILabel *numL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.numL = numL;
        [self.contentView addSubview:numL];
        
        UILabel *timeL = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.timeL = timeL;
        [self.contentView addSubview:timeL];
        
        UILabel *contactL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.contactL = contactL;
        [self.contentView addSubview:contactL];
        
        UILabel *telL = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.telL = telL;
        [self.contentView addSubview:telL];
        
        
       
        
        
        
        
    }
    return self;
}
-(void)setModel:(HGHoldRMDModel *)model
{
    _model = model;
    self.PNameL.text = [NSString stringWithFormat:@"项目名称：%@",model.projectName];
    self.CNameL.text = [NSString stringWithFormat:@"课程名称：%@",model.courseName];
    self.numL.text = [NSString stringWithFormat:@"课程名称：%@",model.peopleNum];
    self.telL.text = model.contactPhone;
    self.timeL.text = [NSString stringWithFormat:@"时间：%@-%@",model.startTime,model.endTime];
    self.contactL.text = [NSString stringWithFormat:@"联系人：%@",model.contact];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Wmargin = 5;
    CGFloat Wmar = 3;
    CGFloat H = 30;
    self.PNameL.frame = CGRectMake(Wmargin, 0, self.width-2*Wmargin, H);
    self.CNameL.frame = CGRectMake(self.PNameL.x, self.PNameL.maxY, self.PNameL.width, H);
    [self.numL sizeToFit];
    self.numL.frame = CGRectMake(Wmargin, self.CNameL.maxY, self.numL.width, H);
    self.timeL.frame = CGRectMake(self.numL.maxX+Wmar, self.numL.y, self.width-2*Wmargin-Wmar-self.numL.width, H);
    [self.telL sizeToFit];
    self.telL.frame = CGRectMake(self.width-Wmargin-self.telL.width, self.timeL.maxY, self.telL.width, H);
    self.contactL.frame = CGRectMake(Wmargin, self.telL.y, self.width-2*Wmargin-Wmar-self.telL.width, H);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGTRBTableViewCell";
    HGHoldTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGHoldTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
