//
//  CourseTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CourseTableViewController : UITableViewController
@property (nonatomic,copy) NSString *teacher_id;
@property (nonatomic,copy) void(^selectedRow)(id vc);
-(void)showError;
@end
