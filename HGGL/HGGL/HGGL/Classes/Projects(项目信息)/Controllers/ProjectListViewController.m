//
//  ProjectListViewController.m
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProjectListViewController.h"
#import "ProjectInfoTableViewController.h"
#import "HeaderView.h"
#import "ProjectListParama.h"
#import "CurrImageView.h"
#import "ProjectTime.h"
@interface ProjectListViewController ()
@property (nonatomic,strong) ProjectInfoTableViewController *table;
@property (nonatomic,strong) ProjectTime *header;
@property (nonatomic,weak) CurrImageView *curr;
@property (nonatomic,weak) HeaderView *top;
@end

@implementation ProjectListViewController
-(ProjectTime *)header
{
    if (_header == nil) {
        _header = [[ProjectTime alloc]init];
        __weak typeof(self) weakSelf = self;
        _header.popBlock = ^(NSString *start,NSString *end)
        {
            weakSelf.top.parama.project_start = start;
            weakSelf.top.parama.project_end = end;
            if (weakSelf.top.clickBut) {
                weakSelf.top.clickBut(weakSelf.top.parama);
            }
        };
    }
    return _header;
}
-(ProjectInfoTableViewController *)table
{
    if (_table == nil) {
        _table = [[ProjectInfoTableViewController alloc]init];
        __weak typeof(self)weakSelf = self;
        _table.projectListBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"项目信息";
    
    [self setTableView];
    [self setHeader];
    [self setupLeftNavItem];
}
//设置NavItemBtn
-(void)setupLeftNavItem{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
}
//返回前一页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setHeader
{
    HeaderView *header = [[HeaderView alloc]init];
    self.top = header;
    header.frame = CGRectMake(0, 64, HGScreenWidth, 70);
    __weak typeof(self)weakSelf = self;
    header.timeBlock = ^(BOOL isSelected){
        if (isSelected) {
            self.header.frame = CGRectMake(0, 134, HGScreenWidth, 50);
            self.curr.frame = CGRectMake(0, 120+64, HGScreenWidth, HGScreenHeight-70-64);
            [self.view addSubview:self.header];
        }else
        {
            [self.header removeFromSuperview];
            self.curr.frame = CGRectMake(0, 70+64, HGScreenWidth, HGScreenHeight-70-64);
        }
        
    };
    header.clickBut = ^(ProjectListParama *parama)
    {
        weakSelf.table.parama = parama;
        [weakSelf.table postWithParama:parama];
    };
    header.backgroundColor = HGColor(244, 244, 244,1);
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, 70+64, HGScreenWidth, HGScreenHeight-70-64)];
    [self.view addSubview:table];
    _curr = table;
    table.contentView = self.table.tableView;
    
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
