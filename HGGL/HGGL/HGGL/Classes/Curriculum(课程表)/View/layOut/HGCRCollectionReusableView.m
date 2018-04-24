//
//  HGCRCollectionReusableView.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRCollectionReusableView.h"
@interface HGCRCollectionReusableView ()
@property (nonatomic,weak) UIView *backV;
@end
@implementation HGCRCollectionReusableView
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *backV = [[UIView alloc]init];
        self.backV =backV;
        backV.backgroundColor = HGGrayColor;
        [self addSubview:backV];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.backV.frame = CGRectMake(0, 0, self.width, self.height);
    self.backV.layer.masksToBounds = YES;
    self.backV.layer.cornerRadius = 5;
    
}
@end
