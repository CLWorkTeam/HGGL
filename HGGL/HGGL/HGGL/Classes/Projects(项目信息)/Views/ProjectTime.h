//
//  ProjectTime.h
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectListParama.h"
@interface ProjectTime : UIView
@property (nonatomic,copy) void (^popBlock)(ProjectListParama *parama);
@property (nonatomic,strong) ProjectListParama *parama;
@property (nonatomic,copy) void (^cancleBlock)();
@end
