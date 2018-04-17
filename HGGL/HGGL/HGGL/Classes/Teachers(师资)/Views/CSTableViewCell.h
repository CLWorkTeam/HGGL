//
//  CSTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-27.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseScore;
@interface CSTableViewCell : UITableViewCell
@property (nonatomic,strong) CourseScore *cs;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
