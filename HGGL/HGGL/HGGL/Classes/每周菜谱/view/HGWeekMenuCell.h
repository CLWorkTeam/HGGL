//
//  HGWeekMenuCell.h
//  HGGL
//
//  Created by taikang on 2018/5/1.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGWeekMenuModel.h"
#import "HGMenuFoodModel.h"

@interface HGWeekMenuCell : UITableViewCell

@property (nonatomic,strong) HGWeekMenuModel *model;
//@property (nonatomic,strong) HGMenuFoodModel *foodModel;

@property (nonatomic,strong) UILabel *numLab;


@end
