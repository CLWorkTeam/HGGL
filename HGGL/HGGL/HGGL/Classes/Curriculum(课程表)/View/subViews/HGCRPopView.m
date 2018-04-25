//
//  HGCRPopView.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/24.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRPopView.h"
#import "ZKRCover.h"
#import "HGHoldTableViewCell.h"
#import "HGLable.h"
@interface HGCRPopView ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UIView *line;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *arr;
@end
@implementation HGCRPopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UILabel *titleLable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:HGMainColor];
        [self addSubview:titleLable];
        titleLable.text = @"已占用情况";
        self.titleLable = titleLable;
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = HGMainColor;
        [self addSubview:line];
        self.line = line;
        
        UITableView *tableView = [[UITableView alloc]init];
        tableView.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0);
        tableView.delegate = self;
        tableView.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:tableView];
        self.tableView = tableView;
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.titleLable.frame = CGRectMake(0, 0, self.width, 30);
    self.line.frame = CGRectMake(0, self.titleLable.maxY, self.width, 1);
    self.tableView.frame = CGRectMake(0, self.line.maxY, self.width, self.height-30-1);
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGHoldTableViewCell *cell = [HGHoldTableViewCell cellWithTabView:tableView];
    
    cell.model = self.arr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 120;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr
{
    
    ZKRCover *cover =[ZKRCover show];
    cover.dimBackGround = YES;
    cover.ZKRCoverDismiss = ^{
        [HGCRPopView disMiss];
    };
    HGCRPopView *popView = [[HGCRPopView alloc]init];
    popView.frame = rect;
    popView.arr = arr;
    [HGKeywindow addSubview:popView];
   
    return popView;
}
+(void)disMiss
{
    
    for (UIView *view in HGKeywindow.subviews) {
        if ([view isKindOfClass:self]||[view isKindOfClass:[ZKRCover class]]) {
            [view removeFromSuperview];
        }
    }
}
@end
