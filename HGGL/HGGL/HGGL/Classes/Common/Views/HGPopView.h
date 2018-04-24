//
//  HGPopView.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGPopView : UIView
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr andShowKey:(NSString *)showKey selectBlock:(void(^)(id obj))selectBlock;

+(void)disMiss;
@end
