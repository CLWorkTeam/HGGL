//
//  BlacklogTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BlacklogTableViewController.h"
#import "BlacklogTableViewCell.h"
//#import "BlacklogHeader.h"
#import "HGHttpTool.h"
#import "BlackLog.h"
#import "BLackLogCommon.h"
////#import "MBProgressHUD+Extend.h"
#import "HGWebViewController.h"
#import "ResearchDetailTableViewController.h"
#import "PMissonTableViewController.h"
#import "MJExtension.h"
#import "BlackParama.h"
#import "MJRefresh.h"
#import "TextFrame.h"
@interface BlacklogTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;

@property (nonatomic,assign) BOOL isRefreshing;
//@property (nonatomic,strong) BlacklogHeader *header;
@end

@implementation BlacklogTableViewController
//-(BlacklogHeader *)header
//{
//    if (_header == nil) {
//        BlacklogHeader *header = [[BlacklogHeader alloc]initWithFrame:CGRectMake(0, 0, self.tableView.width, 30)];
//        __weak typeof (self) weakSelf = self;
//        header.butBlock = ^(BlackParama *parama)
//        {
//            [weakSelf postWith:parama];
//        };
//        header.backgroundColor = [UIColor whiteColor];
//        _header = header;
//    }
//    return _header;
//}
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.navigationController.navigationBarHidden = YES;
    //self.tableView.y-=64;
    //self.tableView.bounces = NO;
    
//    self.header.frame = CGRectMake(0, 64, HGScreenWidth, 30);
//    self.header.backgroundColor = [UIColor redColor];
//    
//    [HGKeywindow addSubview:self.header];
//    self.tableView.contentInset = UIEdgeInsetsMake(30, 0, 0, 0);
    BlackParama *parama = [[BlackParama alloc]init];
    parama.type = @"-1";
    self.parama = parama;
    //[self postWith:parama];
    [self setreFresh];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setreFresh
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf postWith:weakSelf.parama];
    }];
    [self.tableView.mj_header beginRefreshing];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)postWith:(BlackParama *)parama
{
    if (_isRefreshing) {
        return;
    }
    parama.user_id = [HGUserDefaults objectForKey:HGUserID];
    _isRefreshing = YES;
//    HGLog(@"%@",parama.keyValues);
    NSString *url = [HGURL stringByAppendingString:@"MsgPush/getBacklogList.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.arr removeAllObjects];
            NSArray *array = [responseObject objectForKey:@"data"];
            //HGLog(@"222%@",array);
            for (NSDictionary *dict in array) {
                BlackLog *BL = [BlackLog initWithDict:dict];
//                HGLog(@"%@",parama.keyValues);
                [self.arr addObject:BL];
            }
            
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
    }];
}
#pragma mark - Table view data source
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return self.header;
//    
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 30;
//}
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
    BlacklogTableViewCell *cell = [BlacklogTableViewCell cellWithTableview:self.tableView];
     cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    BlackLog *BL = [self.arr  objectAtIndex:indexPath.row];
    cell.type = BL.backlog_type;
    cell.title = BL.backlog_name;
    cell.autor = BL.backlog_publisher;
    
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 3*minH+4*CellHMargin;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    BlackLog *BL = [self.arr objectAtIndex:indexPath.row];
    switch ([BL.backlog_type integerValue]) {
        case WorkFlow:
        {
            HGWebViewController *workF = [[HGWebViewController alloc] init];
            workF.title = @"工作流";
            
            NSString *str = [HGURL3 stringByAppendingString:@"/t9/t9/mobile/act/T9PdaLogin/login.act?"];
            NSString *USERNAME = [HGUserDefaults stringForKey:@"account1"];
            NSString *PASSWORD = [HGUserDefaults stringForKey:@"passWord1"];
            NSString *string = [NSString stringWithFormat:@"%@USERNAME=%@&PASSWORD=%@&TYPE=workflow",str,USERNAME,PASSWORD];
            workF.url = string;
            //HGLog(@"11®%@",BL.backlog_content);
            if (_blackLogBlock) {
                _blackLogBlock(workF);
                [workF.navigationController setNavigationBarHidden:YES];
            }
            //[self.navigationController  pushViewController:workF animated:YES];
            
            
        }
            
            break;
        case Research:
        {
            ResearchDetailTableViewController *RD = [[ResearchDetailTableViewController alloc]init];
            RD.research_id = BL.backlog_id;
            if (_blackLogBlock) {
                _blackLogBlock(RD);
            }
            //[self.navigationController pushViewController:RD animated:YES];
        }
            break;
        case Report:
//            [MBProgressHUD showMessage:@"请到PC端进行相关操作"];
            [SVProgressHUD showInfoWithStatus:@"请到PC端进行相关操作"];
            break;
        case Misson:
        {
            PMissonTableViewController *pm = [[PMissonTableViewController  alloc]init];
            if (_blackLogBlock) {
                _blackLogBlock(pm);
            }
            //[self.navigationController pushViewController:pm animated:YES];
        }
            break;
        default:
            break;
    }
}
//-(void)dealloc
//{
//    HGLog(@"dealloc");
//    for (UIView *view in HGKeywindow.subviews) {
//        if ([view isKindOfClass:[self.header class]]) {
//            [view removeFromSuperview];
//        }
//    }
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
