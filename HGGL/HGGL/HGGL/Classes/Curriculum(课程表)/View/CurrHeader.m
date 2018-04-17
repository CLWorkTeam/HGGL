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
        self.backgroundColor = [UIColor blackColor];
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
    
    for (int i = 0; i<4; i++) {
//        if (i == 0) {
//            UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor ]];
//            lab.frame = CGRectMake(HGSpace, HGSpace, 40, 40);
//            [self addSubview:lab];
//            lab.text = [self.arr objectAtIndex:i];
//        }else
//        {
        UILabel *lab = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor ]];
        lab.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:lab];
        lab.text = [self.arr objectAtIndex:i];
        [self.labArr addObject:lab];
        
  //      }
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
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
@end
