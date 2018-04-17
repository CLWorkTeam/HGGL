//
//  ResearchInfoTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResearchList;
@interface ResearchInfoTableViewCell : UITableViewCell
@property (nonatomic,strong) ResearchList *RL;

+(instancetype)cellWithTabView:(UITableView *)view;
@end
