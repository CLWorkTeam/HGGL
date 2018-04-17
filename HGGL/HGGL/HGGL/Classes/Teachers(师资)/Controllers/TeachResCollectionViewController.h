//
//  TeachResCollectionViewController.h
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeachResCollectionViewController : UICollectionViewController
@property (nonatomic,copy) void(^VCChange)(NSInteger tag);
@property (nonatomic,copy) NSString *teacher_id;
@property (nonatomic,copy) void(^PushVC)(id vc);
@end
