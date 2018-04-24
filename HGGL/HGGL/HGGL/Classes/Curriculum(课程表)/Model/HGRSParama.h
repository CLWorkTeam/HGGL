//
//  HGRSParama.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGRSParama : NSObject
@property (nonatomic,copy) NSString *fillType;//类型  1、接站   2、送站
@property (nonatomic,copy) NSString *carInfo;//车牌号
@property (nonatomic,copy) NSString *date;//日期
@property (nonatomic,copy) NSString *classId;//班级id
@property (nonatomic,copy) NSString *page;//当前的页码，从1开始【非必填】
@property (nonatomic,copy) NSString *pageSize;//分页大小，默认每页10条【非必填】

@end
