//
//  MenteeListHeader.h
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MenteeParama;
@interface MenteeListHeader : UIView
@property (nonatomic,copy) void (^butClick) (MenteeParama *parma);
@end
