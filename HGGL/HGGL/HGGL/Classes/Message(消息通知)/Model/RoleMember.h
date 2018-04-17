//
//  RoleMember.h
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/27.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Memeber;
@interface RoleMember : NSObject
@property (nonatomic,strong) Memeber *m;
@property (nonatomic,copy) NSString *roleId;
@end
