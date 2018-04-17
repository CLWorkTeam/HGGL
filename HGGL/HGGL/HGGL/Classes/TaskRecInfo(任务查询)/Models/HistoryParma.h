//
//  HistoryParma.h
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HistoryParma : NSObject
@property (nonatomic,copy) NSString *type;
@property (nonatomic,copy) NSString *str;
@property (nonatomic,copy) NSString *time_come;
@property (nonatomic,copy) NSString *time_leave;
//：当前的页码，从1开始【非必填】
@property (nonatomic,copy) NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy) NSString *pageSize;
@end
