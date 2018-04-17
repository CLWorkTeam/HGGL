//
//  BlacklogHeader.m
//  SYDX_2
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BlacklogHeader.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "PopTableViewController.h"
#import "BlackParama.h"
#import "ImageRightBut.h"
@interface BlacklogHeader()
@property (nonatomic,weak)UILabel *lab;
@property (nonatomic,weak)UIButton *but;

@property (nonatomic,strong) PopTableViewController *pop;
@end
@implementation BlacklogHeader

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setAllSubviews];
    }
    return self;
}
-(void)setAllSubviews
{
    UILabel *lab = [[UILabel alloc]init];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:15];
    lab.text = @"请选择待办事项类型";
    self.lab = lab;
    [self addSubview:lab];
    UIButton *but = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [but setTitle:@"全部" forState:UIControlStateNormal];
    
    [but setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
    //[but setBackgroundImage:[UIImage imageNamed:@"search_box"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [but setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:14];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    self.but = but;
    [self addSubview:but];
    
    
}

-(void)clickBut:(UIButton *)but
{
    but.selected = !but.selected;
    if (but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss=^{
            [CurrImageView dismiss];
            but.selected = NO;
        };
        NSArray *arr = [NSArray arrayWithObjects:@"全部",@"工作流",@"科研审批",@"公告审批",@"个人任务", nil];
        CGRect rect = CGRectMake(HGScreenWidth/2, 64+30, HGScreenWidth/2, arr.count*44);
        PopTableViewController *pop = [PopTableViewController setPopViewWith:rect And:arr];
        self.pop = pop;
        pop.selectedCell = ^(NSString *str){
            
            HGLog(@"%@",str);
            
            [but setTitle:str forState:UIControlStateNormal];
            BlackParama *parama = [[BlackParama alloc]init];
            if ([str isEqualToString:@"全部"]) {
                parama.type = @"-1";
            }else if ([str isEqualToString:@"工作流"])
            {
                parama.type = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:@"科研审批"])
            {
                parama.type = @"3";
            }else if ([str isEqualToString:@"公告审批"])
            {
                parama.type = @"4";
            }else if ([str isEqualToString:@"个人任务"])
            {
                parama.type = @"5";
            }
            
            if (_butBlock) {
                _butBlock(parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            but.selected = NO;
            self.pop = nil;
        };
        
    }else
    {
        [CurrImageView   dismiss];
    }
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.lab.frame = CGRectMake(0, 0, HGScreenWidth/2, 30);
    self.but.frame = CGRectMake(CGRectGetMaxX(self.lab.frame), 0, HGScreenWidth/2, 30);
}

@end
