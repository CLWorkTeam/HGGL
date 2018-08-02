//
//  TKBanner.h
//  泰行销
//
//  Created by 磊陈 on 2017/4/28.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKBanner : UIView
//传入需要轮播的图片数组
@property (nonatomic,strong) NSArray *imageArr;
//点击轮播图的时候的点击事件 index 代表的是当前点击事件点击在什么地方
@property (nonatomic,copy) void(^bannerBlock)(NSInteger index);
@property (nonatomic,assign) BOOL needPageControl;//是否需要显示下方的红点
@property (nonatomic,assign) BOOL needTimer;//是否需要启用计时器
@end
