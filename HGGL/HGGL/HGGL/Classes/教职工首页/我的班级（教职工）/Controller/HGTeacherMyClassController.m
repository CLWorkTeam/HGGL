//
//  HGTeacherMyClassController.m
//  HGGL
//
//  Created by taikang on 2018/4/25.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTeacherMyClassController.h"
#import "HGTeacherMyClassCell.h"
#import "HGTeacherMyClassModel.h"
#import "HGScrollBaseController.h"

@interface HGTeacherMyClassController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) HGNoDataView *nodataView;
@property (nonatomic,strong) UITableView *tableV;

@end

@implementation HGTeacherMyClassController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的班级";
    self.rightBtn.hidden = YES;
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(75);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestData];
    }];
}


- (void)requestData{
    
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMyClass.do"];
    NSString *userid = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":userid} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        [self.tableV.mj_header endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.dataAry = @[];
            [self.tableV reloadData];
            WeakSelf;
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"暂无数据，点击刷新";
            nodataView.block = ^{
                [weakSelf.tableV.mj_header beginRefreshing];
            };
            self.tableV.backgroundView = nodataView;
        }else{
            NSArray *tempAry = responseObject[@"data"];
            self.dataAry = [HGTeacherMyClassModel mj_objectArrayWithKeyValuesArray:tempAry];
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
    
    static NSString *ID = @"teacherMyClassCell";
    HGTeacherMyClassCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGTeacherMyClassCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataAry[indexPath.row];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    HGTeacherMyClassModel *model = self.dataAry[indexPath.row];
    HGScrollBaseController *vc = [[HGScrollBaseController alloc]init];
    vc.project_id = model.project_id;
    [self.navigationController pushViewController:vc animated:YES];
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
