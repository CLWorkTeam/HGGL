//
//  MenteeListViewController.m
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeListViewController.h"
#import "MenteeListViewController.h"
#import "MenteeListHeader.h"
#import "MenteeListTableViewController.h"
#import "CurrImageView.h"
#import "MenteeParama.h"
@interface MenteeListViewController ()
@property (nonatomic,strong)MenteeListTableViewController *table;
@property (nonatomic,weak) MenteeListHeader *header;
@property (nonatomic,strong) MenteeParama *parama;
@end

@implementation MenteeListViewController
-(MenteeListTableViewController *)table
{
    if (_table == nil) {
        _table = [[MenteeListTableViewController  alloc]init];
        _table.parama = self.parama;
        __weak typeof(self)weakSelf = self;
        _table.menteeBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
        _table.endEditBlock = ^{
            [weakSelf.view endEditing:YES];
        };
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"学员信息";
    self.view.backgroundColor = [UIColor whiteColor];
    MenteeParama *parma = [[MenteeParama alloc]init];
    parma.mentee_sex = @"2";
    parma.str = @"";
    parma.page = @"1";
    parma.pageSize = @"10";
    self.parama = parma;
    [self setHeader];
    [self setTableView];
    
}
//设置NavItemBtn
-(void)setupLeftNavItem{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
}
//返回前一页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setHeader
{
    MenteeListHeader *header = [[MenteeListHeader alloc]init];
    header.parama = self.parama;
    header.frame = CGRectMake(0, HGHeaderH, HGScreenWidth, 40+43+10+20);
    __weak typeof(self)weakSelf = self;
    header.butClick = ^(MenteeParama *parama)
    {
        weakSelf.table.parama = parama;
        [weakSelf.table refresh];
    };
    self.header = header;
//    header.backgroundColor = HGColor(244, 244, 244,1);
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, HGHeaderH+self.header.height, HGScreenWidth, HGScreenHeight-self.header.height-HGHeaderH)];
    [self.view addSubview:table];
    table.contentView = self.table.tableView;
    
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
