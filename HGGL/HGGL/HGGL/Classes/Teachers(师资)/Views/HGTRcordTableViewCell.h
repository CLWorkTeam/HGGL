//
//  HGTRcordTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HGTeachRecord;
@interface HGTRcordTableViewCell : UITableViewCell
@property (nonatomic,strong) HGTeachRecord *record;
@property (nonatomic,copy) void (^scoreBlock)(id vc);
+(instancetype)cellWithTabView:(UITableView *)view;
@end
