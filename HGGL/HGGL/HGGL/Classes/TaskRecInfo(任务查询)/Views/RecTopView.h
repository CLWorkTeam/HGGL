//
//  RecTopView.h
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecTopView : UIView
@property (nonatomic,copy)void(^typePicker)();
@property (nonatomic,weak) UIButton *but;
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSArray *array;
@property (nonatomic,copy) void (^tableBlock) (id vc);
@end
