//
//  ZKRCover.h
//  SYDX_2
//
//  Created by mac on 15-6-10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRCover : UIView
@property (nonatomic ,copy) void(^ZKRCoverDismiss)();
@property (nonatomic ,assign) BOOL dimBackGround;
+(instancetype)show;
+(void)dismiss;
@end
