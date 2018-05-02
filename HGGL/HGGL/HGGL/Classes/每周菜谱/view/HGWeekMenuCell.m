//
//  HGWeekMenuCell.m
//  HGGL
//
//  Created by taikang on 2018/5/1.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWeekMenuCell.h"
#import "UIImageView+WebCache.h"
#import "UIImage+GIF.h"

@interface HGWeekMenuCell ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIImageView *arrowImageV;
@property (nonatomic,strong) UILabel *titleLab;

@end


@implementation HGWeekMenuCell

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
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_PT(20), HEIGHT_PT(10), WIDTH_PT(60), HEIGHT_PT(55))];
    imageV.contentMode = UIViewContentModeScaleToFill;
    self.imageV = imageV;
    [self.contentView addSubview:imageV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX + WIDTH_PT(5),imageV.y + HEIGHT_PT(5), HGScreenWidth-imageV.maxX - WIDTH_PT(10), HEIGHT_PT(18))];
    label.textColor = [UIColor blackColor];
    label.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UIButton *minBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    minBtn.frame = CGRectMake(label.x, label.maxY+HEIGHT_PT(5), WIDTH_PT(20), HEIGHT_PT(20));
    [minBtn setImage:[UIImage imageNamed:@"icon_minus"] forState:UIControlStateNormal];
    [minBtn addTarget:self action:@selector(minNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:minBtn];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(minBtn.maxX, minBtn.y, WIDTH_PT(40), minBtn.height)];
    label1.textColor = [UIColor blackColor];
    label1.font = [UIFont systemFontOfSize:FONT_PT(15)];
    label1.textAlignment = NSTextAlignmentCenter;
    self.numLab = label1;
    [self.contentView addSubview:label1];
    
    UIButton *maxBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    maxBtn.frame = CGRectMake(label1.maxX, minBtn.y, WIDTH_PT(20), HEIGHT_PT(20));
    [maxBtn setImage:[UIImage imageNamed:@"icon_plus"] forState:UIControlStateNormal];
    [maxBtn addTarget:self action:@selector(maxNum:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:maxBtn];

}

- (void)minNum:(UIButton *)sender{
    
    NSInteger num = [self.numLab.text integerValue];
    if (num==0) {
        return;
    }
    num -=1;
    self.numLab.text = [NSString stringWithFormat:@"%ld",(long)num];
    self.model.menuNum = self.numLab.text;
}

- (void)maxNum:(UIButton *)sender{
    
    NSInteger num = [self.numLab.text integerValue];
    num +=1;
    self.numLab.text = [NSString stringWithFormat:@"%ld",(long)num];
    self.model.menuNum = self.numLab.text;

}



-(void)setModel:(HGWeekMenuModel *)model{
    _model = model;
    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[HGURL stringByAppendingString:model.menuUrl]] placeholderImage:[UIImage imageNamed:@"icon_default"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (error) {
            self.imageV.image = [UIImage imageNamed:@"icon_default"];
        }
    }];
    self.titleLab.text = model.menuName;
    self.numLab.text = model.menuNum;
}
//-(void)setFoodModel:(HGMenuFoodModel *)foodModel{
//    _foodModel = foodModel;
//    [self.imageV sd_setImageWithURL:[NSURL URLWithString:[HGURL stringByAppendingString:foodModel.food_pic]] placeholderImage:[UIImage imageNamed:@"icon_default"] options:SDWebImageCacheMemoryOnly completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//        if (error) {
//            self.imageV.image = [UIImage imageNamed:@"icon_default"];
//        }
//    }];
//    self.titleLab.text = foodModel.food_name;
//    self.numLab.text = foodModel.food_num;
//}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
