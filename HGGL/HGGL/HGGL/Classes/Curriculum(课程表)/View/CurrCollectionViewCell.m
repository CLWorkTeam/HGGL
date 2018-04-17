//
//  CurrCollectionViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrCollectionViewCell.h"
#define HGSpace 1
@interface CurrCollectionViewCell ()
@property (nonatomic,weak) UIButton *FBut;
@property (nonatomic,weak) UIButton *SBut;
@property (nonatomic,strong) NSArray *arr;
@end

@implementation CurrCollectionViewCell
-(UIButton *)FBut
{
    if (_FBut == nil) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        _FBut = but;
        _FBut.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _FBut.titleLabel.textAlignment = NSTextAlignmentLeft;
        _FBut.backgroundColor = [UIColor purpleColor];
    
        [_FBut addTarget:self action:@selector(clickFBut) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_FBut];
        
    }
    return _FBut;
}
-(UIButton *)SBut
{
    if (_SBut == nil) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        _SBut = but;
        _SBut.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
        _SBut.titleLabel.textAlignment = NSTextAlignmentLeft;
        _SBut.backgroundColor = [UIColor yellowColor];
        [_SBut addTarget:self action:@selector(clickSBut) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_SBut];
    }
    return _SBut;
}
-(void)clickFBut
{
    
}
-(void)clickSBut
{
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat height =self.bounds.size.height/2-HGSpace/2;
    self.FBut.frame = CGRectMake(0, 0, self.bounds.size.width, height);
    self.SBut.frame = CGRectMake(0, self.bounds.size.height/2+HGSpace/2, self.bounds.size.width, height);
}
@end
