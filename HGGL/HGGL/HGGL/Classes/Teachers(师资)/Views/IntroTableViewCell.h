//
//  IntroTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-21.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroTableViewCell : UITableViewCell

//简介名称
@property (nonatomic,copy) NSString *name;
//简介内容
@property (nonatomic,copy) NSString *info;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
