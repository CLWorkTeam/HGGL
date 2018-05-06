//
//  HGMenteeSelCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/5.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGMenteeSelCell : UITableViewCell
//简介名称
@property (nonatomic,copy) NSString *name;
//简介内容
@property (nonatomic,copy) NSString *nameV;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
