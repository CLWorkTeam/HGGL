//
//  CurrentTableViewCell.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "ClassCountViewController.h"

@class CurrseList;
@interface CurrentTableViewCell : UITableViewCell
@property(nonatomic, strong)CurrseList *currse;
//@property(nonatomic, strong)ClassCountViewController *classVC;
//@property(strong,nonatomic)void(^btnClick)(NSInteger);

@property(nonatomic, strong)UILabel *course_classroom;
@property(nonatomic, strong)UIButton *course_classCount;
@property(nonatomic, strong)NSMutableArray *myArr;
+(instancetype)cellWithTabView:(UITableView *)view;

//-(void)buttonClick:(NSIndexPath *)indexPath;
@end
