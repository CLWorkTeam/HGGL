//
//  ResearchParama.h
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ResearchParama : NSObject
@property (nonatomic,copy)NSString *str;
//：课题类型，默认全部
@property (nonatomic,copy)NSString *research_type;
//：用户id【必填】
@property (nonatomic,copy)NSString *user_id;
//：当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;
@end
