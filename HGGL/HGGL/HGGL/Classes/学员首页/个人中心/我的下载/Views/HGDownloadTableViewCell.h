//
//  HGDownloadTableViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/5/10.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TKDownLoadModel;
@interface HGDownloadTableViewCell : UITableViewCell

@property (nonatomic,strong) TKDownLoadModel *model;
/**
 路径
 */
@property (nonatomic,strong) NSIndexPath *indexPath;
/**
 是否是编辑状态
 */
@property (nonatomic,assign) BOOL isEdit;

/**
 判断当前cell是否是选中状态
 */
@property (nonatomic,assign) BOOL isSelected;


/**
 点击编辑按钮
 */
@property (nonatomic,copy) void(^editBlock)(NSIndexPath *path,BOOL isSelected);


+(instancetype)cellWithTableview:(UITableView *)tableview with:(NSIndexPath *)path;
@end
