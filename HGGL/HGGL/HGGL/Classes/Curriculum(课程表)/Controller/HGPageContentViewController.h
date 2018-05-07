//
//  HGPageContentViewController.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGPageContentViewController : UIViewController
@property (nonatomic,strong) NSArray *keyArray;
@property (nonatomic,strong) NSArray *ControllerArray;
@property (nonatomic,copy) void(^changePage)(NSInteger index);
@end
