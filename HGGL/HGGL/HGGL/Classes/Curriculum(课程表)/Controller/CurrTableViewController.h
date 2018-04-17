//
//  CurrTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Date;
@interface CurrTableViewController : UITableViewController
@property (nonatomic,strong) NSArray *dateOfYear;
@property (nonatomic,copy) void(^selectCell)(Date *date);
@end
