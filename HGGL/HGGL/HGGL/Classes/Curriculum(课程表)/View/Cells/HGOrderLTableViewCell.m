//
//  HGOrderLTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGOrderLTableViewCell.h"
#import "HGLable.h"
#import "HGOrderModel.h"
#import "UIImageView+WebCache.h"
@interface HGOrderLTableViewCell   ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *nameLable;
@property (nonatomic,weak) UILabel *numLable;

@end
@implementation HGOrderLTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *ima = [[UIImageView alloc]init];
        self.ima = ima;
        [self.contentView  addSubview:ima];
        
        UILabel *nameLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        nameLable.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
        self.nameLable = nameLable;
        [self.contentView addSubview:nameLable];
        
        UILabel *numLable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
        self.numLable = numLable;
        [self.contentView addSubview:numLable];
        
        
    }
    return self;
}
-(void)setModel:(HGOrderModel *)model
{
    _model = model;

    NSString *holder = [[NSBundle mainBundle] pathForResource:@"icon_default" ofType:@"png"];
    
    [self.ima sd_setImageWithURL:[NSURL URLWithString:[HGURLImage stringByAppendingString:model.menuUrl]] placeholderImage:[UIImage imageWithContentsOfFile:holder]];
    
    self.nameLable.text = model.menuName;
    
    self.numLable.text = [NSString stringWithFormat:@"预订份数：%@",model.menuNum];
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat Wmar = 5;
    
    CGFloat Hmar = 5;
    
    CGFloat H = 30;
    
    CGFloat imaW = 80;
    
    self.ima.frame = CGRectMake(Wmar, Hmar,imaW , H*2);
    
    self.nameLable.frame = CGRectMake(self.ima.maxX+Wmar, Hmar, self.width-3*Wmar-self.ima.width,H );
    
    self.numLable.frame = CGRectMake(self.nameLable.x, self.nameLable.maxY, self.nameLable.width, H);
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGOrderLTableViewCell";
    HGOrderLTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell.selectionStyle=UITableViewCellSelectionStyleNone;
        cell = [[HGOrderLTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
