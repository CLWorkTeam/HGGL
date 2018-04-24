//
//  HGRecipSendTableViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRecipSendTableViewController.h"
#import "HGRSTableViewCell.h"
#import "TextFrame.h"
#import "HGHttpTool.h"
#import "HGRSModel.h"
#import "HGRSParama.h"
#import "HGRSHeader.h"
@interface HGRecipSendTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isReceive;
@property (nonatomic,strong) HGRSParama *parama;
//@property (nonatomic,strong) HGRSParama *Sparama;
@end

@implementation HGRecipSendTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        
        _arr = [NSMutableArray array];
        
    }
    return  _arr;
}
- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    [self setHeader];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

-(void)setHeader
{
    HGRSHeader *header = [[HGRSHeader alloc]init];
    
    WeakSelf
    
    header.clickBlock = ^(HGRSParama *parama) {
        
        
        
        weakSelf.parama = parama;
        
        [weakSelf.tableView.mj_header beginRefreshing];
        
    };
    header.height = 19.5+43+3*30;
    
    self.tableView.tableHeaderView = header;
    
    HGRSParama *parama = [[HGRSParama alloc]init];
    parama.page = @"1";
    parama.pageSize = @"10";
    parama.fillType = @"1";
    parama.carInfo = @"";
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    parama.date = [fomatter stringFromDate:[NSDate date]];
    parama.classId = @"";
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
        
        weakSelf.parama.page = [NSString stringWithFormat:@"%ld",++i];
        
        [weakSelf loadMoreData:weakSelf.parama];
        
    }];
    
    
}
-(void)loadDWith:(HGRSParama *)parama
{
    if (_isRefreshing) {
        
        return;
        
    }
//    HGRSParama *parama = [[HGRSParama alloc]init];
//    parama.page = @"1";
//    parama.pageSize = @"10";
//    parama.fillType = @"";
//    parama.carInfo = @"";
//    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
//    [fomatter setDateFormat:@"yyyy-MM-dd"];
//    parama.date = @"2018-04-20";
//    parama.classId = @"";
//    self.parama = parama;
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    parama.page = @"1";
    NSString *url = [HGURL stringByAppendingString:@"Reception/getRecList.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:self.parama.mj_keyValues success:^(id responseObject) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        [self.arr removeAllObjects];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            
            NSArray *array = [responseObject objectForKey:@"data"];
            
            for (NSDictionary *dict in array) {
                
                HGRSModel *mes = [HGRSModel initWithDict:dict];
                
                [self.arr addObject:mes];
                
            }
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
        
        [self.tableView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        
        HGLog(@"%@",error);
    }];
}
-(void) loadMoreData:(HGRSParama *)parama
{
    
    if (_isRefreshing) {
        
        return;
        
    }
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getTeamReception.do"];
    
    _isRefreshing = YES;
    
    [HGHttpTool POSTWithURL:url parameters:self.parama.mj_keyValues success:^(id responseObject) {
        _isRefreshing = NO;
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray *array = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in array) {
                HGRSModel *mes = [HGRSModel initWithDict:dict];
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
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.parama.page integerValue ];
        self.parama.page = [NSString stringWithFormat:@"%ld",--i];
        HGLog(@"%@",error);
    }];
    
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
    
    HGRSTableViewCell *cell = [HGRSTableViewCell cellWithTabView:self.tableView];
    
    cell.fillType = self.parama.fillType;
    
    cell.model = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGRSModel *model = [self.arr objectAtIndex:indexPath.row];
    return model.cellH;
   
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}


@end
