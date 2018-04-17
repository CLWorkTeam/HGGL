//
//  HistoryTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class History;
@interface HistoryTableViewCell : UITableViewCell
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,strong) History *his;
@end
