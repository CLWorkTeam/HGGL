//
//  MenteeListTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenteeParama;
@interface MenteeListTableViewController : UITableViewController
//-(void)postWithParame:(MenteeParama *)parama;
@property (nonatomic,strong) MenteeParama *parama;
@property (nonatomic,copy) void (^menteeBlock) (id vc);
@property (nonatomic,copy) void(^endEditBlock)();
-(void)refresh;
@end
