//
//  PMissionTableViewCell.h
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class PMissionFrame;
@class PMissionParama;
@interface PMissionTableViewCell : UITableViewCell
@property (nonatomic,strong)PMissionFrame *PM;
@property (nonatomic,copy) void (^butClick) (PMissionParama *parama);
+(instancetype)cellWithTabView:(UITableView *)view;

@end
