//
//  HGPopView.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPopView.h"
//#import "CurrImageView.h"
#import "ZKRCover.h"
#import "TKProfessionTableViewCell.h"
@interface HGPopView () <UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,copy) NSString *showKey;
@property (nonatomic,copy)void(^popBlock)(id obj);
@end
@implementation HGPopView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
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
    self.tableView.frame = self.bounds;
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
    TKProfessionTableViewCell *cell = [TKProfessionTableViewCell cellWithTabView:tableView];
//    cell.content = [self.arr objectAtIndex:indexPath.row];
    id obj = [self.arr objectAtIndex:indexPath.row];
    if ([obj isKindOfClass:[NSString class]]) {
        
        cell.content = (NSString *)obj;
    }else
    {
        NSDictionary *dict = (NSDictionary *)obj;
        cell.content = dict[self.showKey];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (_popBlock) {
        _popBlock([self.arr objectAtIndex:indexPath.row]);
    }
    [HGPopView disMiss];
}
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr andShowKey:(NSString *)showKey selectBlock:(void(^)(id obj))selectBlock
{
    
    ZKRCover *cover =[ZKRCover show];
    cover.dimBackGround = YES;
    
    HGPopView *popView = [[HGPopView alloc]init];
    popView.frame = rect;
    popView.arr = arr;
    popView.showKey = showKey;
    [HGKeywindow addSubview:popView];
    popView.popBlock = selectBlock;
    cover.ZKRCoverDismiss = ^{
        if (popView.popBlock) {
            popView.popBlock(@"");
        }
        [HGPopView disMiss];
    };
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
