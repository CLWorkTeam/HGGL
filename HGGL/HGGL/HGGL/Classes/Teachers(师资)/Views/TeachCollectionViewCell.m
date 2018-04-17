//
//  TeachCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachCollectionViewCell.h"
#import "CurrImageView.h"
@interface TeachCollectionViewCell()

@end
@implementation TeachCollectionViewCell
-(void)setContent:(UIView *)content
{
    _content = content;
    self.ima.contentView = content;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //添加视图 为后来添加的控制器视图做铺垫
        
        CurrImageView *ima = [[CurrImageView  alloc]init];
        self.ima = ima;
        [self.contentView addSubview:ima];
        
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.ima.frame =CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
        //HGLog(@"%@",self.ima);
}

@end
