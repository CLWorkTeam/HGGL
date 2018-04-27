//
//  HGItemCertCell.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemCertCell.h"

@interface  HGItemCertCell ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UILabel *label;

@end

@implementation HGItemCertCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *subview in self.contentView.subviews) {
            [subview removeFromSuperview];
        }
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 5, HGScreenWidth-20, 80)];
    self.imageV = imageV;
    imageV.layer.masksToBounds = YES;
    imageV.layer.cornerRadius = 10;
    [self.contentView addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, imageV.maxY, HGScreenWidth, 15)];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:FONT_PT(14)];
    label.textAlignment = NSTextAlignmentCenter;
    self.label = label;
    [self.contentView addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, 99, HGScreenWidth, 1)];
    lineV.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:lineV];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
