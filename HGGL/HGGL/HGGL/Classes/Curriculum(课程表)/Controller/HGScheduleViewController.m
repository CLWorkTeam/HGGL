//
//  HGScheduleViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGScheduleViewController.h"
#import "HGScheduleTableViewCell.h"
#import "HGScheduleModel.h"
#import "HGScheduleTableViewCell.h"
#import "CurrView.h"
#import "CurrImageView.h"
#import "ImageRightBut.h"
#import "WeekToolBar.h"
//#import "Date.h"
#import "CurrHeader.h"
#import "HGPopView.h"
@interface HGScheduleViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableArray *scheduleArray;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) CurrView *topView;
@property (nonatomic,weak) UIView  *midView;
@property (nonatomic,strong) NSMutableArray *date;
@property (nonatomic,weak) UIButton *projectBut;
@property (nonatomic,copy) NSString *projectID;
@end

@implementation HGScheduleViewController
-(NSMutableArray *)date
{
    if (_date == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy.MM.dd"];
        NSString *time = [fomatter stringFromDate:[NSDate date]];
        NSDateComponents *dc = [TimerTransform timerTransform:time];
        NSArray *arr = [TimerTransform AllWeeksOfThisYear:dc.year];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            NSDictionary *dict1 = [@{@"str":[NSString stringWithFormat:@"第%@周 %@-%@",dict[@"week"],dict[@"weekStar"],dict[@"weekEnd"]],@"weekStar":dict[@"weekStar"]} mutableCopy];
            [array addObject:dict1];
            
        }
        _date = array;
    }
    return _date;
}
-(NSMutableArray *)scheduleArray
{
    if (_scheduleArray == nil) {
        _scheduleArray = [NSMutableArray array];
    }
    return _scheduleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    if (self.isTeacher) {
        NSDictionary *dict = self.array.firstObject;
        self.projectID = dict[@"project_id"];
    }else
    {
        self.projectID = [HGUserDefaults objectForKey:HGProjectID];
    }
    
    
    [self setTitle];
    [self setCurrView];
    [self setTabelView];
}

//添加课程表上半部分
-(void)setCurrView
{
    CurrView *currView = [[CurrView alloc]init];
    self.topView = currView;
    //currView.backgroundColor = [UIColor grayColor];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy.MM.dd"];
    NSString *today = [fomatter stringFromDate:[NSDate date]];
    NSString *yearOfToday = [today substringWithRange:NSMakeRange(0, 4)];
    //NSLog(@"今年是%@",yearOfToday);
    __weak typeof (self)weekSelf  = self ;
    currView.datePicker = ^{
        [weekSelf showPopView];
    };
    currView.toolBar.weekDayClick = ^(NSString *date)
    {
        NSString *D = [yearOfToday stringByAppendingString:date];
        
        [weekSelf postWith:D];
    };
    currView.today = today;
    
    NSDateComponents *dc = [TimerTransform timerTransform:today];
    
    NSInteger i = dc.weekOfYear;
    NSDictionary *dict  = [self.date objectAtIndex:i-1];
    currView.weekOfYear = dict[@"str"];
    currView.frame = CGRectMake(0, HGHeaderH, self.view.width, 90);
    [self.view addSubview:currView];
    
    UIView *teacherMidView = [[UIView alloc]init];
    teacherMidView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:teacherMidView];
    self.midView = teacherMidView;
    UILabel *lab = [[UILabel alloc]init];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = @"注:点击课程查看课程详细";
    lab.textColor = HGMainColor;
    lab.font = [UIFont systemFontOfSize:11];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, 2, HGScreenWidth, 18);
    [teacherMidView addSubview:lab];
    CGFloat  Y = currView.maxY ;
    CGFloat H = 20;
    if (self.isTeacher) {
        
        [self setProjectButton];
        
        H = 20+8*2+34;
        
        
    }
    teacherMidView.frame = CGRectMake(0, Y, HGScreenWidth, H);
}
-(void)setProjectButton
{
    CGFloat Hmar = 8;
    CGFloat H = 34;
    UILabel *lab = [[UILabel alloc]init];
    lab.numberOfLines = 0;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.textColor = [UIColor blackColor];
    lab.font = [UIFont systemFontOfSize:HGFont];
    lab.text = @"选择当前所在班级";
    [lab sizeToFit];
    lab.frame = CGRectMake(0, 22+Hmar, lab.width+2*10, H);
    [self.midView addSubview:lab];
    
    UIButton *but = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    [but setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [but setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    NSDictionary *dict = self.array.firstObject;
    [but setTitle:dict[@"project_name"] forState:UIControlStateNormal];
    but.titleLabel.lineBreakMode = NSLineBreakByCharWrapping;
    but.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    [but setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
    but.frame = CGRectMake(lab.maxX, lab.y, HGScreenWidth-lab.width-5, H);
    self.projectBut = but;
    [self.midView addSubview:but];
}
-(void)butClick:(UIButton *)but
{
    but.selected = !but.selected;
    
    CGRect r = [self.midView convertRect:but.frame toView:HGKeywindow];
    
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*((self.array.count>4)?4:self.array.count));
    
    [HGPopView setPopViewWith:rect And:self.array andShowKey:@"project_name"  selectBlock:^(NSDictionary *dict) {
        
        self.projectBut.selected = NO;
        
        if ([dict isKindOfClass:[NSString class]]) {
            
            
        }else
        {
            self.projectID = dict[@"project_id"];
            
            [but setTitle:dict[@"project_name"] forState:UIControlStateNormal];
            
            [self postWith:self.topView.today];
            
        }
        
        
        
        
    }];
}
-(void)showPopView
{
    CGRect r = [self.topView convertRect:self.topView.but.frame toView:HGKeywindow];
    
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 8*44);
    
    [HGPopView setPopViewWith:rect And:self.date andShowKey:@"str"  selectBlock:^(NSDictionary *dict) {
        
        self.topView.but.selected = NO;
        if ([dict isKindOfClass:[NSString class]]) {
            
            
        }else
        {
            self.topView.today = dict[@"weekStar"];
            self.topView.weekOfYear = dict[@"str"];
        }
        
        
        
        
    }];
}
//设置课程表界面的导航栏
-(void)setTitle
{

    self.navigationItem.title = @"班级课表";
    
}


-(void)setTabelView
{
    UITableView *tableView = [[UITableView alloc] init];
    tableView.frame = CGRectMake(0, self.midView.maxY, HGScreenWidth, HGScreenHeight-HGHeaderH-self.midView.height-self.topView.height);
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView];
    self.tableView = tableView;
}
-(void)postWith:(NSString *)date
{
    
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *url = [HGURL stringByAppendingString:@"Course/getProjectCourse.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"course_date":date,@"project_id":self.projectID} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        [self.scheduleArray removeAllObjects];
        NSArray *array = [NSArray array];
        //        _isRefreshing = NO;
        array = [responseObject objectForKey:@"data"];
        HGLog(@"-----%@",array);
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            for (NSDictionary *dict in array) {
                HGScheduleModel  *model = [HGScheduleModel initWithDict:dict];
                
                [self.scheduleArray addObject:model];
                
            }
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return  47;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    CurrHeader *header= [[CurrHeader alloc] init];
    header.isStudent = YES;
    return header;
    
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    
    return self.scheduleArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    HGScheduleTableViewCell *cell = [HGScheduleTableViewCell cellWithTabView:self.tableView];
    cell.model = [self.scheduleArray objectAtIndex:indexPath.row];
    
    __weak typeof (self) weekSelf = self;
    cell.currCellClick = ^(id vc)
    {
        [weekSelf.navigationController pushViewController:vc animated:YES];
    };
    cell.currButClick = ^(id vc )
    {
        [weekSelf.navigationController pushViewController:vc animated:YES];
    };
    return cell;
    
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 47;
    
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
