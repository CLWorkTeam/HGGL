//
//  MenteeCollectionViewCell.h
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrImageView;
@interface MenteeCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) UIView *content;
@property (nonatomic,weak) CurrImageView *ima;

@end
