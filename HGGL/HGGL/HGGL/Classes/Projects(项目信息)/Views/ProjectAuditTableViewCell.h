//
//  ProjectAuditTableViewCell.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/14.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectList;

@interface ProjectAuditTableViewCell : UITableViewCell
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,strong) ProjectList *pro;
@end
