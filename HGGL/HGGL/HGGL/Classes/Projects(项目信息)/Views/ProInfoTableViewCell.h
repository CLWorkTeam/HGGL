//
//  ProInfoTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectList;
@interface ProInfoTableViewCell : UITableViewCell
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,strong) ProjectList *pro;
@end
