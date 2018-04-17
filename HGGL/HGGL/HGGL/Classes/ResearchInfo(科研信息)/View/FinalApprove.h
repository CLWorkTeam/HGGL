//
//  FinalApprove.h
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SuggestReturn;
@interface FinalApprove : UIView
@property (nonatomic,copy)NSString *research_id;
@property (nonatomic,assign) BOOL editEnable;
@property (nonatomic,strong) SuggestReturn *SR;
@property (nonatomic,copy)void(^sureBlock)();
@end
