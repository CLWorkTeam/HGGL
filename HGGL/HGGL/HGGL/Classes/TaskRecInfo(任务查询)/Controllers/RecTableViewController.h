//
//  RecTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecTableViewController : UITableViewController
-(void)classRoom;
-(void)room;
-(void)car;
-(void)dinner;
@property (nonatomic,copy) void (^cellBlock)(id vc);
@end
