//
//  TeachResTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherListParama;
@interface TeachResTableViewController : UITableViewController
@property (nonatomic,strong) TeacherListParama *parama;
@property (nonatomic,copy) void (^teacherListBlock) (id vc);
-(void)postWithParama:(TeacherListParama *)parama;

@end
