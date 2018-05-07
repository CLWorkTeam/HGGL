//
//  CurrHeader.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrHeader.h"
#import "HGLable.h"
@interface CurrHeader()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSMutableArray *labArr;
@end
@implementation CurrHeader
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"教室",@"上午",@"下午",@"晚上", nil];
    }
    return _arr;
}
-(NSMutableArray *)labArr
{
    if (_labArr == nil) {
        _labArr = [NSMutableArray array];
    }
    return _labArr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = HGColor(232, 232, 232, 1);
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setIsStudent:(BOOL)isStudent
{
    _isStudent = isStudent;
    if (isStudent) {
        self.arr = [NSArray arrayWithObjects:@"课程",@"时间",@"地点", nil];
        
    }else
    {
        self.arr = [NSArray arrayWithObjects:@"教室",@"上午",@"下午",@"晚上", nil];
    }
    
    [self setUpAllSubviews];
}
-(void)setUpAllSubviews
{
    
    for (UIView *view in self.labArr) {
        [view removeFromSuperview];
    }
    [self.labArr removeAllObjects];
    for (int i = 0; i<self.arr.count; i++) {

        UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:12 Color:[UIColor blackColor ]];
        lab.backgroundColor = HGGrayColor;
        [self addSubview:lab];
        lab.text = [self.arr objectAtIndex:i];
        [self.labArr addObject:lab];
        
  //      }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (_isStudent) {
        
        CGFloat currW = (HGScreenWidth - 80-HGSpace*4)/2;
        CGFloat CurrseH = 45;
        int i = 0;
        for (UILabel *lab in self.labArr) {
            if (i == 0) {
                lab.frame = CGRectMake(HGSpace, HGSpace, currW, (CurrseH+HGSpace)-HGSpace);
            }else if (i == 1)
            {
                lab.frame = CGRectMake(HGSpace*2+currW,HGSpace, currW, CurrseH);
            }else
            {
                lab.frame = CGRectMake(HGSpace*3+2*currW, HGSpace,80 , CurrseH);
            }
            i++;
        }
        
    }else
    {
        CGFloat currW = (HGScreenWidth - 40-HGSpace*5)/3;
        int i = 0;
        for (UILabel *lab in self.labArr) {
            if (i==0) {
                lab.frame = CGRectMake(HGSpace, HGSpace, 40, 40);
            }else
            {
                lab.frame = CGRectMake(2*HGSpace+40+(currW+HGSpace)*(i-1), HGSpace, currW, 40);
            }
            i++;
        }
    }
    
}
@end
