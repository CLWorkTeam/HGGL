//
//  HGClassDetailController.m
//  HGGL
//
//  Created by taikang on 2018/4/23.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassDetailController.h"

@interface HGClassDetailController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;
@property (nonatomic,strong) NSDictionary  *dataDic;


@end

@implementation HGClassDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"课程详情";
    self.rightBtn.hidden = YES;
    [self addTableview];
    [SVProgressHUD showWithStatus:@"加载中..."];
    NSString *url = [HGURL stringByAppendingString:@"Course/getCourseInfo.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"course_id":self.course_id} success:^(id responseObject) {
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            self.dataDic = responseObject[@"data"];
            [self.tableV reloadData];
            self.tableV.tableHeaderView = [self headerView];
        }
    } failure:^(NSError *error) {
        
    }];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY , HGScreenWidth, HGScreenHeight - self.bar.maxY) style:UITableViewStyleGrouped];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = 30;
    tableV.delegate = self;
    tableV.dataSource = self;
    tableV.bounces = NO;
    self.tableV = tableV;
    [self.view addSubview:tableV];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section==1) {
        return [self.dataDic[@"course_teacher"] count];
    }
    return 1;
}

- (UIView *)headerView{
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, 40)];
    titleLab.font = [UIFont boldSystemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.text = self.dataDic[@"course_name"];
    return titleLab;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"classDetailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    for (UIView  *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(30, 5, HGScreenWidth, 20)];
    titleLab.font = [UIFont systemFontOfSize:16];
    titleLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [cell.contentView addSubview:titleLab];
    if (indexPath.section == 0) {
        titleLab.text = self.dataDic[@"course_info"];
    }else if (indexPath.section==1){
        NSDictionary *teacherDic = self.dataDic[@"course_teacher"][indexPath.row];
        titleLab.text = [NSString stringWithFormat:@"%@:%@",teacherDic[@"teacherName"],teacherDic[@"teacherInfo"]];
    }else{
        titleLab.text = self.dataDic[@"remark"];
    }
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 30;
    }else if (indexPath.section==1){
        NSDictionary *teacherDic = self.dataDic[@"course_teacher"][indexPath.row];
        NSString *text = [NSString stringWithFormat:@"%@:%@",teacherDic[@"teacherName"],teacherDic[@"teacherInfo"]];
        return [TextFrame frameOfText:text With:[UIFont systemFontOfSize:16] Andwidth:HGScreenWidth].height+10;
    }else{
        return 30;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *backV = [[UIView alloc]init];
    backV.backgroundColor = [UIColor whiteColor];
    
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(20, 0, HGScreenWidth, 20)];
    titleLab.font = [UIFont boldSystemFontOfSize:16];
    titleLab.textColor = [UIColor blackColor];
    if (section==0) {
        titleLab.text = @"课程简介：";
    }else if (section==1){
        titleLab.text = @"授课教师：";
    }else{
        titleLab.text = @"备注：";
    }
    [backV addSubview:titleLab];
    
    return backV;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 20;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
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
