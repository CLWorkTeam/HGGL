
//
//  ProjectAuditViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ProjectAuditViewController.h"
#import "AuditHeaderVIew.h"
#import "ProjectListParama.h"
#import "ProjectTime.h"
#import "CurrImageView.h"
#import "ProjectAuditInfoTableViewController.h"
#import "ProjectAuditParama.h"
@interface ProjectAuditViewController ()
@property (nonatomic,strong) ProjectTime *header;
@property (nonatomic,weak) CurrImageView *curr;
@property (nonatomic,weak) AuditHeaderView *top;
@property(nonatomic, strong) ProjectAuditInfoTableViewController *table;

@end

@implementation ProjectAuditViewController
-(ProjectTime *)header
{
    if (_header == nil) {
        _header = [[ProjectTime alloc]init];
        __weak typeof(self) weakSelf = self;
//        _header.popBlock = ^(NSString *start,NSString *end)
//        {
//            weakSelf.top.parama.project_start = start;
//            weakSelf.top.parama.project_end = end;
//            if (weakSelf.top.clickBut) {
//                weakSelf.top.clickBut(weakSelf.top.parama);
//            }
//        };
    }
    return _header;
}
-(ProjectAuditInfoTableViewController *)table
{
    if (_table == nil) {
        _table = [[ProjectAuditInfoTableViewController alloc] init];
        __weak typeof(self)weakSelf = self;
        _table.projectListBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _table;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"项目审批";
    self.view.backgroundColor = [UIColor whiteColor];
//    [self setupLeftNavItem];
    [self setHeader];
    [self setTableView];
    
}
-(void)setHeader
{
    AuditHeaderView *header = [[AuditHeaderView alloc]init];
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
    header.clickBut = ^(ProjectAuditParama *parama)
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
