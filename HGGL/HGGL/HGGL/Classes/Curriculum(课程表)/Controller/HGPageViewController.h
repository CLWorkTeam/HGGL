//
//  HGPageViewController.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGPageViewController : UIPageViewController
@property (nonatomic,strong) NSMutableArray <UIViewController *>*controllerArray;
@property (nonatomic,copy) void(^indexChangeBlock)(NSInteger index);
-(void)changeVCWithIndex:(NSInteger )index;
@property (nonatomic,copy) void(^justChangeIndex)(NSInteger index);
@end
