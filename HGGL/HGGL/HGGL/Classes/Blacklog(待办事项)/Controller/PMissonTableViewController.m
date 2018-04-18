//
//  PMissonTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PMissonTableViewController.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "MissonList.h"
#import "PMissionParama.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "PMissionFrame.h"
#import "PMissionTableViewCell.h"
#import "TextFrame.h"
@interface PMissonTableViewController ()<UISearchBarDelegate>
@property (nonatomic,copy) NSString *str;
@property (nonatomic,strong) NSMutableArray *arr;
//@property (nonatomic,weak) UISearchBar *sb;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation PMissonTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的项目任务";
    PMissionParama *parama = [[PMissionParama alloc]init];
    parama.user_id = [HGUserDefaults objectForKey:HGUserID];
    self.parama = parama;

    [self setRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header  = [HGRefresh loadNewRefreshWithRefreshBlock:^{
         [weakSelf postWithParama:weakSelf.parama];
    }];
    [self.tableView.mj_header beginRefreshing];


}
//-(void)loadMoreData:(PMissionParama *)parama
//{
//    if (_isRefreshing) {
//        return;
//    }
//    _isRefreshing = YES;
//    [self.arr removeAllObjects];
//    NSString *url = [HGURL stringByAppendingString:@"Project/getTaskList.do"];
//    [HGHttpTool POSTWithURL:url parameters:parama.keyValues success:^(id responseObject) {
//        _isRefreshing = NO;
//        [self.tableView.mj_footer endRefreshing];
//        NSString *status = [responseObject objectForKey:@"status"];
//        if ([status isEqualToString:@"1"]) {
//            
//            NSArray *array = [responseObject objectForKey:@"data"];
//            for (NSDictionary *dict in array) {
//                HGLog(@"pm%@",dict);
//                MissonList *ML = [MissonList initWithDict:dict];
//                PMissionFrame *FM = [[PMissionFrame alloc]init];
//                FM.ML = ML;
//                [self.arr addObject:FM];
//            }
//            [self.tableView reloadData];
//        }else
//        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
//        }
//    } failure:^(NSError *error) {
//        _isRefreshing = NO;
//        [self.tableView.mj_footer endRefreshing];
//        HGLog(@"%@",error);
//    }];
//
//}
-(void)postWithParama:(PMissionParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    //parama.page = @"1";
    
    NSString *url = [HGURL stringByAppendingString:@"Project/getTaskList.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        HGLog(@"====%@",parama.keyValues);
        [self.tableView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.arr removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                HGLog(@"pm%@",dict);
                MissonList *ML = [MissonList initWithDict:dict];
                PMissionFrame *FM = [[PMissionFrame alloc]init];
                FM.ML = ML;

                [self.arr addObject:FM];
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

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
   
    PMissionTableViewCell *cell = [PMissionTableViewCell cellWithTabView:self.tableView];
    cell.PM = [self.arr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    __weak typeof(self) weakSelf = self;
    cell.butClick = ^(PMissionParama *parama)
    {
        [weakSelf postWithParama:parama];
    };
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    PMissionFrame *pm = [self.arr objectAtIndex:indexPath.row];
    //HGLog(@"+++%f-----%f",pm.cellH>=(2*minH+3*CellHMargin)?pm.cellH:(2*minH+CellHMargin*3),2*minH+CellHMargin);
    return pm.cellH>=(2*minH+3*CellHMargin)?pm.cellH:(2*minH+CellHMargin*3);
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
