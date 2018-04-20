//
//  TKProfessionTableViewCell.h
//  泰行销
//
//  Created by 磊陈 on 2017/7/21.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TKProfessionTableViewCell : UITableViewCell

@property (nonatomic,copy) NSString *content;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
