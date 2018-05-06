//
//  MListTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGMenteeModel;
@interface MListTableViewCell : UITableViewCell
@property (nonatomic,strong) HGMenteeModel *mentee;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
