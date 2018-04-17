
//
//  RecTopView.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "RecTopView.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "RecTableViewController.h"
#import "UIView+Frame.h"
#import "PopTableViewController.h"
#import "ImageRightBut.h"
#define magin 3
@interface RecTopView()
@property (nonatomic,weak) UIImageView *topImage;
@property (nonatomic,weak) UIImageView *midImage;
@property (nonatomic,weak) CurrImageView *bottomImage;
@property (nonatomic,strong) RecTableViewController *recTab;
@property (nonatomic,strong) PopTableViewController *popview;
@property (nonatomic,strong) NSMutableArray *labArr;
@end

@implementation RecTopView
-(NSMutableArray *)labArr
{
    if (_labArr == nil) {
        _labArr = [NSMutableArray array];
        
    }
    return _labArr;
}
-(RecTableViewController *)recTab
{
    if (_recTab == nil) {
        RecTableViewController *tabView = [[RecTableViewController alloc]init];
        tabView.cellBlock = ^(id vc)
        {
            if (_tableBlock) {
                _tableBlock(vc);
            }
        };
        _recTab = tabView;
    }
    return _recTab;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        [self setTopView];
        [self setMidView];
        [self setBottomView];
    }
    return self;
}
-(void)setType:(NSString *)type
{
    _type = type;
    [self.but setTitle:type forState:UIControlStateNormal];
}
//设置顶端的VIEW
-(void)setTopView
{
    UIImageView *topImage = [[UIImageView alloc]init];
    topImage.userInteractionEnabled = YES;
    topImage.backgroundColor = HGColor(244, 244, 244,1);
    self.topImage = topImage;
    [self addSubview:topImage];
    //设置当日的日期显示器
    UILabel *date = [[UILabel alloc]init];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy年MM月dd"];
    NSDate *todayDate = [NSDate date];
    NSString *today = [fomatter stringFromDate:todayDate];
    date.text = [NSString stringWithFormat:@"今天是%@",today];
    date.font = [UIFont systemFontOfSize:14];
    date.textAlignment = NSTextAlignmentCenter;
    date.frame = CGRectMake(0, 0, HGScreenWidth/2 - magin, 30);
    [self.topImage addSubview:date];
    //设置接待信息选择按钮
    UIButton *but = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil  ];
    [but setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [but setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut) forControlEvents:UIControlEventTouchUpInside];
    self.but = but;
    
    [self.but setTitle:@"当日餐饮" forState:UIControlStateNormal];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    [but  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.frame = CGRectMake((HGScreenWidth-2*magin)/2, 0, HGScreenWidth/2 - magin, 30);
    but.titleLabel.font = ZKRButFont;
    [self.topImage addSubview:but];
    
}
//按钮响应
-(void)clickBut
{
    self.but.selected = !self.but.selected;
    if (self.but.selected) {
        ZKRCover *cover = [ZKRCover show];
        //NSLog(@"%@",cover.subviews);
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            
            [CurrImageView  dismiss];
            self.but.selected = NO;
            self.popview = nil;
        };

        CGRect rect = CGRectMake(HGScreenWidth/2, 137, HGScreenWidth/2 - 3, 44*4);
        PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:[NSArray arrayWithObjects:@"当日餐饮",@"当日住宿",@"当日用车",@"当日教室", nil]];
        self.popview = popView;
        popView.selectedCell=^(NSString *str)
        {
            //HGLog(@"点击");
            self.type = str;
            //[self.but setTitle:str forState:UIControlStateNormal];
            if ([str isEqualToString:@"当日餐饮"]) {
                self.array = [NSArray arrayWithObjects:@"用餐人数",@"用餐时间",@"分配餐厅",@"详情", nil];
                [self.recTab dinner];
            }else if ([str isEqualToString:@"当日用车"])
            {
                self.array = [NSArray arrayWithObjects:@"司机姓名",@"车牌号码",@"出库时间",@"详情", nil];
                [self.recTab car];
            }else if ([str isEqualToString:@"当日住宿"])
            {
                self.array = [NSArray arrayWithObjects:@"姓名",@"房间号",@"客户类型",@"详情", nil];
                [self.recTab room];
                
            }else if([str isEqualToString:@"当日教室"])
            {
                self.array = [NSArray arrayWithObjects:@"教室号",@"开始时间",@"结束时间",@"详情", nil];
                [self.recTab classRoom];
            }
            
           // NSArray *arr = self.subviews;
            for (int i = 0; i<self.labArr.count; i++) {
                UILabel *lab = [self.labArr objectAtIndex:i];
                lab.text = [self.array objectAtIndex:i];
            }
            if (_typePicker) {
                _typePicker();
            }
            
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            self.but.selected = NO;
            self.popview = nil;
           
        };
    }else
    {
        [CurrImageView dismiss];
    }
}
//-(void)setArray:(NSArray *)array
//{
//    _array = array;
//    NSArray *arr = self.subviews;
//    for (int i = 0; i<arr.count; i++) {
//        UILabel *lab = [arr objectAtIndex:i];
//        lab.text = [array objectAtIndex:i];
//    }
//}
-(void)setMidView
{
    NSArray *arr =  [NSArray arrayWithObjects:@"用餐人数",@"用餐时间",@"分配餐厅",@"详情", nil];
    for (int i = 0; i<4; i++) {
        UILabel *lab = [[UILabel alloc]init];
        //lab.backgroundColor = [UIColor purpleColor];
        lab.text = [arr objectAtIndex:i];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        lab.font = [UIFont systemFontOfSize:14 ];
        [self.labArr addObject:lab];
        [self addSubview:lab];
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.topImage.frame = CGRectMake(magin, 0, self.bounds.size.width-2*magin, 30);
    self.bottomImage.frame = CGRectMake(0, 60, self.bounds.size.width, self.bounds.size.height-60-49);
    
    NSArray *arr = self.subviews;
    CGFloat y = 30;
    CGFloat w = (self.bounds.size.width)/11;
    CGFloat h = 30;
    //因为要显示的各个lable并不是一样的大小 所以要使用switch语法来对每个lable进行单独的设置
    for (int i = 1; i<arr.count; i++) {
        UILabel *lab = [arr objectAtIndex:i];
        switch (i) {
            case 1:
                lab.frame = CGRectMake(0, y, 2*w, h);
                lab.backgroundColor = HGColor(244, 244, 244,1);
                break;
            case 2:
                lab.frame = CGRectMake(2*w, y, 4*w, h);
                lab.backgroundColor = HGColor(244, 244, 244,1);
                break;
            case 3:
                lab.frame = CGRectMake(6*w, y, 4*w, h);
                lab.backgroundColor = HGColor(244, 244, 244,1);
                break;
            case 4:
                lab.frame = CGRectMake(10*w, y, w, h);
                lab.backgroundColor = HGColor(244, 244, 244,1);
                break;
            default:
                break;
        }
        
    }
}
//设置底端的tableview
-(void)setBottomView
{
    CurrImageView *bottomView = [[CurrImageView alloc]init];
    self.bottomImage = bottomView;
    [self addSubview:bottomView];
    bottomView.contentView = self.recTab.tableView;

}
@end
