//
//  BlacklogHeader.h
//  SYDX_2
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BlackParama;
@interface BlacklogHeader : UIView
@property (nonatomic,copy) void(^butBlock)(BlackParama *parma);
@end
