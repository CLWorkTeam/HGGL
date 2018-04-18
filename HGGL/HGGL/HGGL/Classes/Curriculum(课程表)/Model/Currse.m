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
//        self.course_style = dict[@"course_style"];
        self.classroomName = dict[@"classroomName"];
        self.classroomId = dict[@"classroomId"];
        self.morningList = dict[@"morningList"];
        self.afternoonList = dict[@"afternoonList"];
        self.nightList = dict[@"nightList"];
        NSInteger a = ((self.morningList.count>self.afternoonList.count)?self.morningList.count:self.afternoonList.count);
        NSInteger b = ((a>self.nightList.count)?a:self.nightList.count);
        if (b<=0) {
            self.course_style = @"-1";
        }else
        {
            self.course_style = [NSString stringWithFormat:@"%zd",b];
        }
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}

-(void)setMorningList:(NSArray *)morningList
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in morningList) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _morningList = arr;
}
-(void)setAfternoonList:(NSArray *)afternoonList
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in afternoonList) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _afternoonList = arr;
}


-(void)setNightList:(NSArray *)nightList
{
    NSMutableArray *arr = [NSMutableArray array];
    for (NSDictionary *dict in nightList) {
        CurrseList *CL = [CurrseList initWithDict:dict];
        [arr addObject:CL];
    }
    _nightList = arr;
}
@end
