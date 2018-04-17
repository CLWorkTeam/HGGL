//
//  CurrPopTableViewController.h
//  SYDX_2
//
//  Created by mac on 15-8-10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrPopTableViewController : UITableViewController
//：教室名称【必填】
@property (nonatomic,copy)NSString *course_classroom;
//:当前日期【必填】
@property (nonatomic,copy)NSString *current_date;
@property (nonatomic,copy) void(^currPPopBlock)(id vc   );
@end
