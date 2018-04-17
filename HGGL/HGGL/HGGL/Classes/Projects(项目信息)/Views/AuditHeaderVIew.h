//
//  AuditHeaderVIew.h
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProjectAuditParama.h"

@interface AuditHeaderView : UIView
@property (nonatomic,weak)UISearchBar *searchBar;
@property (nonatomic,copy) void(^clickBut)(ProjectAuditParama *parama);
@property (nonatomic,copy) void (^timeBlock)(BOOL isSelected);
@property (nonatomic,strong) ProjectAuditParama *parama;
@end
