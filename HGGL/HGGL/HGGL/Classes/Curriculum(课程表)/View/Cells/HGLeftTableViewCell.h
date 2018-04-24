//
//  HGLeftTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGLeftTableViewCell : UITableViewCell
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,assign) BOOL isSelected;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
