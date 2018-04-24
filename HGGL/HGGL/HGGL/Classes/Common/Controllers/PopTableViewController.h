//
//  PopTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PopTableViewController : UITableViewController
@property (nonatomic,copy) void(^selectedCell)(NSString *str);
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,copy) NSString *showKey;
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr;
@end
