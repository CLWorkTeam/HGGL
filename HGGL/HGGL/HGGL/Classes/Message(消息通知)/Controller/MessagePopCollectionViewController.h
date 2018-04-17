//
//  MessagePopCollectionViewController.h
//  中大院移动教学办公系统
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Role;
@interface MessagePopCollectionViewController : UICollectionViewController
//+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr;
@property (nonatomic,strong) NSArray *contaiArr;
@property (nonatomic,strong) NSMutableDictionary *cellDict;
@property (nonatomic,strong) Role *role;
@property (nonatomic,strong) NSMutableArray *cellArr;
@property (nonatomic,copy) void(^clickAll)();
-(void)selectedAll:(BOOL)isAll;
@property (nonatomic,copy) void (^collIsall)(BOOL isAll);
@end
