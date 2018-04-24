//
//  HGContactController.m
//  HGGL
//
//  Created by taikang on 2018/4/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGContactController.h"
#import "HGContactModel.h"
#import "HGStudentContactCell.h"

@interface HGContactController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataAry;

@end

@implementation HGContactController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"学员通讯录";
    self.leftBtn.hidden = YES;
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];

}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY - HGTabbarH) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = 120;
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    WeakSelf;
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf requestData];
    }];
}


- (void)requestData{
    [SVProgressHUD showWithStatus:@"请求中...."];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteeList.do"];
    NSString *userid = [HGUserDefaults objectForKey:HGProjectID];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":userid} success:^(id responseObject) {
        
        [self.tableV.mj_header endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.dataAry = @[];
            [self.tableV reloadData];
            WeakSelf;
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"无数据";
            nodataView.block = ^{
                [weakSelf.tableV.mj_header beginRefreshing];
            };
            self.tableV.backgroundView = nodataView;
        }else{
            NSArray *tempAry = [responseObject[@"data"] firstObject][@"studentList"];
            //           NSArray *tempAry = @[@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"}];
            self.dataAry = [HGContactModel mj_objectArrayWithKeyValuesArray:tempAry];
            [self.tableV reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGStudentContactCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGStudentContactCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataAry[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HGContactModel *model = self.dataAry[indexPath.row];
    if (model.studentPhone) {
        NSString *str= [NSString stringWithFormat:@"tel:%@",model.studentPhone];
        UIWebView *callWebview = [[UIWebView alloc] init];
        [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
        [self.view addSubview:callWebview];
    }
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
