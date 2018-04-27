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
//#import "TKBDPickerView.h"
#import "HcdDateTimePickerView.h"
#import "NSDate+Additions.h"

@interface HGItemPlanController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIView *headerV;
@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) UIButton *yearBtn;
@property (nonatomic,strong) UIButton *monthBtn;
@property (nonatomic,strong) UIButton *selectBtn; //选择时间的按钮

@property (nonatomic,copy) NSString *selectTime;//选中的时间

@property (nonatomic,copy) NSString *yearTime;
@property (nonatomic,copy) NSString *monthTime;

@end

@implementation HGItemPlanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"项目计划";
    self.rightBtn.hidden = YES;
    NSString *yearTime = [[NSDate date] stringWithFormat:@"yyyy"];
    self.yearTime = yearTime;

    [self addHeaderView];
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.headerV.maxY+HEIGHT_PT(10) , HGScreenWidth, HGScreenHeight - self.headerV.maxY-HEIGHT_PT(10)) style:UITableViewStyleGrouped];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(120);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    WeakSelf;
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [weakSelf loadDataWithYear:self.yearTime month:self.monthTime];
    }];
}


- (void)loadDataWithYear:(NSString *)year month:(NSString *)month{
    
    NSString *url = [HGURL stringByAppendingString:@"Project/getPlanList.do"];
    NSDictionary *param = @{@"year":year};
    if (month) {
        param = @{@"year":year,@"month":month};
    }
    [HGHttpTool POSTWithURL:url parameters:param success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        [self.tableV.mj_header endRefreshing];

        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.dataAry = @[];
            [self.tableV reloadData];
            self.tableV.backgroundView = [[HGNoDataView alloc]init];
        }else{
            NSArray *ary = responseObject[@"data"];
            self.dataAry = [HGItemPlanModel mj_objectArrayWithKeyValuesArray:ary];
            [self.tableV reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];

}



- (void)addHeaderView{
    
    UIView *headerV = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, HEIGHT_PT(60))];
    headerV.backgroundColor =[UIColor whiteColor];
    self.headerV = headerV;
    [self.view addSubview:headerV];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGGrayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
    [btn1 setTitle:@"年度计划" forState:UIControlStateNormal];
    [btn1 setTitleColor:HGMainColor forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    btn1.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    btn1.frame = CGRectMake(WIDTH_PT(10), HEIGHT_PT(10), WIDTH_PT(80), HEIGHT_PT(40));
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
    btn2.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    btn2.frame = CGRectMake(btn1.maxX+WIDTH_PT(10), btn1.y, btn1.width, btn1.height);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    btn2.tag = 1002;
    self.monthBtn = btn2;
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:btn2];

    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn3 setTitle:self.yearTime forState:UIControlStateNormal];
    [btn3 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
    btn3.frame = CGRectMake(HGScreenWidth-WIDTH_PT(100)-WIDTH_PT(10), headerV.height-HEIGHT_PT(30),WIDTH_PT(100), HEIGHT_PT(30));
    btn3.layer.cornerRadius = 3;
    btn3.layer.masksToBounds = YES;
    btn3.layer.borderColor = HGMainColor.CGColor;
    btn3.layer.borderWidth = 1;
    self.selectBtn = btn3;
    [btn3 addTarget:self action:@selector(selectTimeClick:) forControlEvents:UIControlEventTouchUpInside];
    [headerV addSubview:btn3];

    
    UIView *grayV = [[UIView alloc]initWithFrame:CGRectMake(0, headerV.maxY, HGScreenWidth, HEIGHT_PT(10))];
    grayV.backgroundColor = HGGrayColor;
    [self.view addSubview:grayV];
}

- (void)selectTimeClick:(UIButton *)sender{
    
    WeakSelf;
    if (self.monthBtn.isSelected==YES) { //说明是月度计划
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerYearMonthMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            [self.selectBtn setTitle:datetimeStr forState:UIControlStateNormal];
            NSString *year = [datetimeStr componentsSeparatedByString:@"-"].firstObject;
            NSString *month = [datetimeStr componentsSeparatedByString:@"-"].lastObject;
            [weakSelf loadDataWithYear:year month:month];
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];

    }else{
        
        HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerYearMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
        dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
            NSLog(@"%@", datetimeStr);
            [self.selectBtn setTitle:datetimeStr forState:UIControlStateNormal];
            [weakSelf loadDataWithYear:datetimeStr month:nil];
        };
        [self.view addSubview:dateTimePickerView];
        [dateTimePickerView showHcdDateTimePicker];
    }
}

- (void)clickBtn:(UIButton *)sender{
    
    NSInteger tag = sender.tag;
    if (tag==1001) { //点击年度计划
        self.yearBtn.selected = YES;
        self.monthBtn.selected = NO;
        self.monthTime = nil;
        [self.selectBtn setTitle:self.yearTime forState:UIControlStateNormal];
        [self loadDataWithYear:self.yearTime month:nil];
    }else{ //点击月度计划
        self.yearBtn.selected = NO;
        self.monthBtn.selected = YES;
        NSString *monthTime = [[NSDate date] stringWithFormat:@"MM"];
        self.monthTime = monthTime;
        [self.selectBtn setTitle:[[NSDate date] stringWithFormat:@"yyyy-MM"] forState:UIControlStateNormal];
        [self loadDataWithYear:self.yearTime month:self.monthTime];

    }
    
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
