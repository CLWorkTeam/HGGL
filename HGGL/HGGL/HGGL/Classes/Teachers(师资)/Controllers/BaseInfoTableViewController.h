//
//  BaseInfoTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacBaseFrame;
@interface BaseInfoTableViewController : UITableViewController
@property (nonatomic,strong) TeacBaseFrame *teachInfo;
@property (nonatomic,copy)  NSString *teacher_id;
-(void)showError;
@end
