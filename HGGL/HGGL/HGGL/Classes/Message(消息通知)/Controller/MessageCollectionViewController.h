//
//  MessageCollectionViewController.h
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCollectionViewController : UICollectionViewController
@property (nonatomic,strong) NSMutableArray *arr1;
@property(nonatomic, strong) NSString *user_id;
@property (nonatomic,copy) void(^messageBlock)(NSArray *arr);

@end
