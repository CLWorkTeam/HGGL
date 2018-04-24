//
//  HGRSModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRSModel.h"
#import "TextFrame.h"
@implementation HGRSModel

-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        NSMutableDictionary *dictonary = [NSMutableDictionary dictionary];
        
        for (NSString *key in dict) {
            NSString *str = dict[key];
            if ([str isEqualToString:@"(null)"]||[str isEqualToString:@""]||[str isKindOfClass:[NSNull class]]) {
                
                [dictonary setObject:@"未知" forKey:key];
                
            }else
            {
                [dictonary setObject:dict[key] forKey:key];
            }
        }
        
        [self setValuesForKeysWithDictionary:dictonary];
        CGFloat H = [TextFrame frameOfText:@"哈哈" With:[UIFont systemFontOfSize:HGFont] Andwidth:100].height;
        
        CGFloat mar = 30/2-H/2;
        
        self.remarkH = [TextFrame frameOfText:dict[@"remark"] With:[UIFont systemFontOfSize:HGFont] Andwidth:HGScreenWidth-2*15].height+2*mar;
        
        self.cellH = 9*30+2;
        
    }
    
    return self;
}

+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}

@end
