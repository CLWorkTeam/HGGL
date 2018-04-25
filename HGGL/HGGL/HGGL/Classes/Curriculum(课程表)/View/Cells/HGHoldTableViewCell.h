//
//  HGHoldTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/24.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGHoldRMDModel;
@interface HGHoldTableViewCell : UITableViewCell
@property (nonatomic,strong) HGHoldRMDModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
