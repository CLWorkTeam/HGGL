//
//  HGPersionCenterCell.m
//  HGGL
//
//  Created by taikang on 2018/4/24.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPersionCenterCell.h"

@interface HGPersionCenterCell ()

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UIImageView *arrowImageV;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *versionLab;

@end

@implementation HGPersionCenterCell

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
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(10, 12, 20, 20)];
    imageV.contentMode = UIViewContentModeScaleAspectFit;
    self.imageV = imageV;
    [self.contentView addSubview:imageV];
    
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(imageV.maxX + 5,imageV.y, HGScreenWidth-imageV.maxX - 10, 15)];
    label.textColor = [UIColor colorWithHexString:@"#333333"];
    label.font = [UIFont systemFontOfSize:14];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, HGScreenWidth-40, 15)];
    label1.textColor = [UIColor colorWithHexString:@"#333333"];
    label1.font = [UIFont systemFontOfSize:14];
    label1.text = @"v1.0";
    [label1 sizeToFit];
    label1.maxX = HGScreenWidth - 10;
    label1.y = (44-label1.height)/2;
    self.versionLab = label1;
    [self.contentView addSubview:label1];
    
    UIImageView *imageV1 =[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 30, 30)];
    imageV1.image = [UIImage imageNamed:@"icon_right"];
    imageV1.contentMode = UIViewContentModeScaleAspectFit;
    imageV1.maxX = HGScreenWidth-5;
    self.arrowImageV = imageV1;
    [self.contentView addSubview:imageV1];

    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 43, HGScreenWidth-20, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineV];
}

-(void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    self.titleLab.text = titleStr;
    [self.titleLab sizeToFit];
    self.titleLab.y = (44-self.titleLab.height)/2;
    if ([titleStr isEqualToString:@"版本"]) {
        self.arrowImageV.hidden = YES;
        self.versionLab.hidden = NO;
    }else{
        self.arrowImageV.hidden = NO;
        self.versionLab.hidden = YES;
    }
    self.imageV.image = [self imageWithName:titleStr];
}

- (UIImage *)imageWithName:(NSString *)name{
    NSDictionary *imageDic = @{@"版本":@"icon_version",@"个人信息及修改":@"icon_s_person",@"密码修改":@"icon_password",@"我的下载":@"icon_my_download",@"我的档案":@"icon_my_history",@"我的成绩单":@"icon_my_schedule",@"项目证书":@"icon_my_certificate",@"联系我们":@"icon_contact_us",@"退出当前账号":@"icon_exit",@"我的班级":@"icon_my_download"};
    
    return [UIImage imageNamed:imageDic[name]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
