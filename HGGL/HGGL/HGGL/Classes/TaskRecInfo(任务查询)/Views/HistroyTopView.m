//
//  HistroyTopView.m
//  SYDX_2
//
//  Created by mac on 15-7-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "HistroyTopView.h"
#import "CurrImageView.h"
#import "historyTableViewController.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "PopTableViewController.h"
#import "HistoryParma.h"
#import "HisTime.h"
#import "MJExtension.h"
#import "ImageRightBut.h"
@interface HistroyTopView ()<UISearchBarDelegate>
@property (nonatomic,weak) UISearchBar *search;
@property (nonatomic,strong) UIButton *selectedBut;
@property (nonatomic,weak) UIView *top;
@property (nonatomic,weak) CurrImageView *bottom;
@property (nonatomic,strong) historyTableViewController *history;
@property (nonatomic,strong) PopTableViewController *popView;
@property (nonatomic,strong) HistoryParma *parma;
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) UIView *accessoryView;
@end
@implementation HistroyTopView
-(HistoryParma *)parma
{
    if (_parma == nil) {
        _parma = [[HistoryParma alloc]init];
        _parma.type = @"1";
    }
    return _parma;
}
-(historyTableViewController *)history
{
    if (_history == nil) {
        historyTableViewController *his = [[historyTableViewController alloc]init];
        his.cellBlock = ^(id vc)
        {
            if (_tableBlock) {
                _tableBlock(vc);
            }
        };
        _history = his;
    }
    return _history;
}
-(UIView *)accessoryView
{
    if (_accessoryView == nil) {
        UIView *accessoryView = [[UIView alloc]init];
        accessoryView.frame = CGRectMake(0, 0, HGScreenWidth, 30);
        accessoryView.backgroundColor = [UIColor lightGrayColor];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancle.backgroundColor = [UIColor redColor];
        
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
        cancle.bounds = CGRectMake(0, 0, 60, 30);
        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        //self.Y = sure;
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        _accessoryView = accessoryView;
        
    }
    return _accessoryView;
}
-(void)cancleA
{
    [self endEditing:YES];
    //[ZKRCover dismiss];
    self.searchBar.text = @"";
}
-(void)sureA
{
    self.parma.str = self.searchBar.text;
    [self endEditing:YES];
    [self.history loadDWith:self.parma];
    [self endEditing:YES];
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //self.backgroundColor = HGColor(244, 244, 244);
        [self setTopView];
        [self setImageView];
    }
    return self;
}
-(void)setTopView
{
    UIView *top = [[UIView alloc]init];
    self.top = top;
    [self addSubview:top];
    //添加搜索栏
    UISearchBar *search = [[UISearchBar alloc]init];
    search.searchBarStyle = UISearchBarStyleMinimal;
    search.placeholder = @"请输入关键字，如任务名称";
    search.delegate = self;
    self.searchBar = search;
//    search.inputAccessoryView = self.accessoryView;
    search.keyboardType = UIKeyboardTypeDefault;
    //[TF setReturnKeyType:UIReturnKeySearch];
    //HGLog(@"--%lu",search.subviews.count );
    //self.search = search;
    search.frame = CGRectMake(0, 0, HGScreenWidth, 30);
    [self.top addSubview:search];
    //添加任务类型
    CGFloat x = 0;
    CGFloat y = 30;
    CGFloat width = HGScreenWidth/3;
    CGFloat heigh = 30;
    UIButton *type = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    type.titleLabel.textAlignment = NSTextAlignmentCenter;
    [type setTitle:@"任务类型" forState:UIControlStateNormal];
    [type setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [type setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected  ];
    type.backgroundColor = HGColor(244, 244, 244,1);
    type.titleLabel.font = [UIFont systemFontOfSize:14];
    [type  setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [type addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
    type.frame = CGRectMake(x, y, width, heigh);
    [self.top addSubview:type];
    //添加时间周期
    UIButton *cycle = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [cycle setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [cycle setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    cycle.titleLabel.textAlignment = NSTextAlignmentCenter;
    [cycle setTitle:@"来校时间" forState:UIControlStateNormal];
    cycle.titleLabel.font = [UIFont systemFontOfSize:14];
    cycle.backgroundColor = HGColor(244, 244, 244,1);
    [cycle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cycle addTarget:self action:@selector(clickCycle:) forControlEvents:UIControlEventTouchUpInside];
    cycle.frame = CGRectMake(width, y, width, heigh);
    [self.top  addSubview:cycle];
    //添加运行状态
    UIButton *state = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [state setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [state setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    state.titleLabel.textAlignment = NSTextAlignmentCenter;
    [state setTitle:@"离校时间" forState:UIControlStateNormal];
    state.titleLabel.font = [UIFont systemFontOfSize:14];
    state.backgroundColor = HGColor(244, 244, 244,1);
    [state setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [state addTarget:self action:@selector(clickState:) forControlEvents:UIControlEventTouchUpInside];
    state.frame = CGRectMake(2*width, y, width, heigh);
    [self.top addSubview:state];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    //[searchBar becomeFirstResponder];
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
    }
    
    //显示键盘
    [self.searchBar becomeFirstResponder];
}

//点击cancel时候
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
    [searchBar endEditing:YES];
    searchBar.text = nil;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    
    searchBar.showsCancelButton = NO;
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    
    [self endEditing:YES];
    self.parma.str = searchBar.text;
    //HGLog(@"111%@",self.parma.mj_keyValues);
    [self.history loadDWith:self.parma];
}

-(void)clickType:(UIButton *)but
{
    but.selected = !but.selected;
    if (but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            [CurrImageView dismiss];
            but.selected = NO;
            self.popView = nil;
        };
        
        CGRect rect = CGRectMake(0, 104+3+60, HGScreenWidth/3, 44*3);
         PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:[NSArray arrayWithObjects:@"会议",@"公务",@"班次", nil]];
        self.popView = popView;
        popView.selectedCell = ^(NSString *str)
        {
            [but setTitle:str forState:UIControlStateNormal];
            //HistoryParma *parma = [[HistoryParma alloc]init];
            
            if ([str isEqual:@"会议"]) {
                self.parma.type = @"1";
            }else if ([str isEqual:@"公务"])
            {
                self.parma.type = @"2";
            }else if([str isEqual:@"班次"])
            {
                self.parma.type = @"3";
            }
            //HGLog(@"%@",self.parma.mj_keyValues);
            self.history.parma = self.parma;
            [self.history loadDWith:self.parma];
            //self.parma.type = str;
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            but.selected = NO;
            self.popView = nil;
        };
        
    }
}

-(void)clickCycle:(UIButton *)but
{
    but.selected = !but.selected;
    if (but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            [CurrImageView dismiss];
            but.selected = NO;
            
        };
        CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-300/2, 84, 300, 125)];
        HisTime *report = [[HisTime alloc]init];
        report.name = but.titleLabel.text;
        __weak typeof (self) weekSelf = self;
        report.cancleBlock = ^(){
            but.selected = NO;
            [but setTitle:@"来校时间" forState:UIControlStateNormal];
            weekSelf.parma.time_come = @"";
            HGLog(@"%@",self.parma.mj_keyValues);
            [weekSelf.history loadDWith:self.parma];
        };
        
        report.popBlock = ^(NSString *time)
        {
            //HGLog(@"%@--%@",start,end);
            //HistoryParma *parma = [[HistoryParma alloc]init];
            //parma.type = @"3";
            [but setTitle:time forState:UIControlStateNormal];
            weekSelf.parma.time_come = time;
            //HGLog(@"%@",self.parma.mj_keyValues);
            [weekSelf.history loadDWith:weekSelf.parma];
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            but.selected = NO;
        };
        
        
        curr.contentView = report;
        [HGKeywindow addSubview:curr];
        
    }else{
        [CurrImageView dismiss];
    }

}
-(void)clickState:(UIButton *)but
{
    but.selected = !but.selected;
    if (but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            [CurrImageView dismiss];
            but.selected = NO;
        };
        CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-300/2, 84, 300, 125)];
        HisTime *report = [[HisTime alloc]init];
        report.name = but.titleLabel.text;
        __weak typeof (self) weekSelf = self;
        report.cancleBlock = ^(){
            but.selected = NO;
            [but setTitle:@"离校时间" forState:UIControlStateNormal];
            weekSelf.parma.time_leave = @"";
            [weekSelf.history loadDWith:self.parma];
            
        };
        report.popBlock = ^(NSString *time)
        {
            [but setTitle:time forState:UIControlStateNormal];
            //HGLog(@"%@--%@",start,end);
            //HistoryParma *parma = [[HistoryParma alloc]init];
            //parma.type = @"3";
            self.parma.time_leave = time;
            //HGLog(@"%@",self.parma.mj_keyValues);
            [weekSelf.history loadDWith:self.parma];
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            but.selected = NO;
        };
        
        
        curr.contentView = report;
        [HGKeywindow addSubview:curr];
        
    }else{
        [CurrImageView dismiss];
    }

}
//-(void)selectTime:(UIButton *)but andTime:(NSString *)time
//{
//    but.selected = !but.selected;
//    if (but.selected) {
//        ZKRCover *cover = [ZKRCover show];
//        cover.dimBackGround = YES;
//        cover.ZKRCoverDismiss = ^(){
//            [CurrImageView dismiss];
//            but.selected = NO;
//            
//        };
//        CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-300/2, 84, 300, 125)];
//        HisTime *report = [[HisTime alloc]init];
//        report.name = but.titleLabel.text;
//        __weak typeof (self) weekSelf = self;
//        report.popBlock = ^(NSString *time)
//        {
//            //HGLog(@"%@--%@",start,end);
//            //HistoryParma *parma = [[HistoryParma alloc]init];
//            //parma.type = @"3";
//            if ([but.titleLabel.text isEqualToString:@"来校时间"]) {
//                self.parma.time_come = time;
//            }else
//            {
//                self.parma.time_leave = time;
//            }
//            
//            [weekSelf.history loadDWith:self.parma];
//            [CurrImageView dismiss];
//            [ZKRCover dismiss];
//            but.selected = NO;
//        };
//        
//        
//        curr.contentView = report;
//        [HGKeywindow addSubview:curr];
//        
//    }else{
//        [CurrImageView dismiss];
//    }
//}
-(void)setImageView
{
    CurrImageView *bottoom = [[CurrImageView alloc]init];
    self.bottom = bottoom;
    [self addSubview:bottoom];
    bottoom.contentView = self.history.tableView;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.top.frame = CGRectMake(0, 0, HGScreenWidth, 80);
    self.bottom.frame = CGRectMake(0, 60, HGScreenWidth, self.bounds.size.height-60-49);
}
//-(PopTableViewController*)setPopViewWith:(CGRect)rect And:(NSArray *)arr;
//{
//    
//    CurrImageView *topView = [CurrImageView showInRect:rect];
//    PopTableViewController *popView = [[PopTableViewController alloc]init];
//    popView = popView;
//    topView.contentView = popView.tableView;
//    popView.arr = arr;
//    //[PopView setTabFrame];
//    [HGKeywindow addSubview:topView];
//    //HGLog(@"%@",self.view.subviews);
//    return popView;
//}
@end
