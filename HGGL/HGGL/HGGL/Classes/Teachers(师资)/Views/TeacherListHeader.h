//
//  TeacherListHeader.h
//  SYDX_2
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeacherListParama;
@interface TeacherListHeader : UIView
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,copy) void (^butClick) (TeacherListParama *parama);
@end
