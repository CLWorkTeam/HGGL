//
//  HistroyTopView.h
//  SYDX_2
//
//  Created by mac on 15-7-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HistroyTopView : UIView
//@property (nonatomic,copy) void(^typeBlock)();
@property (nonatomic,copy) void(^timeBlock)();
@property (nonatomic,copy) void(^stateBlock)();
@property (nonatomic,copy) void (^tableBlock) (id vc);
@end
