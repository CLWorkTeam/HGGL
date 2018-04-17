//
//  ProjectInfoViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectList;
@interface ProjectInfoViewController : UIViewController
@property (nonatomic,copy) NSString *project_id;
@property (nonatomic,strong) ProjectList *PL;
@end
