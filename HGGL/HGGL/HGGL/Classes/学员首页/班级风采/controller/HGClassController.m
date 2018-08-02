//
//  HGClassController.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassController.h"
#import "HGSchoolFCModel.h"
#import "HGSchoolFCCell.h"

@interface HGClassController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableArray *dataAry;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString *pageSize;

@end

@implementation HGClassController
-(NSMutableArray *)dataAry
{
    if (_dataAry == nil) {
        _dataAry = [NSMutableArray array];
    }
    return _dataAry;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"班级风采";
    self.pageSize = @"10";
    
    self.leftBtn.hidden = YES;
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY - HGTabbarH-HGSafeBottom) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(160);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    WeakSelf
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf requestData];
    }];
    self.tableV.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        
        [weakSelf loadMoreData];
    }];
}


- (void)requestData{
    if (_isRefreshing) {
        return;
    }
    self.page = @"1";
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Notice/getLearningOnCampus.do"];
    NSString *userid = [HGUserDefaults objectForKey:HGProjectID];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":userid,@"page":self.page,@"pageSize":self.pageSize} success:^(id responseObject) {
        _isRefreshing = NO;
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        [self.tableV.mj_header endRefreshing];
        [self.dataAry removeAllObjects];
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
//            self.dataAry = @[];
            
//            NSDictionary *dict = @{@"noticeId":@"1",@"publisher":@"1",@"releaseTimeStr":@"1",@"noticeTitle":@"test",@"picUrl":[HGURL stringByAppendingString:@"/user_base/site/180331141456027.jpg"]};
//            HGSchoolFCModel *model = [HGSchoolFCModel mj_objectWithKeyValues:dict];
//            self.dataAry=@[model,model];
            
            [self.tableV reloadData];
            WeakSelf;
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"无班级风采信息";
            nodataView.block = ^{
                [weakSelf.tableV.mj_header beginRefreshing];
            };
            self.tableV.backgroundView = nodataView;
        }else{
            NSArray *tempAry = responseObject[@"data"];
            //           NSArray *tempAry = @[@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"}];
//            self.dataAry = [HGSchoolFCModel mj_objectArrayWithKeyValuesArray:tempAry];
            for (NSDictionary *dict in tempAry) {
                HGSchoolFCModel *model = [HGSchoolFCModel initWithDict:dict];
                [self.dataAry addObject:model];
            }
            [self.tableV reloadData];
            self.tableV.backgroundView = nil;
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        [self.tableV.mj_header endRefreshing];
    }];
}
-(void)loadMoreData
{
    if (_isRefreshing) {
        return;
    }
    NSInteger i = [self.page integerValue ];
    self.page = [NSString stringWithFormat:@"%ld",++i];
    _isRefreshing = YES;
    NSString *url = [HGURL stringByAppendingString:@"Notice/getLearningOnCampus.do"];
    NSString *userid = [HGUserDefaults objectForKey:HGProjectID];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":userid,@"page":self.page,@"pageSize":self.pageSize} success:^(id responseObject) {
        _isRefreshing = NO;
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
        
        [self.tableV.mj_footer endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {

            NSInteger i = [self.page integerValue ];
            self.page = [NSString stringWithFormat:@"%ld",--i];
        }else{
            
            NSArray *tempAry = responseObject[@"data"];
            
            for (NSDictionary *dict in tempAry) {
                HGSchoolFCModel *model = [HGSchoolFCModel initWithDict:dict];
                [self.dataAry addObject:model];
            }
            
            [self.tableV reloadData];
            self.tableV.backgroundView = nil;
        }
    } failure:^(NSError *error) {
        _isRefreshing = NO;
        NSInteger i = [self.page integerValue ];
        self.page = [NSString stringWithFormat:@"%ld",--i];
        [self.tableV.mj_footer endRefreshing];
    }];
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGSchoolFCCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGSchoolFCCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataAry[indexPath.row];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
