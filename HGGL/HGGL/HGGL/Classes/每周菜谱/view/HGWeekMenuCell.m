//
//  HGWeekMenuCell.m
//  HGGL
//
//  Created by taikang on 2018/5/1.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWeekMenuCell.h"

@implementation HGWeekMenuCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setMenuModel:(HGWeekMenuModel *)menuModel{
    _menuModel = menuModel;
}
-(void)setFoodModel:(HGMenuFoodModel *)foodModel{
    _foodModel = foodModel;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
