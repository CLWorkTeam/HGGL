//
//  HGMyPointCell.h
//  HGGL
//
//  Created by taikang on 2018/4/11.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGMyPointModel.h"

@interface HGMyPointCell : UITableViewCell


@property (nonatomic,strong) CALayer *bottomLayer;
@property (nonatomic,strong) CALayer *topLayer;
@property (nonatomic,strong) HGMyPointModel *model;


@end
