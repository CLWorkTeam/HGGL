//
//  HGPopView.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGPopView : UIView
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr selectBlock:(void(^)(NSString *str))selectBlock;
+(void)disMiss;
@end
