//
//  HGOrderLTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGOrderModel;
@interface HGOrderLTableViewCell : UITableViewCell
@property (nonatomic,strong) HGOrderModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
