//
//  MPTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenteeProject;
@interface MPTableViewCell : UITableViewCell
@property (nonatomic,strong) MenteeProject *MP;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
