//
//  HGScoreListViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/5.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGScoreListViewController.h"
#import "HGMyPointCell.h"
#import "HGMyPointModel.h"
@interface HGScoreListViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UIView *headerView;
@property (nonatomic,strong) UIView *footerView;

@property (nonatomic,weak) UIView *contentView;
@property (nonatomic,strong) UITableView *tableV;

//@property (nonatomic,strong) NSArray *nameAry;//培训班数组
//@property (nonatomic,strong) NSArray *pointAry;//成绩ary

@property (nonatomic,strong) NSArray *dataAry;
@end

@implementation HGScoreListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"我的成绩单";
    self.view.backgroundColor = [UIColor whiteColor];
    UIView *contentView = [[UIView alloc]init];
    self.contentView = contentView;
    contentView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:contentView];
    [self addHeaderView];
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    if ([type isEqualToString:@"3"]) { //学员
        [self addFooterView];   //学员才显示总成绩
    }
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
    
}
- (void)addHeaderView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, HGHeaderH, HGScreenWidth, HEIGHT_PT(60))];
    view.backgroundColor = [UIColor whiteColor];
    self.headerView = view;
    [self.contentView addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(15), HEIGHT_PT(15), HGScreenWidth-WIDTH_PT(30), HEIGHT_PT(45))];
    view1.backgroundColor = HGColor(247, 218, 248, 0.8);
    view1.layer.borderWidth = 1.5;
    view1.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.width/3*2, view1.height)];
    label.text = @"班级名称";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:FONT_PT(18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HGMainColor;
    [view1 addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(label.maxX, 0, 1.5, view1.height)];
    lineV.backgroundColor = HGColor(249, 202, 168, 1);
    [view1 addSubview:lineV];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(lineV.maxX, 0, view1.width/3*1 - 1.5, view1.height)];
    label1.text = @"总成绩";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:FONT_PT(18)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HGMainColor;
    [view1 addSubview:label1];
    
}

- (void)addFooterView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, HGScreenHeight-HEIGHT_PT(60)-HGSafeBottom, HGScreenWidth, HEIGHT_PT(60))];
    view.backgroundColor = [UIColor whiteColor];
    self.footerView = view;
    [self.contentView addSubview:view];
    
    UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(15), 0, HGScreenWidth-WIDTH_PT(30), HEIGHT_PT(45))];
    view1.backgroundColor = HGColor(247, 218, 248, 0.8);
    view1.layer.borderWidth = 1.5;
    view1.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    [view addSubview:view1];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, view1.width/3*2, view1.height)];
    label.text = @"总成绩";
    label.backgroundColor = [UIColor clearColor];
    label.font = [UIFont boldSystemFontOfSize:FONT_PT(18)];
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = HGMainColor;
    [view1 addSubview:label];
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(label.maxX, 0, 1.5, view1.height)];
    lineV.backgroundColor = HGColor(249, 202, 168, 1);
    [view1 addSubview:lineV];
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(lineV.maxX, 0, view1.width/3*1 - 1.5, view1.height)];
    label1.text = @"0";
    label1.backgroundColor = [UIColor clearColor];
    label1.font = [UIFont boldSystemFontOfSize:FONT_PT(18)];
    label1.textAlignment = NSTextAlignmentCenter;
    label1.textColor = HGMainColor;
    [view1 addSubview:label1];
    
}


- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.headerView.maxY , HGScreenWidth, HGScreenHeight - self.headerView.maxY) style:UITableViewStylePlain];
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    if ([type isEqualToString:@"3"]) { //学员
        tableV.frame = CGRectMake(0,self.headerView.maxY , HGScreenWidth, self.footerView.y - self.headerView.maxY);
    }
    
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.showsVerticalScrollIndicator = NO;
    tableV.rowHeight = HEIGHT_PT(50);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.contentView addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestData];
    }];
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.contentView.frame = CGRectMake(0, 0, self.view.width, self.view.height);
    self.headerView.frame = CGRectMake(0, 0, self.contentView.width, HEIGHT_PT(60));
    self.footerView.frame = CGRectMake(0, self.contentView.height-HEIGHT_PT(60), self.contentView.width, HEIGHT_PT(60));
    self.tableV.frame = CGRectMake(0,self.headerView.maxY , self.contentView.width, self.contentView.height - self.headerView.height-self.footerView.height);
    
}
- (void)requestData{
    
    NSString *url = [HGURL stringByAppendingString:@"Notice/getLearningOnCampus.do"];
    
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":self.user_id} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
        
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
            self.tableV.backgroundView = nil;
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.dataAry.count<10) {
        return 10;
    }
    return self.dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"PointCell";
    HGMyPointCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell==nil) {
        cell = [[HGMyPointCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (self.dataAry.count<10) {
        if (indexPath.row<self.dataAry.count) {
            cell.model = self.dataAry[indexPath.row];
        }else{
            cell.model = nil;
            if (indexPath.row!=9) {
                cell.bottomLayer.hidden = YES;
            }
        }
    }else{
        cell.model = self.dataAry[indexPath.row];
    }
    if (indexPath.row==0) {
        cell.topLayer.hidden = NO;
    }else{
        cell.topLayer.hidden = YES;
    }
    return cell;
    
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
