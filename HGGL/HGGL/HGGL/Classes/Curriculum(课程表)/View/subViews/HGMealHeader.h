//
//  HGMealHeader.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGMealHeader : UIView
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) void(^clickBlock)(NSString *type,NSString *date);
@end
