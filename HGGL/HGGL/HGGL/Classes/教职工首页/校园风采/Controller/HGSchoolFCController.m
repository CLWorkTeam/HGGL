//
//  HGSchoolFCController.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSchoolFCController.h"
#import "HGSchoolFCModel.h"
#import "HGSchoolFCCell.h"
#import "HGWebViewController.h"

@interface HGSchoolFCController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataAry;


@end

@implementation HGSchoolFCController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"校园风采";
    self.rightBtn.hidden = YES;
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(160);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestData];
    }];
}


- (void)requestData{

    NSString *url = [HGURL stringByAppendingString:@"Notice/getLearningOnCampus.do"];
//    NSString *userid = [HGUserDefaults objectForKey:HGProjectID];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":@"0"} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        [self.tableV.mj_header endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.dataAry = @[];
            [self.tableV reloadData];
            WeakSelf;
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"无校园风采信息";
            nodataView.block = ^{
                [weakSelf.tableV.mj_header beginRefreshing];
            };
            self.tableV.backgroundView = nodataView;
        }else{
            NSArray *tempAry = responseObject[@"data"];
//           NSArray *tempAry = @[@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"}];
            self.dataAry = [HGSchoolFCModel mj_objectArrayWithKeyValuesArray:tempAry];
            [self.tableV reloadData];
            self.tableV.backgroundView = nil;
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
    HGSchoolFCCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGSchoolFCCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataAry[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HGSchoolFCModel *model = self.dataAry[indexPath.row];
    HGWebViewController *vc = [[HGWebViewController alloc]init];
    vc.titleStr = self.name;
    vc.url = [NSString stringWithFormat:@"%@Approve/approve_viewNoticeInfo.do?noticeId=%@",HGURL,model.noticeId];
    [self.navigationController pushViewController:vc
                                         animated:YES];
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
