//
//  HGClassRTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGCRModel;
@interface HGClassRTableViewCell : UITableViewCell
@property (nonatomic,strong) HGCRModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
