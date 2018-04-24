//
//  HGNoDataView.h
//  HGGL
//
//  Created by taikang on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HGNodataBlock)(void);

@interface HGNoDataView : UIView

@property (nonatomic,strong) UILabel *label;
@property (nonatomic,copy) HGNodataBlock block;

@end
