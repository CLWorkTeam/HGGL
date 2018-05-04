//
//  HGProjectBaseModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGProjectBaseModel.h"
#import "HGPBRemarkModel.h"
@implementation HGProjectBaseModel
-(NSMutableArray *)contentArray{
    if (_contentArray == nil) {
        _contentArray = [NSMutableArray array];
    }
    return _contentArray;
}
-(NSMutableArray *)remarkArray{
    
    if (_remarkArray == nil) {
        _remarkArray = [NSMutableArray array];
    }
    return _remarkArray;
}
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    [self creatArray];
    for (NSDictionary *dict in self.remarkList) {
        HGPBRemarkModel *model = [HGPBRemarkModel initWithDict:dict];
        [self.remarkArray addObject:model];
    }
    return self;
}
-(void)creatArray
{
    [self.contentArray addObjectsFromArray:@[self.project_serial_num,self.project_name,[NSString stringWithFormat:@"%@-%@",self.project_start,self.project_end],[NSString stringWithFormat:@"%@-%@",self.project_apply_start,self.project_apply_end],self.project_days,self.project_people_num,self.project_fee,self.project_room,self.project_type,self.project_department,self.project_level,self.project_entrust_company,self.entrust_contact,self.entrust_contact_phone,self.project_contact,self.contact_phone,self.course_contact,self.project_teacher,@""]];
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
@end
