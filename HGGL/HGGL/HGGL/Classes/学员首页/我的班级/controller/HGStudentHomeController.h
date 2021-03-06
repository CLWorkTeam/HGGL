//
//  HGStudentHomeController.h
//  HGGL
//
//  Created by taikang on 2018/4/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBaseController.h"

typedef void(^HGHomeBlock)(NSInteger);

@interface HGStudentHomeController :HGBaseController

@property (nonatomic,strong) NSArray *secondSectionAry;
@property (nonatomic,strong) NSArray *secondSectionColors;
@property (nonatomic,copy) HGHomeBlock block;
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,copy) NSString *project_id;


@end
