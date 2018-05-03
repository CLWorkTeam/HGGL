//
//  HGInfoChangeController.m
//  HGGL
//
//  Created by taikang on 2018/5/1.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGInfoChangeController.h"
#import "HGInfoChangeCell.h"

@interface HGInfoChangeController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
//@property (nonatomic,strong) NSMutableDictionary *changedDic;//更改个人信息后的数组
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) NSArray *titleAry;


@end

@implementation HGInfoChangeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"个人信息及修改";
    self.titleAry = @[@"用户名：",@"真实姓名：",@"性别：",@"手机：",@"邮箱：",@"身份证：",@"部门：",@"职位："];
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    if ([type isEqualToString:@"3"]) {//学员
        self.titleAry = @[@"用户名：",@"真实姓名：",@"性别：",@"手机：",@"邮箱：",@"身份证：",@"关区：",@"部门：",@"职位："];
    }
    [self addTableview];
    [self requestData];
}
- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY, HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(60);
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.tableFooterView = [self footerView];
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
}

- (UIView *)footerView{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, HEIGHT_PT(80))];
    view.backgroundColor = [UIColor whiteColor];
    
    UIButton *nextBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nextBtn.frame = CGRectMake(WIDTH_PT(20),HEIGHT_PT(20), HGScreenWidth-WIDTH_PT(40) ,HEIGHT_PT(40));
    [nextBtn setTitle:@"提交" forState:UIControlStateNormal];
    [nextBtn setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateNormal];
    [nextBtn setTitleColor:[UIColor colorWithHexString:@"#ffffff"] forState:UIControlStateNormal];
    [nextBtn.titleLabel setFont:[UIFont systemFontOfSize:FONT_PT(15)]];
    [nextBtn addTarget:self action:@selector(commitChange:) forControlEvents:UIControlEventTouchUpInside];
    nextBtn.layer.masksToBounds = YES;
    nextBtn.layer.cornerRadius = 5;
    [view addSubview:nextBtn];

    return view;
}

- (void)requestData{
    
    NSString *url = [HGURL stringByAppendingString:@"/User/getInfo.do?"];
    NSString *userid = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":userid} success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
        
        [self.tableV.mj_header endRefreshing];
        
        if ([responseObject[@"status"] isEqualToString:@"0"]) {
            self.dataDic = [NSMutableDictionary dictionary];
            [self.tableV reloadData];
            HGNoDataView *nodataView = [[HGNoDataView alloc]init];
            nodataView.label.text = @"暂无个人信息";
            self.tableV.backgroundView = nodataView;
        }else{
            self.dataDic = [NSMutableDictionary dictionaryWithDictionary:[self rightAryWithDic:responseObject[@"data"]]];
            [self.tableV reloadData];
            self.tableV.backgroundView = nil;
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];
}

- (NSDictionary *)rightAryWithDic:(NSDictionary *)dic{

    if (dic[@"user_zone"]) {
        return @{@"用户名：":dic[@"account"],@"真实姓名：":dic[@"real_name"],@"性别：":dic[@"user_sex"],@"手机：":dic[@"user_tel"],@"邮箱：":dic[@"user_email"],@"身份证：":dic[@"user_idCard"],@"关区：":dic[@"user_zone"],@"部门：":dic[@"user_department"],@"职位：":dic[@"user_duty"]};
    }
    return @{@"用户名：":dic[@"account"],@"真实姓名：":dic[@"real_name"],@"性别：":dic[@"user_sex"],@"手机：":dic[@"user_tel"],@"邮箱：":dic[@"user_email"],@"身份证：":dic[@"user_idCard"],@"部门：":dic[@"user_department"],@"职位：":dic[@"user_duty"]};
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataDic.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"itemPlanCell";
    HGInfoChangeCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGInfoChangeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLab.text = self.titleAry[indexPath.row];
    if (indexPath.row!=2) {
        cell.textF.text = self.dataDic[cell.titleLab.text];
        if (indexPath.row==0) {
            cell.type = 1;
        }else{
            cell.type = 2;
        }
    }else{
        cell.type = 3;
        cell.sex = self.dataDic[@"性别："];
    }
    WeakSelf;
    cell.block = ^(NSString *title, NSString *value) {
        [weakSelf.dataDic setObject:value forKey:title];
    };

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}

#pragma mark - 修改个人资料

- (void)commitChange:(UIButton *)sender{
    
//    HGInfoChangeCell *cell = (HGInfoChangeCell *)self.tableV.visibleCells[1];
    [self.view endEditing:YES];
    
//    NSDictionary *keyDic =  @{@"真实姓名：":@"real_name",@"性别：":@"user_sex",@"手机：":@"user_tel",@"邮箱：":@"user_email",@"身份证：":@"user_idCard",@"关区：":@"user_zone",@"部门：":@"user_department",@"职位：":@"user_duty"};
    NSString *userID = [HGUserDefaults objectForKey:HGUserID];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    [param setObject:userID forKey:@"user_id"];
    [param setObject:self.dataDic[@"真实姓名："] forKey:@"real_name"];
    [param setObject:self.dataDic[@"性别："] forKey:@"user_sex"];
    [param setObject:self.dataDic[@"手机："] forKey:@"user_tel"];
    [param setObject:self.dataDic[@"邮箱："] forKey:@"user_email"];
    [param setObject:self.dataDic[@"身份证："] forKey:@"user_idCard"];
    if (self.dataDic[@"关区："]) {
        [param setObject:self.dataDic[@"关区："] forKey:@"user_zone"];
    }
    [param setObject:self.dataDic[@"部门："] forKey:@"user_department"];
    [param setObject:self.dataDic[@"职位："] forKey:@"user_duty"];

    NSString *url = [HGURL stringByAppendingString:@"/User/infoChange.do"];
    [HGHttpTool POSTWithURL:url parameters:param success:^(id responseObject) {
        
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            [self.navigationController popViewControllerAnimated:YES];
            [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        }else{
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
        }
    } failure:^(NSError *error) {
        
    }];

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
