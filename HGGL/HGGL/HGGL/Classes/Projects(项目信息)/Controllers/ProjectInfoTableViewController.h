//
//  ProjectInfoTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectListParama;
@interface ProjectInfoTableViewController : UITableViewController
@property (nonatomic,copy) void (^projectListBlock) (id vc);
@property (nonatomic,strong) ProjectListParama *parama;
//-(void)postWithParama:(ProjectListParama *)parama;
-(void)refresh;
@property (nonatomic,copy) void(^endEditBlock)();
@end
