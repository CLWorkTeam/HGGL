//
//  MessageTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Message;
@interface MessageTableViewCell : UITableViewCell
@property (nonatomic,strong) Message *mes;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
