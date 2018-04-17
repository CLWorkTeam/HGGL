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
////#import "MBProgressHUD+Extend.h"
#import "ProjectList.h"
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
    ProjectListParama *parama = [[ProjectListParama alloc]init];
    parama.project_type = @"";
    self.parama = parama;
    [self setRefresh];
    //self.tableView.bounces = NO;
    //topView.backgroundColor = [UIColor redColor];

    
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf postWithParama:weakSelf.parama];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parama];
    }];
}
-(void)postWithParama:(ProjectListParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getProjects.do"];
    parama.page = @"1";
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
//        HGLog(@"%@",parama.keyValues);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
//            NSInteger i = [self.parama.page integerValue ];
//            self.parama.page = [NSString stringWithFormat:@"%ld",++i];
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
-(void)loadMoreData:(ProjectListParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Project/getProjects.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
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
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
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
    return minH*3+CellHMargin*4;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectInfoViewController *vc = [[ProjectInfoViewController alloc]init];
    vc.PL = [self.array objectAtIndex:indexPath.row];
    vc.project_id = vc.PL.project_id;
    if (_projectListBlock) {
        _projectListBlock(vc);
    }
    //[self.navigationController pushViewController:vc animated:YES];
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    self.tableView.contentSize = CGSizeMake(HGScreenWidth, 100*66+49);
//}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
