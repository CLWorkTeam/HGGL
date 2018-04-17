//
//  ResearchDetailTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResearchList;
@interface ResearchDetailTableViewController : UITableViewController
@property (nonatomic,copy) NSString *research_id;
@property (nonatomic,strong) ResearchList *RL;
@end
