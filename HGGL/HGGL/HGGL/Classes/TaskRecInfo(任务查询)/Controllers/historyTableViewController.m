//
//  historyTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "historyTableViewController.h"
#import "HistoryTableViewCell.h"
#import "History.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#import "MJExtension.h"
#import "HistoryParma.h"
#import "HGWebViewController.h"
#import "MJRefresh.h"
#import "TextFrame.h"
@interface historyTableViewController ()
@property (nonatomic,strong)NSMutableArray *arr;
//@property (nonatomic,strong) HistoryParma*parama;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation historyTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [UIColor whiteColor];
    HistoryParma *parma = [[HistoryParma alloc]init];
    parma.type = @"1";
    self.parma = parma;
    [self setRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf loadDWith:weakSelf.parma];
    }];
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parma.page integerValue ];
        weakSelf.parma.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parma];
    }];
    
}
-(void)loadDWith:(HistoryParma *)parma
{
    if (_isRefreshing) {
        
        return;
    }
    _isRefreshing = YES;
    parma.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"Reception/getReception.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parma.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool  POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        HGLog(@"%@",parma.keyValues);
        [self.tableView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        //HGLog(@"%@",[responseObject objectForKey:@"status"]);
        if ([status isEqualToString:@"1"]) {
             [self.arr removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            //HGLog(@"222%@",parma.keyValues);
            for (NSDictionary *dict in array) {
                History *his = [History initWithDict:dict];
                [self.arr addObject:his];
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
        
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        HGLog(@"%@",error);
    }];
}
-(void)loadMoreData:(HistoryParma *)parama
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getReception.do"];
    [HGHttpTool  POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        HGLog(@"%@",parama.keyValues);
        [self.tableView.mj_footer endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        //HGLog(@"%@",[responseObject objectForKey:@"status"]);
        if ([status isEqualToString:@"1"]) {
            
            NSArray *array = [responseObject objectForKey:@"data"];
            //HGLog(@"222%@",parma.keyValues);
            for (NSDictionary *dict in array) {
                History *his = [History initWithDict:dict];
                [self.arr addObject:his];
            }
            [self.tableView reloadData];
        }else
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            NSInteger i = [self.parma.page integerValue ];
            self.parma.page = [NSString stringWithFormat:@"%ld",--i];
        }
        
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.parma.page integerValue ];
        self.parma.page = [NSString stringWithFormat:@"%ld",--i];
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
    HistoryTableViewCell *cell = [HistoryTableViewCell cellWithTabView:self.tableView];
    
    cell.his = [self.arr objectAtIndex:indexPath.row];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 4*minH+5*CellHMargin;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    History *his = [self.arr objectAtIndex:indexPath.row];
    HGWebViewController *wf = [[HGWebViewController alloc]init];
    wf.navigationItem.title = @"接待确认单";
    NSString *URL = [HGURL2 stringByAppendingString:his.list_url];
    
    //HGLog(@"%@",his.list_url);
    wf.url = URL;
    if (_cellBlock) {
        _cellBlock(wf);
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
