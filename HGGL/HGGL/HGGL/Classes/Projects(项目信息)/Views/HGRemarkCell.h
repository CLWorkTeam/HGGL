//
//  HGRemarkCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/4.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HGPBRemarkModel.h"
@interface HGRemarkCell : UITableViewCell
@property (nonatomic,strong) HGPBRemarkModel *model;
@property (nonatomic,assign) BOOL isFirst;
+(instancetype)cellWithTabView:(UITableView *)view;
@end
