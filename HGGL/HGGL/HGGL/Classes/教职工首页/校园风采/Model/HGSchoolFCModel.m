//
//  HGSchoolFCModel.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSchoolFCModel.h"

@implementation HGSchoolFCModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.noticeId = (dict[@"noticeId"]?dict[@"noticeId"]:@"");
        self.publisher = (dict[@"publisher"]?dict[@"publisher"]:@"");
        self.releaseTimeStr = (dict[@"releaseTimeStr"]?dict[@"releaseTimeStr"]:@"");
        self.noticeTitle = (dict[@"noticeTitle"]?dict[@"noticeTitle"]:@"");
//        self.noticeTitle = (dict[@"noticeTitle"]?dict[@"noticeTitle"]:@"");
        self.picUrl = (dict[@"picUrl"]?dict[@"picUrl"]:@"");
        self.noticeContent = (dict[@"noticeContent"]?dict[@"noticeContent"]:@"");
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
