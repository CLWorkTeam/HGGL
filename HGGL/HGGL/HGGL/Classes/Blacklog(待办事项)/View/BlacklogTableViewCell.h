//
//  BlacklogTableViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BlacklogTableViewCell : UITableViewCell
//标题
@property (nonatomic,copy) NSString *title;
//类别
@property (nonatomic,copy) NSString *type;
//发布人
@property (nonatomic,copy) NSString *autor;
+(instancetype)cellWithTableview:(UITableView *)view;
@end
