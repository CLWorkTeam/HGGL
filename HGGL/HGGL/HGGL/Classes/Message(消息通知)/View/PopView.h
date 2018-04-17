//
//  PopView.h
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/26.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class MessagePopCollectionViewController;
@class Role;
@interface PopView : UIView

+(instancetype)setPopViewWith:(CGRect)rect withRole:(Role *)role andArr:(NSArray *)arr;
@property (nonatomic,strong) MessagePopCollectionViewController *popview;
@property (nonatomic,copy) void (^popBlock)(NSArray *arr,NSString *roleId);

@end
