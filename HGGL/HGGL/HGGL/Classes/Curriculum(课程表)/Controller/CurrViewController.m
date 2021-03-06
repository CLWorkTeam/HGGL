//
//  CurrViewController.m
//  SYDX_2
//
//  Created by mac on 15-5-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrViewController.h"
#import "TimerTransform.h"
//#import "Date.h"
#import "CurrView.h"
#import "CurrCollectionViewController.h"
#import "CurrImageView.h"
#import "TabImageView.h"
#import "CurrTableViewController.h"
#import "ZKRCover.h"
#import "CurrentTableViewController.h"
#import "WeekToolBar.h"
#import "HGHttpTool.h"
#import "HGPopView.h"
#import "Currse.h"
#import "CurrseList.h"
@interface CurrViewController ()
@property (nonatomic ,strong)NSMutableArray *date;
@property (nonatomic,weak) CurrView *topView;
@property (nonatomic,strong) CurrCollectionViewController *curr;
@property (nonatomic,weak) UILabel *lab;
//@property (nonatomic,strong) CurrTableViewController *popView;
@property (nonatomic,strong) CurrentTableViewController *current;
@property (nonatomic,copy) NSString *course_date;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,weak) CurrImageView *currIma;

@end

@implementation CurrViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
//-(CurrTableViewController *)popView
//{
//    if (_popView == nil) {
//        CurrTableViewController *tab = [[CurrTableViewController alloc]init];
//        tab.dateOfYear = self.date;
//        _popView = tab;
//
//    }
//    return _popView;
//}
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
    self.navigationController.navigationBarHidden = NO;
    
    [self setTitle];
    [self setCurrView];
    [self setcurrent];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"%f--%f",self.view.bounds.size.height,HGScreenHeight);
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
     NSLog(@"%f--%f",self.view.bounds.size.height,HGScreenHeight);
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.currIma.frame = CGRectMake(0, self.lab.maxY, self.view.bounds.size.width, self.view.bounds.size.height - self.lab.maxY);
     NSLog(@"%f--%f",self.view.bounds.size.height,HGScreenHeight);
}
-(void)setPopView
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
//            [self.current postWith:dict[@"weekStar"]];
        }
        
        
        
        
    }];

    
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
    NSDictionary *dict  = [self.date objectAtIndex:i-1];
    currView.weekOfYear = dict[@"str"];
    currView.frame = CGRectMake(0, 0, self.view.width, 90);
    UILabel *lab = [[UILabel alloc]init];
    lab.backgroundColor = [UIColor whiteColor];
    lab.text = @"注:点击课程查看课程详细";
    lab.textColor = HGMainColor;
    lab.font = [UIFont systemFontOfSize:11];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, currView.maxY +2, HGScreenWidth, 10+8);
    self.lab = lab;
    [self.view addSubview:lab];
    [self.view addSubview:currView];
    
}
//设置课程表界面的导航栏
-(void)setTitle
{
    

    self.navigationItem.title = @"课程表";
    
}
//设置课程表视图
-(void)setcurrent
{
    
    CurrImageView *current = [CurrImageView showInRect:CGRectMake(0, self.lab.maxY, self.view.bounds.size.width, self.view.bounds.size.height - self.lab.maxY)];
    self.currIma = current;
//    NSLog(@"%f--%f--%f--%f",self.lab.maxY,self.view.bounds.size.height-self.lab.maxY,self.view.bounds.size.height,HGScreenHeight);
    [self.view addSubview:current];
    current.contentView = self.current.tableView;
}
-(void)clickBack
{
    if (self.navigationController.topViewController) {
        [self.navigationController popViewControllerAnimated:YES];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
