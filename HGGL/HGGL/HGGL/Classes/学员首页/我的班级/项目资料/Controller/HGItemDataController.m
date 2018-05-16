//
//  HGItemDataController.m
//  HGGL
//
//  Created by taikang on 2018/4/15.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemDataController.h"
#import "HGItemDataCell.h"
#import "HGItemDataModel.h"

@interface HGItemDataController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
//@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) NSArray *courseAry;//课件数组
@property (nonatomic,strong) NSArray *videoAry;//视频数组


@end

@implementation HGItemDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"项目资料";
    self.rightBtn.hidden = YES;
    
//    NSDictionary *dict = @{@"dataId":@"1",@"dataName":@"的撒打算",@"downloadUrl":@"dsadasdas"};
//    HGItemDataModel *model = [HGItemDataModel mj_objectWithKeyValues:dict];
//
//    self.courseAry = @[model,model,model];
//    self.videoAry = @[model,model,model];
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
//    [self requestData];

}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY + 20, HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(44);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestData];
    }];
}


- (void)requestData{
    
    NSString *url = [HGURL stringByAppendingString:@"Project/getVideo.do"];
    NSString *project_id = [HGUserDefaults objectForKey:HGProjectID];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":project_id} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        [self.tableV.mj_header endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.courseAry = @[];
            self.videoAry = @[];
            [self.tableV reloadData];
            WeakSelf;
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"无数据";
            nodataView.block = ^{
                [weakSelf.tableV.mj_header beginRefreshing];
            };
            self.tableV.backgroundView = nodataView;
        }else{
            self.courseAry = [HGItemDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"courseWareList"]];
            self.videoAry = [HGItemDataModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"videoList"]];
            [self.tableV reloadData];
            if (self.courseAry.count==0&&self.videoAry.count==0) {
                WeakSelf;
                HGNoDataView *nodataView = [[HGNoDataView alloc]init];
                nodataView.label.text = @"无数据";
                nodataView.block = ^{
                    [weakSelf.tableV.mj_header beginRefreshing];
                };
                self.tableV.backgroundView = nodataView;
            }else{
                self.tableV.backgroundView = nil;
            }
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.courseAry.count && self.videoAry.count) {
        return 2;
    }
    if (self.courseAry.count || self.videoAry.count) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.courseAry.count && self.videoAry.count) {
        if (section==0) {
            return self.courseAry.count;
        }
        return self.videoAry.count;
    }
    if (self.courseAry.count) {
        return self.courseAry.count;
    }
    if (self.videoAry.count) {
        return self.videoAry.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGItemDataCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGItemDataCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.courseAry.count && self.videoAry.count) {
        if (indexPath.section ==0) {
            cell.type = 0;
            cell.model = self.courseAry[indexPath.row];
        }else{
            cell.type = 1;
            cell.model = self.videoAry[indexPath.row];
        }
    }else if (self.courseAry.count) {
        cell.type = 0;
        cell.model = self.courseAry[indexPath.row];
    }else if (self.videoAry.count) {
        cell.type = 1;
        cell.model = self.videoAry[indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backV = [[UIView alloc]init];
    backV.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), 0, HGScreenWidth, HEIGHT_PT(20))];
    titleLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    titleLab.textColor = [UIColor blackColor];
//    if (section==0) {
//        titleLab.text = @"课件：";
//    }else if (section==1){
//        titleLab.text = @"视频：";
//    }
    if (self.courseAry.count && self.videoAry.count) {
        if (section ==0) {
            titleLab.text = @"课件：";
        }else{
            titleLab.text = @"视频：";
        }
    }else if (self.courseAry.count) {
        titleLab.text = @"课件：";
    }else if (self.videoAry.count) {
        titleLab.text = @"视频：";
    }

    [backV addSubview:titleLab];
    
    return backV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return HEIGHT_PT(20);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
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
