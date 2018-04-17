//
//  ResearchInfoTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResearchParama;
@interface ResearchInfoTableViewController : UITableViewController
@property (nonatomic,copy) NSString *user_id;
@property (nonatomic,strong) ResearchParama *parama;
-(void)postWithParama:(ResearchParama *)parama;
@property (nonatomic,copy) void (^researchBlock) (id vc);
@end
