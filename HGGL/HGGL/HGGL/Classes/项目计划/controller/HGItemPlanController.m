//
//  HGItemPlanController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemPlanController.h"
#import "HGItemPlanCell.h"
#import "HGItemPlanModel.h"

@interface HGItemPlanController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *headerV;
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) UIButton *yearBtn;
@property (nonatomic,strong) UIButton *monthBtn;


@end

@implementation HGItemPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"项目计划";
    self.rightBtn.hidden = YES;
    NSDictionary *dict = @{@"title":@"测试小孩",@"money":@"1212",@"days":@"11",@"number":@"12",@"time":@"2018-12-12 - 2018-12-31"};
    HGItemPlanModel *model = [HGItemPlanModel mj_objectWithKeyValues:dict];
    self.dataAry = @[model,model,model,model,model,model];
    [self addHeaderView];
    [self addTableview];
}

- (void)addHeaderView{
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, 60)];
    headerV.backgroundColor =[UIColor whiteColor];
    self.headerV = headerV;
    [self.view addSubview:headerV];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGGrayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
    [btn1 setTitle:@"年度计划" forState:UIControlStateNormal];
    [btn1 setTitleColor:HGMainColor forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn1.titleLabel.font = [UIFont systemFontOfSize:16];
    btn1.frame = CGRectMake(10, 10, 80, 40);
    btn1.layer.cornerRadius = 5;
    btn1.layer.masksToBounds = YES;
    btn1.selected = YES;
    btn1.tag = 1001;
    self.yearBtn = btn1;
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn2 setBackgroundImage:[UIImage imageWithColor:HGGrayColor] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
    [btn2 setTitle:@"月度计划" forState:UIControlStateNormal];
    [btn2 setTitleColor:HGMainColor forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn2.titleLabel.font = [UIFont systemFontOfSize:16];
    btn2.frame = CGRectMake(btn1.maxX+10, btn1.y, btn1.width, btn1.height);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    btn2.tag = 1002;
    self.monthBtn = btn2;
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:btn2];

    
    UIView *grayV = [[UIView alloc]initWithFrame:CGRectMake(0, headerV.maxY, HGScreenWidth, 10)];
    grayV.backgroundColor = HGGrayColor;
    [self.view addSubview:grayV];
}

- (void)clickBtn:(UIButton *)sender{
    NSInteger tag = sender.tag;
    if (tag==1001) {
        self.yearBtn.selected = YES;
        self.monthBtn.selected = NO;
    }else{
        self.yearBtn.selected = NO;
        self.monthBtn.selected = YES;
    }
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.headerV.maxY+10 , HGScreenWidth, HGScreenHeight - self.headerV.maxY-10) style:UITableViewStyleGrouped];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = 120;
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
//    WeakSelf;
//    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
//        NSLog(@"321312");
//        [weakSelf.tableV.mj_header endRefreshing];
//    }];
//
//    self.tableV.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            [weakSelf.tableV.mj_footer endRefreshingWithNoMoreData];
//        });
//    }];
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"itemPlanCell";
    HGItemPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGItemPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
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
