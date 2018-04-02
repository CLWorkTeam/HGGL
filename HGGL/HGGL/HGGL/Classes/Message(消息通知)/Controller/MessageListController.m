//
//  MessageListController.m
//  SYDX_2
//
//  Created by mac on 15-8-14.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MessageListController.h"
#import "HGHttpTool.h"
#import "SVProgressHUD.h"
#import "Message.h"
#import "MessageTableViewCell.h"
#import "TextFrame.h"
#import "MessageInfoController.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "MessageParama.h"
#import "Common.h"
#import "HGWebController.h"
#import "HGWebController.h"
#define UP 5
#define margin 8
#define labHeigh 25
#define Width 65
#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height
@interface MessageListController()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,strong) MessageParama *parama;
@end
@implementation MessageListController

-(NSMutableArray *)arr
{
    if (_arr == nil ) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"消息通知";
    UIColor *color = [UIColor whiteColor];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController.navigationBar.titleTextAttributes = dict;
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBack)];
    
    self.navigationItem.leftBarButtonItem = back;
    
    self.navigationController.navigationBar.barTintColor =HGColor(205,0,36,1);
  //  self.navigationItem.title = @"消息通知";
    MessageParama *parama = [[MessageParama alloc]init];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    parama.user_id = user_id;
    parama.type = [HGUserDefaults objectForKey:HGUserType];
    self.parama = parama;
    parama.pageSize = @"pageSize";
    [self setRefresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [MJRefreshHeader headerWithRefreshingBlock:^{
        [weakSelf loadDWith:weakSelf.parama];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [MJRefreshFooter footerWithRefreshingBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf.parama];
    }];
    
    
}
-(void)loadDWith:(MessageParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"MsgPush/getMessageList.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:self.parama.keyValues success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.arr removeAllObjects];
            //[MBProgressHUD showSuccess:[responseObject objectForKey:@"message"]];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                Message *mes = [Message initWithDict:dict];
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
-(void) loadMoreData:(MessageParama *)parama
{
    if (_isRefreshing) {
        return;
    }
   // parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"MsgPush/getMessageList.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:self.parama.keyValues success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            //[self.arr removeAllObjects];
            //[MBProgressHUD showSuccess:[responseObject objectForKey:@"message"]];
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                Message *mes = [Message initWithDict:dict];
                [self.arr addObject:mes];
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
-(void)clickBack
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
    MessageTableViewCell *cell = [MessageTableViewCell cellWithTabView:self.tableView];
    cell.mes = [self.arr objectAtIndex:indexPath.row];
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2*minH +3*CellHMargin;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    Message *mes = [self.arr objectAtIndex:indexPath.row];
    if ([mes.msg_type isEqualToString:@"2"]) {
        HGWebController *web = [[HGWebController alloc]init];
        web.url = web.url;
        web.name = mes.msg_name;
        [self.navigationController pushViewController:web animated:YES];
    }else
    {
        MessageInfoController *m = [[MessageInfoController alloc]init];
        m.msg_content = mes.msg_content;
        m.msg_name = mes.msg_name;
        m.msg_publisher = mes.msg_publisher;
        [self.navigationController pushViewController:m animated:YES];
    }
    
    
    NSString *url = [HGURL stringByAppendingString:@"/MsgPush/setRead.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"msg_id":mes.msg_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            
        }else
        {
           [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
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

