//
//  BlacklogTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlackParama;
@interface BlacklogTableViewController : UITableViewController
@property (nonatomic,copy) void (^blackLogBlock) (id vc);
@property (nonatomic,strong) BlackParama *parama;
-(void)postWith:(BlackParama *)parama;

@end
