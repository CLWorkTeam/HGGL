//
//  HGMyPointController.m
//  HGGL
//
//  Created by taikang on 2018/4/11.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMyPointController.h"
#import "HGMyPointCell.h"
#import "HGMyPointModel.h"

@interface HGMyPointController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *titleView;

@property (nonatomic,strong) UITableView *tableV;

@property (nonatomic,strong) NSArray *nameAry;//培训班数组
@property (nonatomic,strong) NSArray *pointAry;//成绩ary

@property (nonatomic,strong) NSArray *dataAry;


@end

@implementation HGMyPointController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的成绩单";
    self.rightBtn.hidden = YES;
//    self.nameAry = @[@"北京海关培训班",@"大连海关培训班",@"呼和浩特海关培训班"];
//    self.pointAry = @[@"100",@"90",@"95"];
    [self setupSubviews];
}
- (void)setupSubviews{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, 60)];
    view.backgroundColor = [UIColor whiteColor];
    self.titleView = view;
    [self.view addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(15, 15, HGScreenWidth-30, 45)];
    view1.backgroundColor = HGColor(247, 218, 248, 0.8);
    view1.layer.borderWidth = 1.5;
    view1.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.width/3*2, view1.height)];
    label.text = @"班级名称";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:20];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HGMainColor;
    [view1 addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(label.maxX, 0, 1.5, view1.height)];
    lineV.backgroundColor = HGColor(249, 202, 168, 1);
    [view1 addSubview:lineV];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(lineV.maxX, 0, view1.width/3*1 - 1.5, view1.height)];
    label1.text = @"总成绩";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:20];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HGMainColor;
    [view1 addSubview:label1];

    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.titleView.maxY , HGScreenWidth, HGScreenHeight - self.titleView.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
//    tableV.separatorColor = HGColor(249, 202, 168, 1);
//    tableV.separatorInset = UIEdgeInsetsZero;
    tableV.backgroundColor = [UIColor whiteColor];
//    tableV.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
//    tableV.layer.borderWidth = 1.5;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.rowHeight = 50;
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        NSLog(@"321312");
        [self requestData];
    }];
    //
    //    self.tableV.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [weakSelf.tableV.mj_footer endRefreshingWithNoMoreData];
    //        });
    //    }];
}

- (void)requestData{

    NSString *url = [HGURL stringByAppendingString:@"Notice/getLearningOnCampus.do"];
    NSString *userid = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":userid} success:^(id responseObject) {
        
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
            NSArray *tempAry = responseObject[@"data"];
            //           NSArray *tempAry = @[@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"},@{@"noticeId":@"1",@"publisher":@"我问问",@"releaseTimeStr":@"2012-23-12",@"noticeTitle":@"测试"}];
            self.dataAry = [HGMyPointModel mj_objectArrayWithKeyValuesArray:tempAry];
            [self.tableV reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.nameAry.count<10) {
        return 10;
    }
    return self.nameAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"PointCell";
    HGMyPointCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];

    if (cell==nil) {
        cell = [[HGMyPointCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    if (indexPath.row<self.nameAry.count) {
//        cell.lineV.hidden = NO;
        cell.model = self.dataAry[indexPath.row];

    }else{
//        cell.lineV.hidden = YES;
        cell.model = nil;
        if (indexPath.row!=9) {
            cell.bottomLayer.hidden = YES;
        }
    }
    if (indexPath.row==0) {
        cell.topLayer.hidden = NO;
    }else{
        cell.topLayer.hidden = YES;
    }
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
