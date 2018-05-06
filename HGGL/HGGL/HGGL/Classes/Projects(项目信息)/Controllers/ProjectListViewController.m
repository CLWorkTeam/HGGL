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
@property (nonatomic,strong) ProjectListParama *parama;
@end

@implementation ProjectListViewController
-(ProjectTime *)header
{
    if (_header == nil) {
        _header = [[ProjectTime alloc]init];
        __weak typeof(self) weakSelf = self;
        _header.parama = self.parama;
        _header.popBlock = ^(ProjectListParama *parama)
        {
            weakSelf.parama = parama;
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
        _table.parama = self.parama;
        __weak typeof(self)weakSelf = self;
        _table.projectListBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _table.endEditBlock = ^{
            
            [weakSelf.view endEditing:YES];
            
        };
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = NO;
    self.title = @"项目信息";
    self.parama = [[ProjectListParama alloc]init];
    self.parama.str = @"";
    self.parama.project_end = @"";
    self.parama.project_type = @"";
    self.parama.project_start = @"";
    self.parama.project_status = @"";
    self.parama.page = @"1";
    self.parama.pageSize = @"10";
    [self setHeader];
    [self setTableView];
//    [self setupLeftNavItem];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setHeader
{
    HeaderView *header = [[HeaderView alloc]init];
    self.top = header;
    header.parama = self.parama;
    header.frame = CGRectMake(0, HGHeaderH, HGScreenWidth, 70);
    __weak typeof(self)weakSelf = self;
    header.timeBlock = ^(BOOL isSelected){
        if (isSelected) {
            weakSelf.header.frame = CGRectMake(0,weakSelf.top.maxY , HGScreenWidth, 40);
            weakSelf.curr.frame = CGRectMake(0, weakSelf.header.maxY, HGScreenWidth, HGScreenHeight-weakSelf.header.maxY);
            [weakSelf.view addSubview:weakSelf.header];
        }else
        {
            [self.header removeFromSuperview];
            self.curr.frame = CGRectMake(0, weakSelf.top.maxY, HGScreenWidth, HGScreenHeight-weakSelf.top.maxY);
        }
        
    };
    header.clickBut = ^(ProjectListParama *parama)
    {
        weakSelf.parama = parama;
        [weakSelf.table refresh];
    };
    header.backgroundColor = HGColor(244, 244, 244,1);
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, self.top.maxY, HGScreenWidth, HGScreenHeight-self.top.maxY)];
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
