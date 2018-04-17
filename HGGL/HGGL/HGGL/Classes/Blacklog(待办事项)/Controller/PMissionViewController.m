//
//  PMissionViewController.m
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PMissionViewController.h"
#import "PMissonTableViewController.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "PMissionParama.h"
@interface PMissionViewController ()<UISearchBarDelegate>
@property (nonatomic,strong) PMissonTableViewController *table;
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) PMissionParama *parama;
@property (nonatomic,strong) UIView *accessoryView;
@end

@implementation PMissionViewController
-(PMissionParama *)parama
{
    if (_parama == nil) {
        _parama = [[PMissionParama alloc]init];
        _parama.user_id = [HGUserDefaults stringForKey:@"userID"];
    }
    return _parama;
}
-(PMissonTableViewController *)table
{
    if (_table == nil) {
        _table = [[PMissonTableViewController alloc]init];
    }
    return _table;
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
    [self.view endEditing:YES];
    //[ZKRCover dismiss];
    self.searchBar.text = @"";
}
-(void)sureA
{
    self.parama.str = self.searchBar.text;
    [self.view endEditing:YES];
    [self searchBarSearchButtonClicked:self.searchBar];
    [self.view endEditing:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"我的项目任务";
    UISearchBar *search = [[UISearchBar alloc]init];
    search.placeholder = @"请输入关键字:如任务所属项目名称等";
    search.searchBarStyle = UISearchBarStyleMinimal;
    _searchBar = search;
//    search.inputAccessoryView = self.accessoryView;
    search.frame = CGRectMake(0, 64, HGScreenWidth, 30);
    search.backgroundColor = [UIColor clearColor];
    search.delegate = self;
    [self.view addSubview:search];
    [self setTableView];
    
    // Do any additional setup after loading the view.
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, 94, HGScreenWidth, HGScreenHeight-30-64)];
    [self.view addSubview:table];
    table.contentView = self.table.tableView;
    
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
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
    self.parama.str = searchBar.text;
    [self.view endEditing:YES];
    [self.table postWithParama:self.parama];
    
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
