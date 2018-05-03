//
//  HGItemPlanCell.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemPlanCell.h"

@interface HGItemPlanCell()

@property (nonatomic,strong) UIView *backV;
@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UILabel *moneyLab;
@property (nonatomic,strong) UILabel *daysLab;
@property (nonatomic,strong) UILabel *numberLab;
@property (nonatomic,strong) UILabel *timeLab;

@end

@implementation HGItemPlanCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupSubviews];
    }
    return self;
}

- (void)setupSubviews{
    
    UIView *backV = [[UIView alloc]init];
    backV.backgroundColor = HGGrayColor;
    backV.layer.masksToBounds = YES;
    backV.layer.cornerRadius = 5;
    self.backV = backV;
    [self.contentView addSubview:backV];
    
    UILabel *titleLab = [[UILabel alloc]init];
    titleLab.textColor = HGMainColor;
    titleLab.font = [UIFont systemFontOfSize:FONT_PT(18)];
    self.titleLab = titleLab;
    [backV addSubview:titleLab];
    
    UILabel *moneyLab = [[UILabel alloc]init];
    moneyLab.textColor = [UIColor colorWithHexString:@"#666666"];
    moneyLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    self.moneyLab = moneyLab;
    [backV addSubview:moneyLab];

    UILabel *daysLab = [[UILabel alloc]init];
    daysLab.textColor = [UIColor colorWithHexString:@"#666666"];
    daysLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    self.daysLab = daysLab;
    [backV addSubview:daysLab];

    UILabel *numberLab = [[UILabel alloc]init];
    numberLab.textColor = [UIColor colorWithHexString:@"#666666"];
    numberLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    self.numberLab = numberLab;
    [backV addSubview:numberLab];

    UILabel *timeLab = [[UILabel alloc]init];
    timeLab.textColor = [UIColor colorWithHexString:@"#666666"];
    timeLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    self.timeLab = timeLab;
    [backV addSubview:timeLab];

}

-(void)setModel:(HGItemPlanModel *)model{
    _model = model;
    self.titleLab.text = [NSString stringWithFormat:@"[调训项目]%@",model.projectName];
    self.moneyLab.text = [NSString stringWithFormat:@"收费标准：%@",model.feeStandard];
    self.daysLab.text = [NSString stringWithFormat:@"天数：%@",model.days];
    self.numberLab.text = [NSString stringWithFormat:@"人数：%@",model.peopleNums];
    self.timeLab.text = [NSString stringWithFormat:@"时间：%@ - %@",model.startTime,model.endTime];
}

-(void)layoutSubviews{
    [super layoutSubviews];
    self.backV.frame = CGRectMake(WIDTH_PT(10), HEIGHT_PT(15), HGScreenWidth-WIDTH_PT(20), self.height-HEIGHT_PT(10));
    self.titleLab.frame = CGRectMake(WIDTH_PT(10), HEIGHT_PT(15), self.backV.width-WIDTH_PT(20), HEIGHT_PT(15));
    self.moneyLab.frame = CGRectMake(WIDTH_PT(10), self.titleLab.maxY+HEIGHT_PT(20), self.backV.width/3 + WIDTH_PT(30), self.titleLab.height);
    self.daysLab.frame = CGRectMake(self.moneyLab.maxX, self.moneyLab.y, self.backV.width/3-HEIGHT_PT(15), self.moneyLab.height);
    self.numberLab.frame = CGRectMake(self.daysLab.maxX, self.moneyLab.y, self.backV.width/3-HEIGHT_PT(15)-HEIGHT_PT(10), self.moneyLab.height);
    self.timeLab.frame = CGRectMake(WIDTH_PT(10), self.moneyLab.maxY+HEIGHT_PT(15), self.backV.width-WIDTH_PT(20), HEIGHT_PT(15));
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
