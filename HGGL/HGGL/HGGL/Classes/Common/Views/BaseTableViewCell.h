//
//  BaseTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-6-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//@class TeacBaseFrame;
@interface BaseTableViewCell : UITableViewCell
//简介名称
@property (nonatomic,copy) NSString *name;
//简介内容
@property (nonatomic,copy) NSString *nameV;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
