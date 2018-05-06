//
//  TeacherListParama.h
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TeacherListParama : NSObject
//： 模糊查询的字符串
@property (nonatomic,copy)NSString *str;
//：区范围
//@property (nonatomic,copy)NSString *teacher_area;
//：聘任类型
@property (nonatomic,copy)NSString *teacher_Type;

//：当前的页码，从1开始【非必填】
@property (nonatomic,copy)NSString *page;
//：分页大小，默认每页10条【非必填】
@property (nonatomic,copy)NSString *pageSize;
@end
