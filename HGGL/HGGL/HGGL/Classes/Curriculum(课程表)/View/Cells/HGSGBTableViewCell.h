//
//  HGSGBTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGSRBModel;
@interface HGSGBTableViewCell : UITableViewCell
@property (nonatomic,strong) HGSRBModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
