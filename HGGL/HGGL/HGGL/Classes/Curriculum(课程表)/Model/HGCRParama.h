//
//  HGCRParama.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGCRParama : NSObject
@property (nonatomic,copy) NSString *type;//项目类型，   “”、全部  1、调训  2、委托  3、集中工作    没有type类型
@property (nonatomic,copy) NSString *startTime;//开始时间（yyyy-MM-dd）
@property (nonatomic,copy) NSString *endTime;//结束时间（yyyy-MM-dd）
@property (nonatomic,copy) NSString *page ;//当前的页码，从1开始【非必填】
@property (nonatomic,copy) NSString *pageSize;//分页大小，默认每页10条【非必填】

@end
