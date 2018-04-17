//
//  ScoreTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ScoreList;
@interface ScoreTableViewCell : UITableViewCell
@property (nonatomic,strong) ScoreList *score;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
