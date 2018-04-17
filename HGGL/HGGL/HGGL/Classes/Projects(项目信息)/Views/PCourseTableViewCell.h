//
//  PCourseTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-8-6.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PCourse;
@interface PCourseTableViewCell : UITableViewCell
@property (nonatomic,strong) PCourse *PC;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
