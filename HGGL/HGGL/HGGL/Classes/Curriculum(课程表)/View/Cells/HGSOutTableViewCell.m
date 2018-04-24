//
//  HGSOutTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSOutTableViewCell.h"
#import "HGSignOutModel.h"
#import "HGLable.h"
@interface HGSOutTableViewCell ()
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UILabel *classNumLable;
@property (nonatomic,weak) UILabel *signOutLable;
@property (nonatomic,weak) UILabel *SOLable;
@property (nonatomic,weak) UILabel *realKLable;
@property (nonatomic,weak) UILabel *realVlabel;
@end
@implementation HGSOutTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *titleLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        titleLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.titleLable = titleLable;
        [self.contentView addSubview:titleLable];
        
        UILabel *classNumLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.classNumLable = classNumLable;
        [self.contentView addSubview:classNumLable];
        
        UILabel *signOutLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.signOutLable = signOutLable;
        [self.contentView addSubview:signOutLable];
        
        UILabel *SOLable = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
        self.SOLable = SOLable;
        [self.contentView addSubview:SOLable];
        
        UILabel *realKLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.realKLable = realKLable;
        [self.contentView addSubview:realKLable];
        
        UILabel *realVlabel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
        self.realVlabel = realVlabel;
        [self.contentView addSubview:realVlabel];
    }
    return self;
}
-(void)setModel:(HGSignOutModel *)model
{
    _model = model;
    self.titleLable.text = model.className;
    self.classNumLable.text = [NSString stringWithFormat:@"班级总人数：%@",model.classTotalNum];
    self.signOutLable.text = @"签退人数：";
    self.SOLable.text = model.classSignOutNum;
    self.realVlabel.text = model.classRealNum;
    self.realKLable.text = @"实际用餐人数：";
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat mar = 8;
    
    CGFloat H = 30;
    
    CGFloat minW = [TextFrame frameOfText:@"10" With:[UIFont systemFontOfSize:HGFont] AndHeigh:1000].width;
    
    self.titleLable.frame = CGRectMake(mar, 0, self.width-2*mar, H);
    
    self.SOLable.frame = CGRectMake(self.width-minW-mar, self.titleLable.maxY, minW, H);
    
    [self.signOutLable sizeToFit];
    
    self.signOutLable.frame = CGRectMake(self.SOLable.x-self.signOutLable.width, self.SOLable.y, self.signOutLable.width, H);
    
    self.classNumLable.frame = CGRectMake(mar, self.SOLable.y,self.signOutLable.x-2*mar , H);
    
    [self.realKLable sizeToFit];
    
    self.realKLable.frame = CGRectMake(mar, self.classNumLable.maxY, self.realKLable.width, H);
    
    self.realVlabel.frame = CGRectMake(self.realKLable.maxX, self.realKLable.y, self.width-2*mar-self.realKLable.width, H);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGSOutTableViewCell";
    HGSOutTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGSOutTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
