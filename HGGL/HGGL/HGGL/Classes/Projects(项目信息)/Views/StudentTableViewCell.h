//
//  StudentTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenteeList;
@interface StudentTableViewCell : UITableViewCell
@property (nonatomic,strong) MenteeList *men;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
