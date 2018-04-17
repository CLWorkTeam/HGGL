//
//  CurrentTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrentTableViewController : UITableViewController
@property (nonatomic,copy) NSString *course_date;
-(void)postWith:(NSString *)date;
@property (nonatomic,copy) void(^currentBlock)(id vc);
@property (nonatomic,copy)NSString *current_date;
@end
