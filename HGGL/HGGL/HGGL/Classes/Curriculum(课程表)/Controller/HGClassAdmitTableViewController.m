//
//  HGClassAdmitTableViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassAdmitTableViewController.h"
#import "HGCRModel.h"
#import "HGCRParama.h"
#import "HGClassRTableViewCell.h"
#import "TextFrame.h"
#import "HGHttpTool.h"
#import "HGClassRHeader.h"
#import "HGWebViewController.h"
@interface HGClassAdmitTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,strong) HGCRParama *parama;
@end

@implementation HGClassAdmitTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return  _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = HGGrayColor;
    [self setHeader];
   
}
-(void)setHeader
{
    HGClassRHeader *header = [[HGClassRHeader alloc]init];
    WeakSelf
    header.clickBlock = ^(HGCRParama *parama) {
        
        
        weakSelf.parama = parama;
        [weakSelf.tableView.mj_header beginRefreshing];
        
    };
    header.height = 40;
    
    self.tableView.tableHeaderView = header;
    
    HGCRParama *parama = [[HGCRParama alloc]init];
    parama.page = @"1";
    parama.pageSize = @"10";
    parama.type = @"";
    parama.startTime = @"";
    parama.endTime = @"";
    self.parama = parama;
    [self setRefresh];
    header.parama = parama;
    
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock :^{
        [weakSelf loadDWith:weakSelf.parama];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [self.parama.page integerValue ];
        self.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parama];
    }];
    
    
}
-(void)loadDWith:(HGCRParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"Reception/getTeamReception.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:self.parama.mj_keyValues success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.arr removeAllObjects];
            //[MBProgressHUD SVProgressHUD showSuccessWithStatusWithStatus:[responseObject objectForKey:@"message"]];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                HGCRModel *mes = [HGCRModel initWithDict:dict];
                [self.arr addObject:mes];
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
-(void) loadMoreData:(HGCRParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    // parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"MsgPush/getMessageList.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:self.parama.mj_keyValues success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            
            //[self.arr removeAllObjects];
            //[MBProgressHUD SVProgressHUD showSuccessWithStatusWithStatus:[responseObject objectForKey:@"message"]];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                HGCRModel *mes = [HGCRModel initWithDict:dict];
                [self.arr addObject:mes];
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            NSInteger i = [self.parama.page integerValue ];
            self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        }
        
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.parama.page integerValue ];
        self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        HGLog(@"%@",error);
    }];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGClassRTableViewCell *cell = [HGClassRTableViewCell cellWithTabView:self.tableView];
    cell.model = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat imaH = [TextFrame frameOfText:@"马克思主义" With:[UIFont fontWithName:@"Helvetica-Bold" size:14] Andwidth:HGScreenWidth-CellWMargin*2].height;
    return 3*imaH +4*CellHMargin;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    HGCRModel *model = [self.arr objectAtIndex:indexPath.row];
    
    HGWebViewController *wf = [[HGWebViewController alloc]init];
    wf.navigationItem.title = @"接待确认单";
    NSString *URL = [HGURL2 stringByAppendingString:model.receptionUrl];
    wf.url = URL;
    [self.navigationController pushViewController:wf animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
