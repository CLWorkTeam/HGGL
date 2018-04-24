//
//  HGRSHeader.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGRSParama;
@interface HGRSHeader : UIView
@property (nonatomic,strong) HGRSParama *parama;
@property (nonatomic,copy) void(^clickBlock)(HGRSParama *parama);
@end
