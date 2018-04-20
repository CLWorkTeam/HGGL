//
//  NSNull+Safe.m
//  泰行销
//
//  Created by YaoJiaQi on 2017/12/15.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "NSNull+Safe.h"

@implementation NSNull (Safe)
#define pLog
#define JsonObjects @[@"",@0,@[],@{}]
- (id)forwardingTargetForSelector:(SEL)aSelector {
    for (id jsonObj in JsonObjects) {
        if ([jsonObj respondsToSelector:aSelector]) {
#ifdef pLog
            NSLog(@"NULL出现啦！这个对象应该是是_%@",[jsonObj class]);
#endif
            return jsonObj;
        }
    }
    return [super forwardingTargetForSelector:aSelector];
}
@end
