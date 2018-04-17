//
//  RecTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecTableViewCell : UITableViewCell
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,copy) NSString *one;
@property (nonatomic,copy) NSString *two;
@property (nonatomic,copy) NSString *three;
@end
