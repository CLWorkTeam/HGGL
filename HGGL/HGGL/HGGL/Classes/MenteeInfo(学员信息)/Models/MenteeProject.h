//
//  MenteeProject.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MenteeProject : NSObject
//：项目名称
@property (nonatomic,copy) NSString *project_name;
//：项目开始时间
@property (nonatomic,copy) NSString *project_star;
//：项目结束时间
@property (nonatomic,copy) NSString *project_end;
//：项目课时
@property (nonatomic,copy) NSString *mentee_class;
//项目名称的height
@property (nonatomic,assign) CGFloat projectNameH;
//cell的高度
@property (nonatomic,assign) CGFloat cellH;
+(instancetype)MFWithDict:(NSDictionary *)dict;
@end
