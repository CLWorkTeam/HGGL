//
//  HGRSTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGRSModel;
@interface HGRSTableViewCell : UITableViewCell
@property (nonatomic,strong) HGRSModel *model;
@property (nonatomic,strong) NSString *fillType;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
