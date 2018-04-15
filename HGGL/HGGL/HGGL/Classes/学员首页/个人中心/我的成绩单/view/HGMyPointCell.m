//
//  HGMyPointCell.m
//  HGGL
//
//  Created by taikang on 2018/4/11.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMyPointCell.h"

@implementation HGMyPointCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        for (UIView *subview in self.contentView.subviews) {
            [subview removeFromSuperview];
        }
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 0, HGScreenWidth-30, 50)];
    view1.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:view1];
    
    CALayer *topBorder = [CALayer layer];
    topBorder.frame = CGRectMake(0.0f, 0.0f, view1.width, 1.0f);
    topBorder.backgroundColor = HGColor(249, 202, 168, 1).CGColor;
    [view1.layer addSublayer:topBorder];
    self.topLayer = topBorder;


    CALayer *leftBorder = [CALayer layer];
    leftBorder.frame = CGRectMake(0.0f, 0.0f, 1.0f, view1.height);
    leftBorder.backgroundColor = HGColor(249, 202, 168, 1).CGColor;
    [view1.layer addSublayer:leftBorder];
    
    CALayer *rightBorder = [CALayer layer];
    rightBorder.frame = CGRectMake(view1.width-1,0.0f , 1.0f, view1.height);
    rightBorder.backgroundColor = HGColor(249, 202, 168, 1).CGColor;
    [view1.layer addSublayer:rightBorder];

    CALayer *bottomBorder = [CALayer layer];
    bottomBorder.frame = CGRectMake(0.0f, view1.height-1, view1.width, 1);
    bottomBorder.backgroundColor = HGColor(249, 202, 168, 1).CGColor;
    [view1.layer addSublayer:bottomBorder];
    self.bottomLayer = bottomBorder;

    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.width/3*2, view1.height)];
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:18];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HGMainColor;
    self.nameLab = label;
    [view1 addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(label.maxX, 0, 1.5, view1.height)];
    lineV.backgroundColor = HGColor(249, 202, 168, 1);
    self.lineV = lineV;
    [view1 addSubview:lineV];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(lineV.maxX, 0, view1.width/3*1 - 1.5, view1.height)];
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:18];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HGMainColor;
    self.pointLab = label1;
    [view1 addSubview:label1];

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
