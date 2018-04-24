//
//  HGMealViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMealViewController.h"
#import "HGMealHeader.h"
#import "HGSignOutModel.h"
#import "HGOrderModel.h"
#import "HGLable.h"
#import "HGLeftTableViewCell.h"
#import "HGSOutTableViewCell.h"
#import "HGOrderLTableViewCell.h"
@interface HGMealViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,weak) UITableView *leftTable;
@property (nonatomic,weak) UITableView *righTable;
@property (nonatomic,strong) NSMutableArray *signOutArray;
@property (nonatomic,strong) NSMutableArray *orderArray;
@property (nonatomic,weak) UIView *header;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,copy) NSString *course_date;
@property (nonatomic,copy) NSString *type; // 1、早餐 2、午餐  3.、晚餐
@property (nonatomic,assign) NSInteger pageIndex; //0、餐饮签退 1、餐饮订单
@property (nonatomic,assign) NSInteger realNum;//实际用餐人数
@end

@implementation HGMealViewController
-(NSMutableArray *)signOutArray
{
    if (_signOutArray == nil) {
        _signOutArray = [NSMutableArray array];
    }
    return _signOutArray;
}
-(NSMutableArray *)orderArray
{
    if (_orderArray == nil) {
        _orderArray = [NSMutableArray array];
    }
    return _orderArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.view.backgroundColor = [UIColor yellowColor];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    self.course_date = [fomatter stringFromDate:[NSDate date]];
    self.type = @"1";
    
    [self setHeader];
    
    [self setLeftTable];
    
    [self setRightLable];
    
    // Do any additional setup after loading the view.
}
-(void)setHeader
{
    HGMealHeader *header = [[HGMealHeader alloc]init];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    header.date = [fomatter stringFromDate:[NSDate date]];
    header.type = @"1";
    WeakSelf
    header.clickBlock = ^(NSString *type, NSString *date) {
        
        weakSelf.type = type;
        
        weakSelf.course_date = date;
        
        [weakSelf.righTable.mj_header beginRefreshing];
        
    };
    header.frame = CGRectMake(0, 0, self.view.width, 43+30);
    self.header = header;
    [self.view addSubview:header];
}
-(void)setLeftTable
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 300;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableView.backgroundColor = HGGrayColor;
    [self.view addSubview:tableView];
    self.leftTable = tableView;
    tableView.frame = CGRectMake(0, 0, 100, self.view.height);
}
-(void)setRightLable
{
    UITableView *tableView = [[UITableView alloc]init];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.tag = 301;
//    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.view.backgroundColor =HGGrayColor;
    
    tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:tableView];
    self.righTable = tableView;
    tableView.frame = CGRectMake(self.leftTable.maxX, 0, self.view.width-self.leftTable.width, self.view.height);
    __weak typeof(self)weakSelf = self;
    tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock :^{
        [weakSelf loadData];
    }];
    
    
    [tableView.mj_header beginRefreshing];
    
    
}

-(void)loadData
{
    if (_isRefreshing) {
        
        return;
        
    }
    
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *url = [HGURL stringByAppendingString:self.pageIndex?@"Banner/getDishOrderList.do":@"Banner/getStuSignOutInfo.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:@{@"time":self.course_date,@"type":self.type} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.righTable.mj_header endRefreshing];
        [self.orderArray removeAllObjects];
        [self.signOutArray removeAllObjects];
        NSString *status = [responseObject objectForKey:@"status"];
        
        if ([status isEqualToString:@"1"]) {
            
            
            if (self.pageIndex) {
                
                
                NSArray *arr = [responseObject objectForKey:@"data"];
                for (NSDictionary *dict in arr) {
                    HGOrderModel *model = [HGOrderModel initWithDict:dict];
                    [self.orderArray addObject:model];
                }
                
            }else
            {
                
                self.realNum = -1;
                NSDictionary *dictionary = [responseObject objectForKey:@"data"];
                self.realNum = [dictionary[@"totalNum"] integerValue];
                NSArray *arr = dictionary[@"signOutList"];
                for (NSDictionary *dict in arr) {
                    HGSignOutModel *model = [HGSignOutModel initWithDict:dict];
                    [self.signOutArray addObject:model];
                }
            }
            
            
            

            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
        [self.righTable reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        //        [self.collectionView.mj_header endRefreshing];
        
        HGLog(@"%@",error);
    }];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.leftTable.frame = CGRectMake(0, self.header.maxY+10, 100, self.view.height-self.header.height-10);
    self.righTable.frame = CGRectMake(self.leftTable.maxX, self.leftTable.y, self.view.width-self.leftTable.width, self.leftTable.height);
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    if (tableView.tag == 300) {
        return 2;
    }else
    {
        if (self.pageIndex) {
            return self.orderArray.count;
        }
        return self.signOutArray.count;
    }
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView.tag == 300) {
        HGLeftTableViewCell *cell = [HGLeftTableViewCell cellWithTabView:tableView];
        
        if (indexPath.row) {
            
            
            cell.titleStr = @"餐饮订单";
            
            cell.isSelected = (self.pageIndex?YES:NO);
            
        }else
        {
            cell.titleStr = @"签退情况";
            cell.isSelected =(self.pageIndex?NO:YES);
        }
        
        return cell;
    }else
    {
        if (!self.pageIndex) {
            HGSOutTableViewCell *cell = [HGSOutTableViewCell cellWithTabView:tableView];
            
            cell.model = self.signOutArray[indexPath.row];
            
            return cell;
        }else
        {
            HGOrderLTableViewCell *cell = [HGOrderLTableViewCell cellWithTabView:tableView];
            
            cell.model = self.orderArray[indexPath.row];
            
            return cell;
        }
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 300) {
        
        return 44;
        
    }else
    {
        if (self.pageIndex) {
            return 60+10;
        }
        return 90;
    }
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 300) {
        
        self.pageIndex = indexPath.row;
        
        [self loadData];
        
        [self.leftTable reloadData];
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]init];
    if ((tableView.tag == 301)&&(self.pageIndex == 0)&&(self.signOutArray.count)) {
        UILabel *lable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:HGMainColor];
        lable.text = [NSString stringWithFormat:@"实际用餐总人数:%zd",self.realNum];
        lable.frame = CGRectMake(0, 0, self.righTable.width, 30);
        [header addSubview:lable];
    }
    
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if ((tableView.tag == 301)&&(self.pageIndex == 0)&&(self.signOutArray.count)) {
        return 30;
    }else
    {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}
-(CGFloat) tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
