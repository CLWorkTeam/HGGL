//
//  HGTabbar.h
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGTabbar : UIView
-(void)addButtonWith:(UITabBarItem *)item;
@property (nonatomic,copy)void(^tabBarBlock)(NSInteger selectedIndex);
@end
