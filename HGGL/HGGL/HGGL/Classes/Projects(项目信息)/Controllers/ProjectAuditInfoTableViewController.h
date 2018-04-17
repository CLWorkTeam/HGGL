//
//  ProjectAuditInfoTableViewController.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectAuditParama;

@interface ProjectAuditInfoTableViewController : UITableViewController
@property (nonatomic,copy) void (^projectListBlock) (id vc);
//<<<<<<< .mine
//@property (nonatomic,strong) ProjectListParama *parama;
//@property (nonatomic,copy) NSString *account;
//@property (nonatomic,copy) NSString *passWord;
//-(void)postWithParama:(ProjectListParama *)parama;
//=======
@property (nonatomic,strong) ProjectAuditParama *parama;
-(void)postWithParama:(ProjectAuditParama *)parama;
//>>>>>>> .r488
@end
