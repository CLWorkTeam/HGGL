//
//  HGItemDataCell.h
//  HGGL
//
//  Created by taikang on 2018/4/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HGItemDataModel.h"

@interface HGItemDataCell : UITableViewCell

@property (nonatomic,assign) NSInteger type;
@property (nonatomic,strong) HGItemDataModel *model;

@end
