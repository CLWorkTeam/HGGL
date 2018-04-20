//
//  HGClassRHeader.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGCRParama;
@interface HGClassRHeader : UIView
@property (nonatomic,strong) HGCRParama *parama;
@property (nonatomic,copy) void(^clickBlock)(HGCRParama *parama);
@end
