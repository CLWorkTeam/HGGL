
//
//  ProjectAuditInfoTableViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ProjectAuditInfoTableViewController.h"
#import "ProInfoTableViewCell.h"
#import "AuditHeaderVIew.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "ProjectList.h"
#import "ProjectAuditViewController.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "TextFrame.h"
#import "ProjectAuditInfoTableViewController.h"
#import "ProjectAuditDetailViewController.h"

#import "HGWebViewController.h"

#import "ProjectAuditTableViewCell.h"

#import "ProjectAuditParama.h"

@interface ProjectAuditInfoTableViewController ()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation ProjectAuditInfoTableViewController

-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"项目审批";
    ProjectAuditParama *parama = [[ProjectAuditParama alloc]init];
    parama.project_type = @"";

    parama.user_id = @"1";
    parama.pageSize = @"10";
    
    self.parama = parama;
    [self setRefresh];
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf postWithParama:weakSelf.parama];
        HGLog(@"weakSelf.parama ==%@", weakSelf.parama.mj_keyValues);
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parama];
    }];
}
-(void)postWithParama:(ProjectAuditParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getApproveProjects.do"];
    parama.page = @"1";

    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.mj_keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {

        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];


        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];

        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            //            NSInteger i = [self.parama.page integerValue ];
            //            self.parama.page = [NSString stringWithFormat:@"%ld",++i];
            //            HGLog(@"%@",array);
            [self.array removeAllObjects];
            for (NSDictionary *dict in array) {
                ProjectList *pro = [ProjectList initWithDict:dict];
                [self.array  addObject:pro];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}
-(void)loadMoreData:(ProjectAuditParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getApproveProjects.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.mj_keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
                HGLog(@"%@",responseObject);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            //            NSInteger i = [self.parama.page integerValue ];
            //            self.parama.page = [NSString stringWithFormat:@"%ld",++i];
            for (NSDictionary *dict in array) {
                ProjectList *pro = [ProjectList initWithDict:dict];
                [self.array  addObject:pro];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        HGLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProjectAuditTableViewCell *cell = [ProjectAuditTableViewCell cellWithTabView:self.tableView];
    
    cell.pro = [self.array objectAtIndex:indexPath.row];
    //    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return minH*3+CellHMargin*4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ProjectAuditDetailViewController *vc = [[ProjectAuditDetailViewController alloc]init];
    HGWebViewController *vc = [[HGWebViewController alloc]init];
    
    NSString *str = @"http://42.202.133.196:8089/gjjl/Approve/approve_approveOperate.do?";
    NSString *USERNAME;
    NSString *PASSWORD;
//    if (self.account) {
//        USERNAME = self.account;
//    }else
//    {
//        USERNAME = [HGUserDefaults stringForKey:@"account"];
//    }
//    if (self.passWord) {
//        PASSWORD = self.passWord;
//    }else
//    {
//        PASSWORD = [HGUserDefaults stringForKey:@"passWord"];
//    }
    ProjectList *pl = [self.array objectAtIndex:indexPath.row];
    
    NSString *string = [NSString stringWithFormat:@"%@tokenval=%@&projectId=248&type=approve",str,[HGUserDefaults objectForKey:@"user_id"]];
    vc.url = string;
    
    
    
    
    if (_projectListBlock) {
        _projectListBlock(vc);
    }
}



@end
