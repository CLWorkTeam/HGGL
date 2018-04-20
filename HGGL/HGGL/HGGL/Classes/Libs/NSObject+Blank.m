//
//  NSObject+Blank.m
//  泰行销
//
//  Created by edz on 2017/5/22.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "NSObject+Blank.h"

@implementation NSObject (Blank)

- (BOOL)isNull{
    
    if ([self isKindOfClass:[NSNull class]]) {
        
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        // 判断字符串是否为空
        if (self == nil || self == NULL ||[(NSString *)self isEqualToString:@"(null)"] || [(NSString *)self isEqualToString:@"null"] || [(NSString *)self isEqualToString:@"<null>"] || [(NSString *)self isEqualToString:@"Null"])
        {
            return YES;
        }
    }
    
    return NO;
}

@end
