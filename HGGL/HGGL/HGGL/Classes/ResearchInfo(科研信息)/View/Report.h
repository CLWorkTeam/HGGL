//
//  Report.h
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Report : UIView
//课题名称
@property (nonatomic,copy)NSString *research_name;
////申报人
//@property (nonatomic,copy)NSString *name;

//课题ID
@property (nonatomic,copy)NSString *research_id;
//当前用户id
@property (nonatomic,copy)NSString *user_id;
@property (nonatomic,copy)void(^sureBlock)();
@end
