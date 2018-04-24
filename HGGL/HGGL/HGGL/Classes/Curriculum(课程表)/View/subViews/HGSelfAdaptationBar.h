//
//  HGSelfAdaptationBar.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGSelfAdaptationBar : UIView
@property (nonatomic,assign) NSInteger minCount;//满屏幕正好铺满需要几个 最先设置
@property (nonatomic,strong) NSArray *keyArray;
@property (nonatomic,copy) void(^clickButtonBlock)(NSInteger index);//左边按钮点击事件
-(void)clickButtonWithTag:(NSInteger)tag;
-(void)clickButtonWithOutBlock:(NSInteger)tag;
@end
