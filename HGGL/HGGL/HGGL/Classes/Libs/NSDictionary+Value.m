//
//  NSDictionary+Value.m
//  泰行销
//
//  Created by edz on 2017/5/22.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "NSDictionary+Value.h"

@implementation NSDictionary (Value)

- (instancetype)changeValueToString{
    
    NSMutableDictionary *result = [NSMutableDictionary dictionary];
    
    for (NSString *key in self.allKeys) {
        if ([self[key] isNull]) {
            [result setObject:@"null" forKey:key];
            continue;
        }
        id value = self[key];
        
        if ([value isKindOfClass:[NSNumber class]]) {
            [result setObject:[NSString stringWithFormat:@"%@",value] forKey:key];
        }else{
            [result setObject:value forKey:key];
        }
    }
    
    return result;
}

- (instancetype)changeSpaceStringToLine{
    
    NSMutableDictionary *result = [NSMutableDictionary dictionaryWithDictionary:self];
    
    for (NSString *key in self.allKeys) {
        if ([self[key] isEqualToString:@""]) {
            [result setObject:@"--" forKey:key];
        }
    }
    
    return result;

}

@end
