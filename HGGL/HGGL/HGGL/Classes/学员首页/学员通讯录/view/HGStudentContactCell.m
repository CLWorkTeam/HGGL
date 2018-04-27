//
//  HGStudentContactCell.m
//  HGGL
//
//  Created by taikang on 2018/4/24.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStudentContactCell.h"

@interface HGStudentContactCell ()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *phoneLab;
@property (nonatomic,strong) UILabel *districtLab;//关区
@property (nonatomic,strong) UILabel *departmentLab;//部门


@end

@implementation HGStudentContactCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleGray;
        for (UIView *subview in self.contentView.subviews) {
            [subview removeFromSuperview];
        }
        [self setupSubviews];
    }
    return self;
}
- (void)setupSubviews{
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(15), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(20))];
    label.textColor = HGMainColor;
    label.font = [UIFont boldSystemFontOfSize:FONT_PT(18)];
    self.nameLabel = label;
    [self.contentView addSubview:label];
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(HGScreenWidth-WIDTH_PT(30)-WIDTH_PT(10), HEIGHT_PT(10), WIDTH_PT(30), HEIGHT_PT(30))];
    imageV.image = [UIImage imageNamed:@"icon_phone"];
    [self.contentView addSubview:imageV];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), label.y, HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label1.textColor = [UIColor colorWithHexString:@"#333333"];
    label1.font = [UIFont systemFontOfSize:FONT_PT(16)];
    self.phoneLab = label1;
    [self.contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(20), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label2.textColor = [UIColor colorWithHexString:@"#333333"];
    label2.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label2.textAlignment = NSTextAlignmentRight;
    self.districtLab = label2;
    [self.contentView addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(20), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(15))];
    label3.textColor = [UIColor colorWithHexString:@"#333333"];
    label3.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label3.textAlignment = NSTextAlignmentRight;
    self.departmentLab = label3;
    [self.contentView addSubview:label3];

    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(119), HGScreenWidth-WIDTH_PT(20), 1)];
    lineV.backgroundColor = HGColor(249, 202, 168, 1);
    [self.contentView addSubview:lineV];

}

-(void)setModel:(HGContactModel *)model{
    _model = model;
    self.nameLabel.text = model.studentName;
    [self.nameLabel sizeToFit];
    self.phoneLab.text = model.studentPhone;
    [self.phoneLab sizeToFit];
    self.phoneLab.x = self.nameLabel.maxX + WIDTH_PT(40);
//    self.districtLab.text = model.customDistrict;
//    [self.districtLab sizeToFit];
//    self.districtLab.y = self.nameLabel.maxY + 15;
//    self.departmentLab.text = model.department;
//    [self.departmentLab sizeToFit];
//    self.departmentLab.y = self.districtLab.maxY + 15;
    if (model.customDistrict.length==0) {
        self.districtLab.textColor = [UIColor grayColor];
        self.districtLab.text = @"暂无关区";
        [self.districtLab sizeToFit];
        self.districtLab.y = self.nameLabel.maxY + HEIGHT_PT(15);
    }else{
        self.districtLab.text = model.customDistrict;
        self.districtLab.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.districtLab sizeToFit];
        self.districtLab.y = self.nameLabel.maxY + HEIGHT_PT(15);
    }
    if (model.department.length==0) {
        self.departmentLab.textColor = [UIColor grayColor];
        self.departmentLab.text = @"暂无部门";
        [self.departmentLab sizeToFit];
        self.departmentLab.y = self.districtLab.maxY + HEIGHT_PT(15);
    }else{
        self.departmentLab.text = model.department;
        self.departmentLab.textColor = [UIColor colorWithHexString:@"#333333"];
        [self.departmentLab sizeToFit];
        self.departmentLab.y = self.districtLab.maxY + HEIGHT_PT(15);
    }
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
