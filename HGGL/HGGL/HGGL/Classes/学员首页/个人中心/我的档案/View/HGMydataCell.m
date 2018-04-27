//
//  HGMydataCell.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMydataCell.h"

@interface HGMydataCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *descLab;

@end

@implementation HGMydataCell

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
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, HGScreenWidth, 15)];
    label.font = [UIFont systemFontOfSize:FONT_PT(14)];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, label.maxY+15, HGScreenWidth, 15)];
    label1.font = [UIFont systemFontOfSize:FONT_PT(14)];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor grayColor];
    self.descLab = label1;
    [self.contentView addSubview:label1];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 74, HGScreenWidth-20, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineV];

}

-(void)setModel:(HGMydataModel *)model{
    _model = model;
    self.titleLab.text = model.project_name;
    self.descLab.text = [NSString stringWithFormat:@"%@ - %@",model.project_start,model.project_end];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
