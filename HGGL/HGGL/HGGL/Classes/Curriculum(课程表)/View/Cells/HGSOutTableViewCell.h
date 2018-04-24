//
//  HGSOutTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGSignOutModel;
@interface HGSOutTableViewCell : UITableViewCell
@property (nonatomic,strong) HGSignOutModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
