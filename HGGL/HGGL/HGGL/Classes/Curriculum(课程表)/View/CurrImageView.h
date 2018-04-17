//
//  CurrImageView.h
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CurrImageView : UIImageView
@property (nonatomic,strong) UIView *contentView;
+(void)dismiss;
+(instancetype)showInRect:(CGRect)rect;

@end
