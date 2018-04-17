//
//  Currse.m
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "Currse.h"
#import "CurrseList.h"
@implementation Currse
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.course_style = dict[@"course_style"];
        self.course_classroom = dict[@"course_classroom"];
        self.course_classCount = dict[@"course_classCount"];
        self.course_AM = dict[@"course_AM"];
        self.course_PM = dict[@"course_PM"];
        self.course_NT = dict[@"course_NT"];
        
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
-(void)setCourse_AM:(NSArray *)course_AM
{
    
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in course_AM) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _course_AM = arr;
    
}
-(void)setCourse_PM:(NSArray *)course_PM
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in course_PM) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _course_PM = arr;
}
-(void)setCourse_NT:(NSArray *)course_NT
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in course_NT) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _course_NT = arr;
}
@end
