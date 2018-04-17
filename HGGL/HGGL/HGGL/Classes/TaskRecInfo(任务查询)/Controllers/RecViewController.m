//
//  RecViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "RecViewController.h"
#import "RecTopView.h"
#import "CurrImageView.h"
#import "RecTableViewController.h"
#import "UIView+Frame.h"
#import "PopTableViewController.h"
#import "ZKRCover.h"
#import "HistroyTopView.h"
#define magin 3
@interface RecViewController ()

@property (nonatomic,strong) PopTableViewController *popView;
@property (nonatomic,weak) RecTopView *topView;
@property (nonatomic,weak) UIImageView *topImage;
//@property (nonatomic,strong) RecTableViewController *RC;
//@property (nonatomic,strong)
@property (nonatomic,weak) UIView *currentView;
@end

@implementation RecViewController

//-(PopTableViewController *)popView
//{
//    if (_popView == nil) {
//        PopTableViewController *popView = [[PopTableViewController alloc]init];
//        _popView = popView;
//    }
//    return _popView;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setTopImage];
    //[self setBottomView];
}
-(void)setTopImage
{
    UIImageView *topImage = [[UIImageView alloc]init];
    topImage.userInteractionEnabled = YES;
    topImage.backgroundColor = [UIColor whiteColor];
    self.topImage = topImage;
    self.topImage.frame = CGRectMake(magin, 64, self.view.bounds.size.width-2*magin, 40);
    [self.view addSubview:topImage];
    NSArray *arr = [NSArray arrayWithObjects:@"当日接待",@"综合查询", nil];
    
    UISegmentedControl *seg = [[UISegmentedControl alloc]initWithItems:arr];
//    seg setBackgroundImage:[UIImage resizableImageWithName:[UIImage imageNamed:@"tab_left_normal"]] forState:UIControlStateNormal barMetrics:<#(UIBarMetrics)#>
    seg.bounds = CGRectMake(0, 0, 250, 30);
    seg.center = CGPointMake(HGScreenWidth/2, 20);
    seg.selectedSegmentIndex = 0;
    [self viewChange:seg];
    //seg.selectedSegmentIndex = 1;
    [seg addTarget:self action:@selector(viewChange:) forControlEvents:UIControlEventValueChanged];
    [self.topImage addSubview:seg];
    
}
-(void)viewChange:(UISegmentedControl *)seg
{
    //HGLog(@"%ld",seg.selectedSegmentIndex);
    if (seg.selectedSegmentIndex) {
        [self.currentView removeFromSuperview];
        [self setHistory];
        
    }else
    {
        [self.currentView removeFromSuperview];
        [self setToday];
    }
}

-(void)setHistory
{
    HistroyTopView *history = [[HistroyTopView alloc]init];
    history .tableBlock = ^(id vc)
    {
        [self.navigationController pushViewController:vc animated:YES];
    };
//    __weak typeof (self) weakSelf = self;
//    history.typeBlock = ^(){
//        CGRect rect = CGRectMake(0, 104+magin+60, HGScreenWidth/3, 44*4);
//        [weakSelf setPopViewWith:rect And:[NSArray arrayWithObjects:@"餐饮",@"住宿",@"用车",@"教室", nil]];
//        weakSelf.popView.selectedCell = ^(NSString *str)
//        {
//            [ZKRCover dismiss];
//            
//        };
//    };
    history.frame = CGRectMake(0, 104+magin, self.view.bounds.size.width, self.view.bounds.size.height - 104-magin);
    self.currentView = history;
    [self.view addSubview:history];
}
-(void)setToday
{
    RecTopView *topView = [[RecTopView alloc]init];
    topView.tableBlock = ^(id vc)
    {
        [self.navigationController pushViewController:vc animated:YES];
    };
    //self.topView = topView;
//    __weak typeof (self) weakSelf = self;
//    topView.typePicker = ^(){
//        CGRect rect = CGRectMake(HGScreenWidth/2, 137, HGScreenWidth/2 - 3, 44*4);
//        [weakSelf setPopViewWith:rect And:[NSArray arrayWithObjects:@"当日餐饮",@"当日住宿",@"当日用车",@"当日教室", nil]];
//        
//        weakSelf.popView.selectedCell=^(NSString *str)
//        {
//            
//            weakSelf.topView.type = str;
//            [CurrImageView dismiss];
//            [ZKRCover dismiss];
//            weakSelf.topView.but.selected = NO;
////            weakSelf.topView = nil;
//        };
//    };
    topView.frame = CGRectMake(0, 104+magin, self.view.bounds.size.width, self.view.bounds.size.height - 104-magin);
    self.currentView = topView;
    [self.view addSubview:topView];
}
//-(void)setPopViewWith:(CGRect)rect And:(NSArray *)arr;
//{
//    
//    CurrImageView *topView = [CurrImageView showInRect:rect];
//    PopTableViewController *popView = [[PopTableViewController alloc]init];
//    self.popView = popView;
//    topView.contentView = popView.tableView;
//    popView.arr = arr;
//    //[PopView setTabFrame];
//    [HGKeywindow addSubview:topView];
//    //HGLog(@"%@",self.view.subviews);
//    
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
