
//
//  ClassCountViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/29.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ClassCountViewController.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "ClassShowTableViewCell.h"
#import "CurrseList.h"
@interface ClassCountViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UIView *myView;
@property(nonatomic, strong)NSMutableArray *allArr;
@property(nonatomic, strong)NSMutableArray *arr11;

@end

@implementation ClassCountViewController
-(NSMutableArray *)arr11
{
    if (_arr11 == nil) {
        _arr11 = [NSMutableArray array];
    }
    return _arr11;
}
-(NSMutableArray *)allArr
{
    if (_allArr == nil) {
        _allArr = [NSMutableArray array];
    }
    return _allArr;
}
-(void)setViewRect:(CGRect)rect and:(NSMutableArray *)arr
{
    ZKRCover *cover = [ZKRCover show];
    cover.dimBackGround = YES;
    CurrImageView *curr = [CurrImageView showInRect:rect];
    UIView *myView = [[UIView alloc] init];
    myView.backgroundColor = HGColor(176, 224, 230,1);
    self.myView = myView;
    curr.contentView = myView;
    self.arr11 = arr;
    [HGKeywindow addSubview:curr];
   cover.ZKRCoverDismiss = ^()
    {
        [CurrImageView dismiss];
        [ZKRCover dismiss];
    };
    [self setSubView];
    [self setNetWorking];
}
-(void)setNetWorking
{
    for (NSDictionary *dic in self.arr11) {
        CurrseList *cu = [CurrseList initWithDict:dic];
        [self.allArr addObject:cu];
    }
    
    
}
-(void)setSubView
{
    UILabel *myLabel = [[UILabel alloc] init];
    myLabel.text = @"占用信息";
    myLabel.font = [UIFont systemFontOfSize:HGTextFont1];
    myLabel.frame = CGRectMake(10, 0, 100, 30);
    myLabel.backgroundColor = [UIColor clearColor];
    myLabel.textColor = [UIColor whiteColor];
    [self.myView addSubview:myLabel];
    
    UIButton *cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancelBtn setTitle:@"✕" forState:UIControlStateNormal];
    cancelBtn.frame = CGRectMake(HGScreenWidth-60, 0, 30, 30);
    [cancelBtn addTarget:self action:@selector(backBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.myView addSubview:cancelBtn];
    
    UITableView *myTable = [[UITableView alloc] initWithFrame:CGRectMake(5, 35, HGScreenWidth-40, 125) style:UITableViewStylePlain];
    myTable.delegate = self;
    myTable.dataSource = self;
//    myTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    myTable.bounces = NO;
    [self.myView addSubview:myTable];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.allArr.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ClassShowTableViewCell *cell = [ClassShowTableViewCell cellWithTabView:tableView];
    cell.currseList = [self.allArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 125;
}
-(void)backBtn:(UIButton *)btn
{
    [CurrImageView dismiss];
    [ZKRCover dismiss];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

