//
//  historyTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HistoryParma;
@interface historyTableViewController : UITableViewController
@property (nonatomic,strong) HistoryParma *parma;
@property (nonatomic,copy) void (^cellBlock)(id vc);
-(void)loadDWith:(HistoryParma *)parma;
@end
