//
//  HGSchoolFCModel.h
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGSchoolFCModel : NSObject

@property (nonatomic,copy) NSString *noticeId;
@property (nonatomic,copy) NSString *publisher;
@property (nonatomic,copy) NSString *releaseTimeStr;
@property (nonatomic,copy) NSString *noticeTitle;
@property (nonatomic,copy) NSString *picUrl;
@property (nonatomic,copy) NSString *noticeContent;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
