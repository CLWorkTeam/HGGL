//
//  TeachResTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachResTableViewController.h"
#import "TeacherListTableViewCell.h"
#import "HGHttpTool.h"
#import "teacBaseInfo.h"
#import "TeacViewController.h"
////#import "MBProgressHUD+Extend.h"
#import "TeacherListHeader.h"
#import "MJRefresh.h"
#import "TeacherListParama.h"
#import "MJExtension.h"
#import "TextFrame.h"
@interface TeachResTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation TeachResTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"教师列表";
    TeacherListParama *parama = [[TeacherListParama alloc]init];
//    parama.teacher_area = @"";
    parama.teacher_type = @"";
    parama.teacher_sex = @"2";
    self.parama = parama;
    [self setRefresh];
    //self.tableView.bounces = NO;
    //topView.backgroundColor = [UIColor redColor];

     //HGLog(@"%@",self.arr);
     //HGLog(@"**%ld",self.arr.count);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf postWithParama:weakSelf.parama];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer =[HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parama];
    }];
}
-(void)postWithParama:(TeacherListParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherList.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",parama.keyValues);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            [self.arr removeAllObjects];
            for (NSDictionary *dict in array) {
                
                teacBaseInfo *info = [teacBaseInfo initWithDict:dict];
                [self.arr addObject:info];
                
            }}
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}
-(void)loadMoreData:(TeacherListParama *)parama;
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherList.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        HGLog(@"%@",parama.keyValues);
        [self.tableView.mj_footer endRefreshing];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            
            for (NSDictionary *dict in array) {
                
                teacBaseInfo *info = [teacBaseInfo initWithDict:dict];
                [self.arr addObject:info];
                
            }}
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        HGLog(@"%@",error);
    }];
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    TeacherListHeader *topView = [[TeacherListHeader alloc]init];
//    topView.backgroundColor = [UIColor whiteColor];
//    return topView;
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //HGLog(@"--%d",self.arr.count);
    return self.arr.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TeacherListTableViewCell *cell = [TeacherListTableViewCell cellWithTabView:self.tableView];
    
    cell.info = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3*minH+4*5;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeacViewController *vc = [[TeacViewController alloc]init];
    teacBaseInfo *info = [self.arr objectAtIndex:indexPath.row];
    vc.teacher_id = info.teacher_id;
    if (_teacherListBlock) {
        _teacherListBlock(vc);
    }
}
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
