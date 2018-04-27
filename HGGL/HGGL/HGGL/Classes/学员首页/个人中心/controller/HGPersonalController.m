//
//  HGPersonalController.m
//  HGGL
//
//  Created by taikang on 2018/4/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPersonalController.h"
#import "HGPersionCenterCell.h"
#import "HGLoginController.h"
#import "HGContactUSViewController.h"
#import "HGScrollBaseController.h"
#import "HGMyDataViewController.h"
#import "HGTeacherMyClassController.h"
#import "HGMyPointController.h"
#import "HGItemCertController.h"

@interface HGPersonalController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) NSArray *listAry;
@property (nonatomic,strong) UITableView *tableV;


@end

@implementation HGPersonalController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"个人中心";
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    self.listAry = @[@"版本",@"个人信息及修改",@"密码修改",@"我的班级",@"我的档案",@"退出当前账号"];
    if ([type isEqualToString:@"3"]) {  //学员没有返回按钮
        self.leftBtn.hidden = YES;
        self.listAry = @[@"版本",@"个人信息及修改",@"密码修改",@"我的下载",@"我的档案",@"我的成绩单",@"项目证书",@"联系我们",@"退出当前账号"];
    }
    [self addTableview];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(44);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGPersionCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGPersionCenterCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleStr = self.listAry[indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *title = self.listAry[indexPath.row];
    if ([title isEqualToString:@"退出当前账号"]) {
        HGLoginController *vc = [[HGLoginController alloc]init];
        HGKeywindow.rootViewController = vc;
    }
    if ([title isEqualToString:@"联系我们"]) {
        HGContactUSViewController *vc =[[HGContactUSViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if([title isEqualToString:@"密码修改"]){
        HGScrollBaseController *vc = [[HGScrollBaseController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:@"我的档案"]) {
        HGMyDataViewController *vc = [[HGMyDataViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:@"我的班级"]) {
        HGTeacherMyClassController *vc = [[HGTeacherMyClassController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:@"我的成绩单"]) {
        HGMyPointController *vc = [[HGMyPointController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([title isEqualToString:@"项目证书"]) {
        HGItemCertController *vc = [[HGItemCertController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

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
