//
//  ClassShowTableViewCell.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/28.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CurrseList.h"
@interface ClassShowTableViewCell : UITableViewCell

@property(nonatomic, strong)CurrseList *currseList;
+(instancetype)cellWithTabView:(UITableView *)view;

@end
