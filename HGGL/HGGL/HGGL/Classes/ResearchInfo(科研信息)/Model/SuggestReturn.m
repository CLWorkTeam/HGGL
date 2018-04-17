//
//  SuggestReturn.m
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "SuggestReturn.h"

@implementation SuggestReturn
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.researchCommitteeComment = dict[@"researchCommitteeComment"];
        self.researchDepartmentComment = dict[@"researchDepartmentComment" ];
        self.researchExpertComment = dict[@"researchExpertComment" ];
        self.researchIsVisible = dict[@"researchIsVisible" ];
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    //HGLog(@"%@",dict);
    return [[[self alloc] init] initWithDict:dict];
}
@end
