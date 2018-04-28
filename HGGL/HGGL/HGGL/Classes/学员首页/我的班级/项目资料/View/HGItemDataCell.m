//
//  HGItemDataCell.m
//  HGGL
//
//  Created by taikang on 2018/4/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemDataCell.h"

@interface HGItemDataCell ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIImageView *arrowImageV;
@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation HGItemDataCell

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
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_PT(15), HEIGHT_PT(12), WIDTH_PT(20), HEIGHT_PT(20))];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV = imageV;
    [self.contentView addSubview:imageV];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX + WIDTH_PT(10),imageV.y, HGScreenWidth-imageV.maxX - WIDTH_PT(10), HEIGHT_PT(15))];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:FONT_PT(14)];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UIImageView *imageV1 =[[UIImageView alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(10), WIDTH_PT(25), HEIGHT_PT(25))];
    imageV1.image = [UIImage imageNamed:@"icon_download"];
    imageV1.maxX = HGScreenWidth-WIDTH_PT(10);
    self.arrowImageV = imageV1;
    [self.contentView addSubview:imageV1];
}

-(void)setModel:(HGItemDataModel *)model{
    _model = model;
    self.titleLab.text = model.dataName;
    [self.titleLab sizeToFit];
    self.titleLab.y = (HEIGHT_PT(44)-self.titleLab.height)/2;
    if (self.type==0) {
        self.imageV.image = [UIImage imageNamed:@"icon_courseware"];
    }else{
        self.imageV.image = [UIImage imageNamed:@"icon_video"];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
