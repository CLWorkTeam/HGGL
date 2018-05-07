//
//  HGStationInfoController.m
//  HGGL
//
//  Created by taikang on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStationInfoController.h"
#import "HGStationInfoCell.h"
#import "TKSelectView.h"

@interface HGStationInfoController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSMutableDictionary *dataDic;
@property (nonatomic,strong) NSDictionary *lastDic;
@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) NSArray *titleAry;

@property (nonatomic,assign) BOOL yesOrNo; //用来记录点击了是还是否按钮

@end

@implementation HGStationInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"填报接站信息";
    self.rightBtn.hidden = YES;
    
    self.yesOrNo = YES;
    self.titleAry = @[@"乘车人：",@"填报类型：",@"是否接送站：",@"联系电话：",@"车次/班次：",@"到达地点：",@"选择日期：",@"选择时间："];
    self.dataDic = [NSMutableDictionary dictionary];
    [self addTableview];

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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    WeakSelf;

    static NSString *ID = @"stationInfoCell";
    HGStationInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[HGStationInfoCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.titleLab.text = self.titleAry[indexPath.row];
    if (indexPath.row!=2) {
        if (indexPath.row==0) {
            cell.type = 1;
            cell.textF.text = [HGUserDefaults objectForKey:HGRealName];
        }else if(indexPath.row==3||indexPath.row==4){
            cell.type = 2;
        }else{
            cell.type = 4;
        }
    }else{
        cell.type = 3;
        cell.sendStation = self.yesOrNo;
        if (self.yesOrNo) {
            [self.dataDic setObject:@"是" forKey:@"是否接送站："];
        }else{
            [self.dataDic setObject:@"否" forKey:@"是否接送站："];
        }
    }
    cell.block = ^(NSString *title, NSString *value) {
        if ([title isEqualToString:@"是否接送站："]) {
            if ([value isEqualToString:@"否"]) {
                self.titleAry = @[@"乘车人：",@"填报类型：",@"是否接送站："];
                self.yesOrNo = NO;
                [self.tableV reloadData];
            }else{
                self.titleAry = @[@"乘车人：",@"填报类型：",@"是否接送站：",@"联系电话：",@"车次/班次：",@"到达地点：",@"选择日期：",@"选择时间："];
                self.yesOrNo = YES;
                [self.tableV reloadData];
            }
        }
        [weakSelf.dataDic setObject:value forKey:title];
    };
    cell.mark = indexPath.row;

    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 15.f;
}

#pragma mark - 提交接送站信息

- (void)commitChange:(UIButton *)sender{
    
    [self.view endEditing:YES];
    
    BOOL isNeed = [self.dataDic[@"是否接送站："] isEqualToString:@"是"]?YES:NO;
    
    if (isNeed) {
        if ([self.dataDic[@"联系电话："] length]==0) {
            [SVProgressHUD showInfoWithStatus:@"联系电话不能为空"];
            return;
        }
        if ([self numberSuitScanf:self.dataDic[@"联系电话："]] == NO) {
            [SVProgressHUD showInfoWithStatus:@"电话格式不正确"];
            return;
        }
    }

    NSString *url = [HGURL stringByAppendingString:@"Reception/getFillTimes.do?"];
    NSString *userID = [HGUserDefaults objectForKey:HGUserID];
    NSString *projectID = [HGUserDefaults objectForKey:HGProjectID];
    NSString *fillType = self.dataDic[@"填报类型："];
    if ([fillType isEqualToString:@"接站"]) {
        fillType = @"1";
    }else{
        fillType = @"2";
    }
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":userID,@"project_id":projectID,@"fillType":fillType} success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            self.lastDic = responseObject[@"data"];
            NSString *title = @"";
            if ([self.lastDic[@"isReport"] boolValue]) {
                if ([self.lastDic[@"lastCount"] integerValue]>0) {
                    title = [NSString stringWithFormat:@"您已填报过接送站信息，还有%@次修改机会。确认修改吗？",self.lastDic[@"lastCount"]];
                }else{
                    [SVProgressHUD showInfoWithStatus:@"剩余修改次数为0,无法修改"];
                    return ;
                }
            }else{
                title = @"确定提交吗？";
            }
            WeakSelf;
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:nil preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *actionConfirm1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil];
            [alert addAction:actionConfirm1];
            
            UIAlertAction *actionConfirm = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [weakSelf changeStationInfo];
            }];
            [alert addAction:actionConfirm];
            
            [HGKeywindow.rootViewController presentViewController:alert animated:YES completion:nil];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)changeStationInfo{
    
    NSString *url = [HGURL stringByAppendingString:@"Reception/fillCarInfo.do?"];
    NSMutableDictionary *param = [NSMutableDictionary dictionary];
    NSString *userID = [HGUserDefaults objectForKey:HGUserID];
    NSString *projectID = [HGUserDefaults objectForKey:HGProjectID];
    NSString *fillType = self.dataDic[@"填报类型："];
    if ([fillType isEqualToString:@"接站"]) {
        fillType = @"1";
    }else{
        fillType = @"2";
    }
    NSString *isNeed = [self.dataDic[@"是否接送站："] isEqualToString:@"是"]?@"1":@"0";
    [param setObject:userID forKey:@"user_id"];
    [param setObject:projectID forKey:@"project_id"];
    [param setObject:fillType forKey:@"fillType"];
    [param setObject:isNeed forKey:@"isNeed"];

    if ([isNeed isEqualToString:@"1"]) {
        NSString *phone = self.dataDic[@"联系电话："];
        NSString *trainFlightInfo = self.dataDic[@"车次/班次："];
        NSString *arrivePlace = self.dataDic[@"到达地点："];
        NSString *date = self.dataDic[@"选择日期："];
        NSString *time = self.dataDic[@"选择时间："];
        [param setObject:phone forKey:@"phone"];
        if (trainFlightInfo) {
            [param setObject:trainFlightInfo forKey:@"trainFlightInfo"];
        }
        [param setObject:arrivePlace forKey:@"arrivePlace"];
        [param setObject:date forKey:@"date"];
        [param setObject:time forKey:@"time"];
    }
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

//电话号码校验
-(BOOL)numberSuitScanf:(NSString*)number{
    
    //首先验证是不是手机号码
    NSString *MOBILE = @"^1([3589][0-9]|4[579]|66|7[0135678])[0-9]{8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    
    BOOL isOk = [regextestmobile evaluateWithObject:number];
    
    return isOk;
    
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
