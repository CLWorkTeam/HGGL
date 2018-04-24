//
//  ZKRImageview.h
//  SYDX_2
//
//  Created by Lei on 15/9/24.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZKRImageview : UIImageView
@property (nonatomic,strong) UIView *contentView;
//+(void)dismiss;
+(instancetype)showInRect:(CGRect)rect;
@end
