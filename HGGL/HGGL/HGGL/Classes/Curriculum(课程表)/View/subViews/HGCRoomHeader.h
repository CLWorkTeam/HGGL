//
//  HGCRoomHeader.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGCRoomHeader : UIView
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *date;
@property (nonatomic,copy) void(^clickBlock)(NSString *type,NSString *date);
@end
