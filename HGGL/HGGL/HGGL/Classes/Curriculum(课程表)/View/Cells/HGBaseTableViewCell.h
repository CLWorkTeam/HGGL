//
//  HGBaseTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGBaseTableViewCell : UITableViewCell
@property (nonatomic,copy) NSString *objID;
@property (nonatomic,assign) CGFloat maxW;
//简介名称
@property (nonatomic,copy) NSString *name;
//简介内容
@property (nonatomic,copy) NSString *nameV;
@property (nonatomic,copy) void(^clickBlock)(NSString *objID);
+(instancetype)cellWithTabView:(UITableView *)view;
@end
