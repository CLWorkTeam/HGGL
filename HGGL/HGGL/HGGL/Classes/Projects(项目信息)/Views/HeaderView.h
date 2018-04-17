//
//  HeaderView.h
//  SYDX_2
//
//  Created by mac on 15-6-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListParama.h"
@interface HeaderView : UIView
@property (nonatomic,weak)UISearchBar *searchBar;
@property (nonatomic,copy) void(^clickBut)(ProjectListParama *parama);
@property (nonatomic,copy) void (^timeBlock)(BOOL isSelected);
@property (nonatomic,strong) ProjectListParama *parama;
@end
