//
//  CurrTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Currse;
@interface CurrTableViewCell : UITableViewCell
@property (nonatomic,strong) Currse *cu;
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,copy) NSString *current_date;
@property (nonatomic,copy) void (^currButClick)(id vc);
@property (nonatomic,copy) void (^currCellClick)(id vc);
@end
