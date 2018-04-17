//
//  ResearchCommon.h
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, Operation) {
    //以下是枚举成员
    Operation_Report = 1,
    Operation_Cancel = 5,
    Operation_MiddleReport = 7,
    Operation_FinalReport = 8,
    Operation_DepartmentApprove = 2,
    Operation_UniversityApprove = 4,
    Operation_CommitteeApprove = 3,
    Operation_DistNOAndLevel = 6,
    Operation_FinalApprove = 9,
    Operation_ReviewApprove = 11,
    Operation_Over = 10
};
@interface ResearchCommon : NSObject

@end
