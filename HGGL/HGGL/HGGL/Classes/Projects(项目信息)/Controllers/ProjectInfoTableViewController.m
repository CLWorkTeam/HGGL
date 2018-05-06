//
//  ProjectInfoTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProjectInfoTableViewController.h"
#import "ProInfoTableViewCell.h"
#import "HeaderView.h"
#import "HGHttpTool.h"
//#import "ProjectList.h"
#import "HGProjectListModel.h"
#import "ProjectInfoViewController.h"
#import "ProjectListParama.h"
#import "MJRefresh.h"
#import "MJExtension.h"
#import "TextFrame.h"
@interface ProjectInfoTableViewController ()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation ProjectInfoTableViewController
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目列表";
    
    [self setRefresh];
    //self.tableView.bounces = NO;
    //topView.backgroundColor = [UIColor redColor];

    
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf loadNew];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMore];
    }];
}
-(void)refresh
{
    [self.tableView.mj_header beginRefreshing];
}
-(void)loadNew
{
    ProjectListParama *parama = self.parama;
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getProjects.do"];
    parama.page = @"1";
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.mj_keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        [self.array removeAllObjects];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{

            
            for (NSDictionary *dict in array) {
                HGProjectListModel *pro = [HGProjectListModel initWithDict:dict];
                [self.array  addObject:pro];
            }
            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}
-(void)loadMore
{
    ProjectListParama *parama = self.parama;
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getProjects.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
//        HGLog(@"%@",parama.keyValues);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            NSInteger i = [self.parama.page integerValue ];
            self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        }else{
//            NSInteger i = [self.parama.page integerValue ];
//            self.parama.page = [NSString stringWithFormat:@"%ld",++i];
            for (NSDictionary *dict in array) {
                HGProjectListModel *pro = [HGProjectListModel initWithDict:dict];
                [self.array  addObject:pro];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.parama.page integerValue ];
        self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        HGLog(@"%@",error);
    }];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    HeaderView *topView = [[HeaderView alloc]init];
//    topView.backgroundColor = [UIColor whiteColor];
//    return topView;
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 70;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    
//}
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
   ProInfoTableViewCell *cell = [ProInfoTableViewCell cellWithTabView:self.tableView];
    
    //HGLog(@"xiangmu");
    cell.pro = [self.array objectAtIndex:indexPath.row];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30*2;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectInfoViewController *vc = [[ProjectInfoViewController alloc]init];
    HGProjectListModel *model = [self.array objectAtIndex:indexPath.row];
    vc.project_id = model.project_id;
    if (_projectListBlock) {
        _projectListBlock(vc);
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_endEditBlock) {
        _endEditBlock();
    }
}
@end
