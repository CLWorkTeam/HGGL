//
//  HGCRCollectionViewCell.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGCRCollectionViewCell : UICollectionViewCell
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *subTitleStr;
@property (nonatomic,strong) UIColor *BGColor;
@end
