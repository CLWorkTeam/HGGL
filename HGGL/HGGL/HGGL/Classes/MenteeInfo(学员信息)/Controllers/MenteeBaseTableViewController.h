//
//  MenteeBaseTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Mentee;
@interface MenteeBaseTableViewController : UITableViewController
//@property (nonatomic,strong) Mentee *mentee;
@property (nonatomic,copy) NSString  *mentee_id;
@property (nonatomic,strong) void (^PushBlock)(id vc);
@end
