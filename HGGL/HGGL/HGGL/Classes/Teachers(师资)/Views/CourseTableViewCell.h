//
//  CourseTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-22.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CourseFrame;
@interface CourseTableViewCell : UITableViewCell
@property (nonatomic,strong) CourseFrame *courseF;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
