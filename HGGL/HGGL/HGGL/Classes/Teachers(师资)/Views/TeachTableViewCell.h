//
//  TeachTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ImageLeftBut;
@interface TeachTableViewCell : UITableViewCell
+(instancetype)cellWithTabView:(UITableView *)view;
@property (nonatomic,weak)  UIButton *name;
@property (nonatomic,weak)  UIView *myView;

//@property (nonatomic,weak) NSString *ima;

@end
