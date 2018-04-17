//
//  MenteeListTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeListTableViewController.h"
#import "HGHttpTool.h"
#import "Mentee.h"
//#import "MBProgressHUD+Extend.h"
#import "MListTableViewCell.h"
#import "MenteeListHeader.h"
#import "MenteeViewController.h"
#import "MenteeParama.h"
#import "MJExtension.h"
#import "MJRefresh.h"
#import "TextFrame.h"
@interface MenteeListTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
//@property (nonatomic,strong) MenteeListHeader *header;
@property (nonatomic,assign) BOOL isrefreshing;

@end

@implementation MenteeListTableViewController
//-(MenteeListHeader *)header
//{
//    if (_header == nil) {
//        MenteeListHeader *header = [[MenteeListHeader alloc]init];
//        __weak typeof(self)weakSelf = self;
//        header.butClick = ^(MenteeParama *parama)
//        {
//            weakSelf.parama = parama;
//            [weakSelf postWithParame:weakSelf.parama];
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
    //self.navigationItem.title = @"学员列表";
//    self.header.frame = CGRectMake(0, 64, 0, 0);
//    self.tableView.contentInset = UIEdgeInsetsMake(60, 0, 0, 0);
//    [HGKeywindow addSubview:self.header];
    MenteeParama *parama = [[MenteeParama  alloc]init];
    //self.tableView.backgroundColor = [UIColor redColor];
    self.parama = parama;
    parama.page = @"1";
    //[self setRefreshWithParma:parama];
    //[self postWithParame:parama];
    [self setRefreshWithParma];
    //topView.backgroundColor = [UIColor redColor];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefreshWithParma
{
    __weak typeof(self)weakSelf = self;
    
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf postWithParame:weakSelf.parama];
    }];
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        NSInteger i = [weakSelf.parama.page integerValue ];
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        [weakSelf loadMoreData:weakSelf. parama];
    }];
    
}
////去掉UItableview headerview黏性(sticky)
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
//    CGFloat sectionHeaderHeight = 60;
//    if (scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
//        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
//    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
//        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
//    }
//}

-(void)postWithParame:(MenteeParama *)parama
{
    if (_isrefreshing) {
        return;
    }
    parama.page = @"1";
    _isrefreshing = YES;
    //[self setRefreshWithParma:parama];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isrefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        HGLog(@"array === %@", array);

        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            [self.arr removeAllObjects];
            HGLog(@"%@",parama.keyValues);
            for (NSDictionary *dict in array) {
                Mentee *mentee = [Mentee initWithDict:dict];
                [self.arr addObject:mentee];
            }
            
            
            [self.tableView reloadData];
        }
        //HGLog(@"student%d",self.arr.count);
        
    } failure:^(NSError *error) {
        _isrefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}
//-(void)loadNewData:(MenteeParama *)parama
//{
//    if (_isrefreshing) {
//        return;
//    }
//
//    
//    //[self setRefreshWithParma:parama];
//    parama.page = @"1";
//    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList.do"];
//    [HGHttpTool POSTWithURL:url parameters:parama.keyValues success:^(id responseObject) {
//        [self.tableView.mj_footer endRefreshing];
//        _isrefreshing = NO;
//        HGLog(@"%@",parama.keyValues);
//        NSArray *array = [NSArray array];
//        array = [responseObject objectForKey:@"data"];
//        NSString *status = [responseObject objectForKey:@"status"];
//        if([status isEqualToString:@"0"])
//        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
//        }else{
//            //[self.arr removeAllObjects];
//            
//            for (NSDictionary *dict in array) {
//                Mentee *mentee = [Mentee initWithDict:dict];
//                [self.arr addObject:mentee];
//            }
//            
//            
//            [self.tableView reloadData];
//        }
//        //HGLog(@"student%d",self.arr.count);
//        
//    } failure:^(NSError *error) {
//        [self.tableView.mj_footer endRefreshing];
//        _isrefreshing = NO;
//        HGLog(@"%@",error);
//    }];
//}
-(void)loadMoreData:(MenteeParama *)parama
{
    if (_isrefreshing) {
        return;
    }
    _isrefreshing = YES;
    //[self setRefreshWithParma:parama];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        _isrefreshing = NO;
        HGLog(@"%@",parama.keyValues);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            //[self.arr removeAllObjects];
            
            for (NSDictionary *dict in array) {
                Mentee *mentee = [Mentee initWithDict:dict];
                [self.arr addObject:mentee];
            }
            
            
            [self.tableView reloadData];
        }
        //HGLog(@"student%d",self.arr.count);
        
    } failure:^(NSError *error) {
        _isrefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        HGLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//
//    return self.header;
//}
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
//{
//    return 60;
//}
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
    
    MListTableViewCell *cell = [MListTableViewCell  cellWithTabView:self.tableView];
    cell.mentee = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 2*minH+3*CellHMargin;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenteeViewController *vc = [[MenteeViewController alloc]init];
    vc.mentee = [self.arr objectAtIndex:indexPath.row];
    vc.mentee_id = vc.mentee.mentee_id;
    if (_menteeBlock) {
        _menteeBlock(vc);
    }
    //[self.navigationController pushViewController:vc animated:YES];
}
-(void)dealloc
{
    
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
