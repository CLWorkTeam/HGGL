//
//  MenteeListTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeListTableViewController.h"
#import "HGHttpTool.h"
#import "HGMenteeModel.h"
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


-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];

    MenteeParama *parama = [[MenteeParama  alloc]init];
    self.parama = parama;
    parama.page = @"1";
    
    [self setRefreshWithParma];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setRefreshWithParma
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
    if (_isrefreshing) {
        return;
    }
    MenteeParama *parama = self.parama;
    parama.page = @"1";
    _isrefreshing = YES;
    //[self setRefreshWithParma:parama];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList2.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.mj_keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        _isrefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        [self.arr removeAllObjects];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        HGLog(@"array === %@", array);

        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            
            HGLog(@"%@",parama.mj_keyValues);
            for (NSDictionary *dict in array) {
                HGMenteeModel *mentee = [HGMenteeModel initWithDict:dict];
                [self.arr addObject:mentee];
            }
            
            
            
        }
        //HGLog(@"student%d",self.arr.count);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        _isrefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        HGLog(@"%@",error);
    }];
}

-(void)loadMore
{
    if (_isrefreshing) {
        return;
    }
    MenteeParama *parama = self.parama;
    _isrefreshing = YES;
    //[self setRefreshWithParma:parama];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList2.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:parama.mj_keyValues];
    [par setValue:user_id forKey:@"tokenval"];
    [HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        [self.tableView.mj_footer endRefreshing];
        _isrefreshing = NO;
        HGLog(@"%@",parama.mj_keyValues);
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            NSInteger i = [self.parama.page integerValue ];
            self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        }else{
            //[self.arr removeAllObjects];
            
            for (NSDictionary *dict in array) {
                HGMenteeModel *mentee = [HGMenteeModel initWithDict:dict];
                [self.arr addObject:mentee];
            }
            
            
            [self.tableView reloadData];
        }
        //HGLog(@"student%d",self.arr.count);
        
    } failure:^(NSError *error) {
        _isrefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.parama.page integerValue ];
        self.parama.page = [NSString stringWithFormat:@"%ld",--i];
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
    
    MListTableViewCell *cell = [MListTableViewCell  cellWithTabView:self.tableView];
    cell.mentee = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 110;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenteeViewController *vc = [[MenteeViewController alloc]init];
    HGMenteeModel *model = [self.arr objectAtIndex:indexPath.row];
    vc.mentee_id = model.mentee_id;
    if (_menteeBlock) {
        _menteeBlock(vc);
    }
    //[self.navigationController pushViewController:vc animated:YES];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (_endEditBlock) {
        _endEditBlock();
    }
}


@end
