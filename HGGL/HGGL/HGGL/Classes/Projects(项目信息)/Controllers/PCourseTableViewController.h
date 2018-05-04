//
//  PCourseTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PCourseTableViewController : UITableViewController
@property (nonatomic,copy) NSString *project_id;
-(void)showError;
@property (nonatomic,copy) void(^jumpVCBlock)(id vc);
@end
