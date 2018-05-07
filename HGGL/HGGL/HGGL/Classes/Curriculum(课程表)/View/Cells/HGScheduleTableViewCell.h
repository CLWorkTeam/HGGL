//
//  HGScheduleTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGScheduleModel;
@interface HGScheduleTableViewCell : UITableViewCell
@property (nonatomic,strong) HGScheduleModel *model;
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,copy) void (^currButClick)(id vc);
@property (nonatomic,copy) void (^currCellClick)(id vc);
@end
