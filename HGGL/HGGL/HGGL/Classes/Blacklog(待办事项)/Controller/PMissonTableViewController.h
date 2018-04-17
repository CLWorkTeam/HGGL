//
//  PMissonTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMissionParama;
@interface PMissonTableViewController : UITableViewController
@property (nonatomic,strong) PMissionParama *parama;
-(void)postWithParama:(PMissionParama *)parama;
@end
