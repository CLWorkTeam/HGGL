//
//  TeachToolBar.h
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachToolBar : UIView
@property (nonatomic,strong) NSArray *arr;
-(void)clickbutWith:(NSInteger) tag;
@property (nonatomic,copy) void(^clickChange)(NSInteger page);
@end
