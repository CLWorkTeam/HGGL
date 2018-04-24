//
//  HGCRCollectionViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRCollectionViewCell.h"
#import "HGLable.h"
#define Hmar 5
#define WMar 5
@interface HGCRCollectionViewCell ()
@property (nonatomic,weak) UIView *BGView;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UILabel *subTitleLable;

@end
@implementation HGCRCollectionViewCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        UIView *BGView = [[UIView alloc]init];
        [self.contentView addSubview:BGView];
        self.BGView = BGView;
        
        UILabel *titleLable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGTipFont Color:[UIColor whiteColor]];
        [self.BGView  addSubview:titleLable];
        self.titleLable = titleLable;
        
        UILabel *subTitleLable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGTipFont Color:[UIColor whiteColor]];
        [self.BGView  addSubview:subTitleLable];
        self.subTitleLable = subTitleLable;
        
    }
    return self;
}
-(void)setTitleStr:(NSString *)titleStr
{
    _titleStr = titleStr;
    self.titleLable.text = titleStr;
}
-(void)setSubTitleStr:(NSString *)subTitleStr
{
    _subTitleStr = subTitleStr;
    self.subTitleLable.text = subTitleStr;
}

-(void)setBGColor:(UIColor *)BGColor
{
    _BGColor = BGColor;
    self.BGView.backgroundColor = BGColor;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat h = [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGTipFont] Andwidth:60].height;
    self.BGView.frame = self.bounds;
    self.BGView.layer.masksToBounds = YES;
    self.BGView.layer.cornerRadius = 5;
    
    self.titleLable.frame = CGRectMake(WMar, Hmar, self.width-2*WMar, h);
    self.subTitleLable.frame = CGRectMake(WMar, self.titleLable.maxY+Hmar, self.width-2*WMar, h);
    
    
}
@end
