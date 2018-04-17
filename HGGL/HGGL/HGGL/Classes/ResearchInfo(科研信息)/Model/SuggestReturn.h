//
//  SuggestReturn.h
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuggestReturn : NSObject
//：校党委终期评审意见
@property (nonatomic,copy)NSString *researchCommitteeComment;
//：专家中期评审意见
@property (nonatomic,copy)NSString *researchExpertComment;
//：科研室终期评审意见
@property (nonatomic,copy)NSString *researchDepartmentComment;
// 是否可见 1为可见，0为不可见
@property (nonatomic,copy)NSString *researchIsVisible;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
