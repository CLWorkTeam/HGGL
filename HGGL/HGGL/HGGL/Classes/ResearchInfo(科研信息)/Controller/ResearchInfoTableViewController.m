//
//  ResearchInfoTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchInfoTableViewController.h"
////#import "MBProgressHUD+Extend.h"
#import "ResearchList.h"
#import "HGHttpTool.h"
#import "ResearchInfoTableViewCell.h"
#import "ResearchDetailTableViewController.h"
#import "ResearchParama.h"
#import "MJRefresh.h"
#import "TextFrame.h"
#import "MJExtension.h"
@interface ResearchInfoTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation ResearchInfoTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationItem.title = @"科研列表";
    ResearchParama *parama = [[ResearchParama alloc]init];
    parama.user_id = [HGUserDefaults objectForKey:@"userID"];
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
-(void)loadMoreData:(ResearchParama *)parama;
{
    if (_isRefreshing) {
        return;
    }
    _isRefreshing = YES;
    HGLog(@"%@",parama.keyValues);
    NSString *url = [HGURL stringByAppendingString:@"Research/getResearchList.do"];
    HGLog(@"%@",[HGUserDefaults stringForKey:@"userID"]);
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            
            for (NSDictionary *dict in array) {
                ResearchList *rl = [ResearchList initWithDict:dict];
                [self.arr addObject:rl];
            }
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        HGLog(@"%@",error);
    }];
}
-(void)postWithParama:(ResearchParama *)parama
{
    if (_isRefreshing) {
        return;
    }
     HGLog(@"%@",parama.keyValues);
    _isRefreshing = YES;
    self.parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"Research/getResearchList.do"];
    HGLog(@"%@",[HGUserDefaults stringForKey:@"userID"]);
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
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
            [self.arr removeAllObjects];
            for (NSDictionary *dict in array) {
                ResearchList *rl = [ResearchList initWithDict:dict];
                [self.arr addObject:rl];
            }
            [self.tableView reloadData];
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
    ResearchInfoTableViewCell *cell = [ResearchInfoTableViewCell cellWithTabView:self.tableView];
    cell.RL = [self.arr objectAtIndex:indexPath.row];
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
    ResearchList *rl = [self.arr objectAtIndex:indexPath.row];
    ResearchDetailTableViewController *RD = [[ResearchDetailTableViewController alloc]init];
    RD.research_id = rl.research_id;
    //RD.RL = rl;
    if (_researchBlock) {
        _researchBlock(RD);
    }
    //[self.navigationController pushViewController:RD animated:YES];
    
    
    
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
