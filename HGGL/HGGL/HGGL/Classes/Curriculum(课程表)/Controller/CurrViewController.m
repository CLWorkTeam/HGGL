//
//  CurrViewController.m
//  SYDX_2
//
//  Created by mac on 15-5-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrViewController.h"
#import "TimerTransform.h"
#import "Date.h"
#import "CurrView.h"
#import "CurrCollectionViewController.h"
#import "CurrImageView.h"
#import "TabImageView.h"
#import "CurrTableViewController.h"
#import "ZKRCover.h"
#import "CurrentTableViewController.h"
#import "WeekToolBar.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "Currse.h"
#import "CurrseList.h"
@interface CurrViewController ()
@property (nonatomic ,strong)NSMutableArray *date;
@property (nonatomic,weak) CurrView *topView;
@property (nonatomic,strong) CurrCollectionViewController *curr;
@property (nonatomic,strong) CurrTableViewController *popView;
@property (nonatomic,strong) CurrentTableViewController *current;
@property (nonatomic,copy) NSString *course_date;
@property (nonatomic,strong) NSMutableArray *arr;
@end

@implementation CurrViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
-(CurrTableViewController *)popView
{
    if (_popView == nil) {
        CurrTableViewController *tab = [[CurrTableViewController alloc]init];
        tab.dateOfYear = self.date;
        _popView = tab;
        
    }
    return _popView;
}
-(CurrentTableViewController *)current
{
    if (_current == nil) {
        _current = [[CurrentTableViewController alloc]init];
        __weak typeof (self) weekSelf = self;
        _current.currentBlock = ^(id vc)
        {
            [weekSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _current;
}
-(NSMutableArray *)date
{
    if (_date == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy.MM.dd"];
        NSString *time = [fomatter stringFromDate:[NSDate date]];
//        NSString *time = @"2015.03.04";
        NSDateComponents *dc = [TimerTransform timerTransform:time];
        NSArray *arr = [TimerTransform AllWeeksOfThisYear:dc.year];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            //NSLog(@"%@",dict);
            Date *date = [Date dateWithDict:dict];
            [array addObject:date];
            //NSLog(@"%@",date.week);
            
        }
        _date = array;
    }
    return _date;
}
-(CurrCollectionViewController *)curr
{
    if (_curr == nil) {
        
        _curr = [[CurrCollectionViewController alloc]init];
    }
    return _curr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //NSLog(@"%@",[TimerTransform AllDayOfThisWeek:@"2015.6.1"]);
    //[self setTitle];
    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController. navigationBar.titleTextAttributes = dict;
    [self setcurrent];
    [self setTitle];
    [self setCurrView];
    
    
    
}

-(void)setPopView
{
    
    CurrImageView *bigImageView = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2, CGRectGetMaxY(self.topView.rect)+104, self.view.bounds.size.width/2, 44*4)];
    bigImageView.contentView = self.popView.tableView;
    __weak typeof (self)weekSelf  = self ;
    self.popView.selectCell = ^(Date *date)
    {
        weekSelf.topView.today = date.weekStar;
        weekSelf.topView.weekOfYear = date;
        [CurrImageView dismiss];
        [ZKRCover dismiss];
        weekSelf.topView.but.selected = NO;
       
    };
    
    [HGKeywindow addSubview:bigImageView];

    
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
        [weekSelf setPopView];
    };
    currView.toolBar.weekDayClick = ^(NSString *date)
    {
        NSString *D = [yearOfToday stringByAppendingString:date];
        weekSelf.current.current_date = D;

        [weekSelf.current postWith:D];
        
    };
    currView.today = today;

    NSDateComponents *dc = [TimerTransform timerTransform:today];
   
    NSInteger i = dc.weekOfYear;
    currView.weekOfYear = [self.date objectAtIndex:i-1];
    currView.frame = CGRectMake(0, 64, self.view.bounds.size.width, 122);
    currView.backgroundColor = [UIColor whiteColor];
    UIView *viewLine = [[UIView alloc] init];
    viewLine.frame = CGRectMake(5, 121.5, HGScreenWidth-10, 0.5);
    viewLine.backgroundColor = HGColor(220, 220, 220,1);
    [currView addSubview:viewLine];
//    currView.backgroundColor = [UIColor clearColor];
    
    [self.view addSubview:currView];
    
}
//设置课程表界面的导航栏
-(void)setTitle
{
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [but setTitle:@"返回" forState:UIControlStateNormal];
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but setImage:[UIImage imageNamed:@"return_pressed"] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(clickBack) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
    
    self.navigationItem.title = @"班级课表";
    
}
//设置课程表视图
-(void)setcurrent
{
    
    CurrImageView *current = [CurrImageView showInRect:CGRectMake(0, 122+64, self.view.bounds.size.width, self.view.bounds.size.height - 122-64)];
    [self.view addSubview:current];
    current.contentView = self.current.tableView;
}
-(void)clickBack
{
     [self.navigationController popViewControllerAnimated:YES];
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
