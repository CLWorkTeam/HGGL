//
//  HGTeacherMyClassCell.m
//  HGGL
//
//  Created by taikang on 2018/4/25.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTeacherMyClassCell.h"

@interface HGTeacherMyClassCell ()

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *timeLab;
@property (nonatomic,strong) UILabel *descLab;

@end


@implementation HGTeacherMyClassCell

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
    
    UIView *dotView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, 8, 8)];
    dotView.layer.masksToBounds = YES;
    dotView.layer.cornerRadius = 4;
    dotView.backgroundColor = HGMainColor;
    [self.contentView addSubview:dotView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(dotView.maxX + 5, 15, HGScreenWidth, 15)];
    label.font = [UIFont boldSystemFontOfSize:16];
    label.textAlignment = NSTextAlignmentLeft;
    label.textColor = [UIColor blackColor];
    self.titleLab = label;
    [self.contentView addSubview:label];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(label.x, label.maxY+15, HGScreenWidth, 15)];
    label1.font = [UIFont systemFontOfSize:14];
    label1.textAlignment = NSTextAlignmentLeft;
    label1.textColor = [UIColor grayColor];
    self.timeLab = label1;
    [self.contentView addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(label.x, label1.y, HGScreenWidth, 15)];
    label2.font = [UIFont systemFontOfSize:14];
    label2.textAlignment = NSTextAlignmentRight;
    label2.textColor = [UIColor grayColor];
    self.descLab = label2;
    [self.contentView addSubview:label2];

    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(10, 74, HGScreenWidth-20, 1)];
    lineV.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:lineV];
    
}

-(void)setModel:(HGTeacherMyClassModel *)model{
    _model = model;
    self.titleLab.text = model.project_name;
    self.timeLab.text = [NSString stringWithFormat:@"%@ - %@",model.project_start,model.project_end];
    self.descLab.text = model.running_status;
    [self.descLab sizeToFit];
    self.descLab.maxX = HGScreenWidth - 10;
    self.timeLab.width = self.descLab.x -10;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
