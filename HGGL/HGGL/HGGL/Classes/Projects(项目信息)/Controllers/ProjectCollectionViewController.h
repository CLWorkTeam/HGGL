//
//  ProjectCollectionViewController.h
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ProjectList;
@interface ProjectCollectionViewController : UICollectionViewController
@property (nonatomic,copy) NSString *project_id;
@property (nonatomic,copy) void(^VCChange)(NSInteger tag);
@property (nonatomic,strong) ProjectList *PL;
@property (nonatomic,strong) void (^VCBlock)(id vc);
@end
