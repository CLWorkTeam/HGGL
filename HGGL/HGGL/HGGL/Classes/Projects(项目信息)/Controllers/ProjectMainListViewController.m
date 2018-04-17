
//
//  ProjectMainListViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ProjectMainListViewController.h"
#import "ProjectListViewController.h"
#import "ProjectAuditViewController.h"
@interface ProjectMainListViewController ()<UITableViewDataSource, UITableViewDelegate>
@property(nonatomic, strong)UITableView *myTableView;
@property(nonatomic, strong)NSMutableArray *arr;
@end

@implementation ProjectMainListViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        
        _arr = [NSMutableArray arrayWithObjects:@"项目信息",@"项目审批", nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"项目管理";
    [self setupLeftNavItem];
    [self setSubView];
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
-(void)setSubView
{
    UITableView *myTableView = [[UITableView alloc] init];
    myTableView.frame = CGRectMake(0, 0, HGScreenWidth, HGScreenHeight);
    myTableView.delegate = self;
    myTableView.dataSource = self;
    myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:myTableView];
    self.myTableView = myTableView;
    
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arr.count;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *name = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:name];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:name];
    }
    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:HGTextFont1];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
//    cell.detailTextLabel.text = @"haha";
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 40;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        ProjectListViewController *projectListVC = [[ProjectListViewController alloc] init];
        [self.navigationController pushViewController:projectListVC animated:YES];
        
    }
    if (indexPath.row == 1) {
        ProjectAuditViewController *projectAuditVC = [[ProjectAuditViewController alloc] init];
        [self.navigationController pushViewController:projectAuditVC animated:YES];
    }
}
-(void)didReceiveMemoryWarning {
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
