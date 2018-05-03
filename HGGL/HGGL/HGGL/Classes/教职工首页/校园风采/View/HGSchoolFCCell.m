//
//  HGSchoolFCCell.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSchoolFCCell.h"

@interface HGSchoolFCCell ()

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,strong) UILabel *descLab;
@property (nonatomic,strong) UILabel *timeLab;


@end

@implementation HGSchoolFCCell

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
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(10), HGScreenWidth-WIDTH_PT(20), HEIGHT_PT(80))];
    backV.backgroundColor = HGGrayGroundColor;
    backV.layer.masksToBounds = YES;
    backV.layer.cornerRadius = 5;
    [self.contentView addSubview:backV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(15), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:FONT_PT(14)];
    self.label = label;
    [backV addSubview:label];

    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(20), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label1.textColor = [UIColor grayColor];
    label1.font = [UIFont systemFontOfSize:FONT_PT(14)];
    self.descLab = label1;
    [backV addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(20), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label2.textColor = [UIColor grayColor];
    label2.font = [UIFont systemFontOfSize:FONT_PT(12)];
    label2.textAlignment = NSTextAlignmentRight;
    self.timeLab = label2;
    [backV addSubview:label2];
}

-(void)setModel:(HGSchoolFCModel *)model{
    _model = model;
    self.label.text = model.noticeTitle;
    [self.label sizeToFit];
    self.descLab.text = model.publisher;
    [self.descLab sizeToFit];
    self.descLab.maxY = HEIGHT_PT(80) - HEIGHT_PT(10);
    self.timeLab.text = model.releaseTimeStr;
    [self.timeLab sizeToFit];
    self.timeLab.maxX = HGScreenWidth - WIDTH_PT(40);
    self.timeLab.y = self.descLab.y;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
