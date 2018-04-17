//
//  TeacherListTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class teacBaseInfo;
@interface TeacherListTableViewCell : UITableViewCell
@property (nonatomic,strong)teacBaseInfo *info;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
