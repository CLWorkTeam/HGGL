//
//  TeachCollectionViewCell.h
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrImageView;
@interface TeachCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) UIView *content;
@property (nonatomic,weak) CurrImageView *ima;
@property (nonatomic,copy) NSString *teacher_id;
@end
