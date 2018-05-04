//
//  HGWeekMenuController.m
//  HGGL
//
//  Created by taikang on 2018/3/29.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWeekMenuController.h"
#import "HGWeekMenuCell.h"
#import "HGWeekMenuModel.h"

@interface HGWeekMenuController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSMutableArray *dayAry;
@property (nonatomic,strong) NSMutableArray *weekAry;
@property (nonatomic,strong) NSMutableArray *weekBtnAry;


@property (nonatomic,strong) UIView *weekView;
@property (nonatomic,strong) anyButton *menuBtn;
@property (nonatomic,strong) UIButton *dinnerBtn;
@property (nonatomic,strong) UIView *dinnerView;//选择早、中、晚餐的弹窗view
@property (nonatomic,strong) NSArray *dinnerAry;//早中晚餐字符串数组


@property (nonatomic,strong) NSArray *menuAry;//菜谱数组
@property (nonatomic,strong) NSArray *foodAry;//主食数组

@property (nonatomic,strong) UITableView *tableV;

@property (nonatomic,copy) NSString *selectTime;//当前选中的日期（用于请求数据）
@property (nonatomic,copy) NSString *selectType;//当前选中的早午晚餐（用于请求数据）

@end

@implementation HGWeekMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"每周菜谱";
    self.rightBtn.hidden = YES;
    self.weekAry = [NSMutableArray array];
    self.dayAry  = [NSMutableArray array];
    self.weekBtnAry = [NSMutableArray array];
    self.dinnerAry = @[@"早餐",@"午餐",@"晚餐"];
    
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = @"MM.dd";
    for (int i =1; i<=7; i++) {
       NSDate *newDate = [date dateByAddingTimeInterval:24*60*60*i];
        NSString *dayStr = [dateFor stringFromDate:newDate];
        [self.weekAry addObject:[self weekdayStringFromDate:newDate]];
        [self.dayAry addObject:dayStr];
    }
    [self addWeekView];
    [self addMenuView];
    [self addTableview];
    [self addNextButton];
    [self.tableV.mj_header beginRefreshing];
}

-(UIView *)dinnerView{
    
    if (_dinnerView==nil) {
        
        UIView *backV = [[UIView alloc]initWithFrame:self.view.bounds];
        backV.backgroundColor = [[UIColor blackColor]colorWithAlphaComponent:0.5];
        [self.view addSubview:backV];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapView)];
        [backV addGestureRecognizer:tapGes];
        
        UIView *listV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10), self.menuBtn.maxY, self.menuBtn.width, HEIGHT_PT(44)*3+HEIGHT_PT(2))];
        listV.backgroundColor = [UIColor clearColor];
        [backV addSubview:listV];
        
        for (int i = 0; i<3; i++) {
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            [btn setBackgroundImage:[UIImage imageNamed:@"bg_pop_middle"] forState:UIControlStateNormal];
            [btn setTitle:self.dinnerAry[i] forState:UIControlStateNormal];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(18)];
            btn.frame = CGRectMake(0, i * (HEIGHT_PT(44)+HEIGHT_PT(1)), listV.width, HEIGHT_PT(44));
            [btn addTarget:self action:@selector(clickDetailDinner:) forControlEvents:UIControlEventTouchUpInside];
            [listV addSubview:btn];
        }
        
        _dinnerView = backV;
    }
    return _dinnerView;
}

- (void)addWeekView{
    
    UIView *weekView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, HEIGHT_PT(100))];
    weekView.backgroundColor = [UIColor whiteColor];
    self.weekView = weekView;
    [self.view addSubview:weekView];
    
    CGFloat x = WIDTH_PT(10);
    CGFloat y = HEIGHT_PT(10);
    CGFloat w = (HGScreenWidth-WIDTH_PT(20))/7;
    CGFloat h = w;
    
    for (int i =0; i<7; i++) {
        
        x = WIDTH_PT(10) + i *w;
        NSString *day = self.dayAry[i];
        NSString *week = self.weekAry[i];
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeTitleFrame:btn.bounds];
        btn.titleLabel.numberOfLines = 0;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = w/2;
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(12)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        NSString *title = [NSString stringWithFormat:@"%@\n%@",week,day];
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor colorWithHexString:@"#666666"] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        [btn setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
        [btn addTarget:self action:@selector(clickDay:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = 1000+i;
        [weekView addSubview:btn];
        
        if (i==0) {
            btn.selected = YES;
        }
        [self.weekBtnAry addObject:btn];
    }
    
    weekView.height = HEIGHT_PT(20) + h ;
    
    UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, weekView.maxY, HGScreenWidth, HEIGHT_PT(10))];
    lineV.backgroundColor = HGGrayColor;
    [self.view addSubview:lineV];
}

- (void)addMenuView{
    
    UILabel *alertLab = [[UILabel alloc]initWithFrame:CGRectMake(0, self.weekView.maxY+HEIGHT_PT(10), HGScreenWidth, HEIGHT_PT(20))];
    alertLab.textColor = HGMainColor;
    alertLab.font = [UIFont systemFontOfSize:FONT_PT(13)];
    alertLab.textAlignment = NSTextAlignmentCenter;
    alertLab.text = @"注：需提前一天订餐";
    [alertLab sizeToFit];
    alertLab.centerX = self.view.centerX;
    alertLab.y = alertLab.y + HEIGHT_PT(5);
    [self.view addSubview:alertLab];
    
    anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(WIDTH_PT(10), alertLab.maxY+HEIGHT_PT(5), HGScreenWidth-WIDTH_PT(20), HEIGHT_PT(40));
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    btn.layer.borderColor = [UIColor lightGrayColor].CGColor;
    btn.layer.borderWidth = 1;
    [btn setTitle:@"早餐" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setImage:[UIImage imageNamed:@"icon_btn_down"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"icon_btn_up"] forState:UIControlStateSelected];
    [btn changeTitleFrame:CGRectMake(0, 0, btn.width*0.9, btn.height)];
    [btn changeImageFrame:CGRectMake(btn.width-WIDTH_PT(20), (btn.height-HEIGHT_PT(8))/2, WIDTH_PT(13), HEIGHT_PT(8))];
    [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
    self.menuBtn = btn;
    [self.view addSubview:btn];
}

- (void)addNextButton{
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(0,HGScreenHeight-HEIGHT_PT(50)-HGSafeBottom, HGScreenWidth ,HEIGHT_PT(50));
    [nextBtn setTitle:@"订餐" forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(18)]];
    [nextBtn addTarget:self action:@selector(bookDinner:) forControlEvents:UIControlEventTouchUpInside];
    self.dinnerBtn = nextBtn;
    [self.view addSubview:nextBtn];
    
}

//点击每天的按钮
- (void)clickDay:(UIButton *)sender{

    sender.selected = !sender.isSelected;
    for (UIButton *btn in self.weekBtnAry) {
        if (btn==sender) {
            btn.selected = YES;
        }else{
            btn.selected = NO;
        }
    }
    if (sender.titleLabel.text.length==8) {
        NSString *dateStr = [sender.titleLabel.text substringFromIndex:3];
        NSString *rightTime = [self rightTimeFromMonthDay:dateStr];
        self.selectTime = rightTime;
        [self requestDataWithData:rightTime type:@"1"];
    }
}

- (void)clickMenu:(anyButton *)sender{
    sender.selected = !sender.isSelected;
    if (sender.isSelected) {
        [self.view addSubview:self.dinnerView];
    }else{
        if (self.dinnerView.superview) {
            [self.dinnerView removeFromSuperview];
        }
    }
}

- (void)tapView{
    
    if (self.dinnerView.superview) {
        [self.dinnerView removeFromSuperview];
        self.menuBtn.selected = NO;
    }
}

- (void)clickDetailDinner:(UIButton *)sender{
    
    [self.menuBtn setTitle:sender.titleLabel.text forState:UIControlStateNormal];
    
    if (self.dinnerView.superview) {
        [self.dinnerView removeFromSuperview];
        self.menuBtn.selected = NO;
    }
    
    NSString *type = @"1";
    if ([sender.titleLabel.text isEqualToString:@"午餐"]) {
        type = @"2";
    }else if ([sender.titleLabel.text isEqualToString:@"晚餐"]){
        type = @"3";
    }
    self.selectType = type;
    [self requestDataWithData:self.selectTime type:type];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.menuBtn.maxY + 20, HGScreenWidth, HGScreenHeight - HEIGHT_PT(50) - self.menuBtn.maxY - 20) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(70);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    NSDate *date = [NSDate date];
    NSDate *newDate = [date dateByAddingTimeInterval:24*60*60];
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = @"yyyy-MM-dd";
    NSString *dayStr = [dateFor stringFromDate:newDate];
    self.selectTime = dayStr;
    self.selectType = @"1";
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestDataWithData:dayStr type:@"1"];
    }];
}


- (void)requestDataWithData:(NSString *)date type:(NSString *)type{
    
    NSString *url = [HGURL stringByAppendingString:@"Banner/getUserOrderDish.do"];
    NSString *userID = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":userID,@"time":date,@"type":type} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        [self.tableV.mj_header endRefreshing];
        
        self.dinnerBtn.enabled = ![responseObject[@"data"][@"isOrdered"] boolValue];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]||[responseObject[@"data"] count]==0) {
            self.menuAry = @[];
            self.foodAry = @[];
            [self.tableV reloadData];
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"暂无上传的菜谱";
            self.tableV.backgroundView = nodataView;
        }else{
            self.menuAry = [HGWeekMenuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"menuList"]];
            self.foodAry = [HGWeekMenuModel mj_objectArrayWithKeyValuesArray:responseObject[@"data"][@"stapleFoodList"]];
            [self.tableV reloadData];
            self.tableV.backgroundView = nil;
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    if (self.menuAry.count && self.foodAry.count) {
        return 2;
    }
    if (self.menuAry.count || self.foodAry.count) {
        return 1;
    }
    return 0;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.menuAry.count && self.foodAry.count) {
        if (section==0) {
            return self.menuAry.count;
        }
        return self.foodAry.count;
    }
    if (self.menuAry.count) {
        return self.menuAry.count;
    }
    if (self.foodAry.count) {
        return self.foodAry.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGWeekMenuCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGWeekMenuCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.menuAry.count && self.foodAry.count) {
        if (indexPath.section ==0) {
            cell.model = self.menuAry[indexPath.row];
        }else{
            cell.model = self.foodAry[indexPath.row];
        }
    }else if (self.menuAry.count) {
        cell.model = self.menuAry[indexPath.row];
    }else if (self.foodAry.count) {
        cell.model = self.foodAry[indexPath.row];
    }
    return cell;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backV = [[UIView alloc]init];
    backV.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), 0, HGScreenWidth, HEIGHT_PT(20))];
    titleLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    titleLab.textColor = HGMainColor;
    if (self.menuAry.count && self.foodAry.count) {
        if (section ==0) {
            titleLab.text = @"菜谱";
        }else{
            titleLab.text = @"主食";
        }
    }else if (self.menuAry.count) {
        titleLab.text = @"菜谱";
    }else if (self.foodAry.count) {
        titleLab.text = @"主食";
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


#pragma mark -订餐
- (void)bookDinner:(UIButton *)sender{
    
    BOOL OK = NO;
    
    for (HGWeekMenuModel *model in self.menuAry) {
        if (![model.menuNum isEqualToString:@"0"]) {
            OK = YES;
            break;
        }
    }
    for (HGWeekMenuModel *model in self.foodAry) {
        if (![model.menuNum isEqualToString:@"0"]) {
            OK = YES;
            break;
        }
    }
    
    if (OK ==NO) {
        [SVProgressHUD showInfoWithStatus:@"您还未选择任何菜品，无法点餐"];
        return;
    }
    
    WeakSelf;
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"确定提交订单吗？" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *actionConfirm1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:actionConfirm1];

    UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf postForDinner];
    }];
    [alert addAction:actionConfirm];
    
    [HGKeywindow.rootViewController presentViewController:alert animated:YES completion:nil];
}

- (void)postForDinner{
    
    NSString *url = [HGURL stringByAppendingString:@"Banner/orderDish.do"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *userID = [HGUserDefaults objectForKey:HGUserID];
    [param setObject:userID forKey:@"user_id"];
    [param setObject:self.selectTime forKey:@"time"];
    [param setObject:self.selectType forKey:@"type"];
    NSMutableString *order = [NSMutableString string];
    for (HGWeekMenuModel *model in self.menuAry) {
        if (model.menuNum.integerValue>0) {
            [order appendFormat:@"%@_%@,",model.menuId,model.menuNum];
        }
    }
    for (HGWeekMenuModel *model in self.foodAry) {
        if (model.menuNum.integerValue>0) {
            [order appendFormat:@"%@_%@,",model.menuId,model.menuNum];
        }
    }
    if ([[order substringFromIndex:order.length-1] isEqualToString:@","]) {
        [order deleteCharactersInRange:NSMakeRange(order.length-1, 1)];
    }
    [param setObject:order forKey:@"order"];
    [HGHttpTool POSTWithURL:url parameters:param success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
            self.dinnerBtn.enabled = NO;
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

- (NSString *)rightTimeFromMonthDay:(NSString *)time{
    NSDateFormatter *dateFor = [[NSDateFormatter alloc]init];
    dateFor.dateFormat = @"MM.dd";
    NSDate *date = [dateFor dateFromString:time];
    dateFor.dateFormat = @"yyyy-MM-dd";
    return [dateFor stringFromDate:date];
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
