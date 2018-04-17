//
//  MenteeToolBar.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenteeToolBar : UIView
-(void)clickbutWith:(NSInteger) tag;
@property (nonatomic,copy) void(^clickChange)(NSInteger page);
@end
