//
//  BaseTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectList;
@interface BaseTableViewController : UITableViewController
@property (nonatomic,copy) NSString *project_id;
//@property (nonatomic,strong) ProjectList *PL;
@property (nonatomic,copy) void (^butBlock)(id vc);
@end
