//
//  StudentTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGMenteeModel;
@interface StudentTableViewCell : UITableViewCell
@property (nonatomic,strong) HGMenteeModel *men;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
