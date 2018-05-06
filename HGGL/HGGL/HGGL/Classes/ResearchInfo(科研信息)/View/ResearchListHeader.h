//
//  ResearchListHeader.h
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ResearchParama;
@interface ResearchListHeader : UIView
@property (nonatomic,weak)UISearchBar *searchBar;
@property (nonatomic,strong) ResearchParama *parama;
@property (nonatomic,copy) void(^clickBut)(ResearchParama *parama);
@end
