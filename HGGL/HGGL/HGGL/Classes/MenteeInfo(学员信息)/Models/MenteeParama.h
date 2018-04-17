//
//  MenteeParama.h
//  SYDX_2
//
//  Created by Lei on 15/9/8.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenteeParama : NSObject
//：项目id（编号），默认全部
@property (nonatomic,copy)NSString *project_id;
//：模糊查询的字符串，默认为空
@property (nonatomic,copy)NSString *str;
//：学员性别，默认全部 0：男 1：女 2：全部
@property (nonatomic,copy)NSString *mentee_sex;
//：当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;
@end
