//
//  HisTime.h
//  SYDX_2
//
//  Created by mac on 15-8-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HisTime : UIView
@property (nonatomic,copy) void (^popBlock)(NSString *time);
@property (nonatomic,copy) NSString *name;
@property (nonatomic,copy) void (^cancleBlock)();
@end
