//
//  HGStudentHomeController.m
//  HGGL
//
//  Created by taikang on 2018/4/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStudentHomeController.h"
#import "HGMyPointController.h"
#import "HGItemDataController.h"
#import "HGMyDataViewController.h"
#import "HGItemCertController.h"
#import "HGContactUSViewController.h"

@interface HGStudentHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *imageV;
@property (nonatomic,strong) UITableView *tableV;

@property (nonatomic,strong) NSArray *teachersAry;


@end

@implementation HGStudentHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的班级";
    self.teachersAry = @[@"",@"",@"",@"",@"",@""];
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_schedule"] forState:UIControlStateNormal];

    [self addTableview];
}

- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY , HGScreenWidth, HGScreenHeight - self.bar.maxY - HGTabbarH) style:UITableViewStyleGrouped];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = 120;
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    //    WeakSelf;
    //    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
    //        NSLog(@"321312");
    //        [weakSelf.tableV.mj_header endRefreshing];
    //    }];
    //
    //    self.tableV.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
    //        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    //            [weakSelf.tableV.mj_footer endRefreshingWithNoMoreData];
    //        });
    //    }];
}

- (UITableViewCell *)firstSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, 150)];
    imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
    [cell.contentView addSubview:imageV];
    
    return cell;
}

- (UITableViewCell *)secondSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat gap = 10;
    CGFloat x;
    CGFloat y=0;
    CGFloat w;
    CGFloat h = 40;
    
    for (int i =0; i<3; i++) {
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        w = (HGScreenWidth - 4 *gap)/3;
        x = i *(gap + w) + gap;
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeImageFrame:CGRectMake(5, 7, 25, 25)];
        [btn changeTitleFrame:CGRectMake(30, 7, w-30, 25)];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"icon_manual"] forState:UIControlStateNormal];
            [btn setTitle:@"学员手册" forState:UIControlStateNormal];
            btn.backgroundColor = HGColor(65, 243, 64, 1);
        }else if (i==1){
            [btn setImage:[UIImage imageNamed:@"icon_exit"] forState:UIControlStateNormal];
            [btn setTitle:@"餐饮签退" forState:UIControlStateNormal];
            btn.backgroundColor = HGColor(34, 197, 238, 1);
        }else{
            [btn setImage:[UIImage imageNamed:@"icon_report"] forState:UIControlStateNormal];
            [btn setTitle:@"成绩单" forState:UIControlStateNormal];
            btn.backgroundColor = HGColor(249, 202, 168, 1);
        }
        [cell.contentView addSubview:btn];
    }
    
    for (int i =0; i<2; i++) {
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        y = gap + h;
        w = (HGScreenWidth - 3 *gap)/2;
        x = i *(gap + w) + gap;
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeImageFrame:CGRectMake(5, 7, 25, 25)];
        [btn changeTitleFrame:CGRectMake(30, 7, w-30, 25)];
        btn.backgroundColor = HGColor(57, 207, 189, 1);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:13];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"icon_fill_station"] forState:UIControlStateNormal];
            [btn setTitle:@"填报接站信息" forState:UIControlStateNormal];
        }else{
            [btn setImage:[UIImage imageNamed:@"icon_reception"] forState:UIControlStateNormal];
            [btn setTitle:@"查看接送站信息" forState:UIControlStateNormal];
        }
        [cell.contentView addSubview:btn];
    }

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn setTitle:@"项目资料" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.backgroundColor = HGColor(252, 123, 35, 1);
    btn.frame = CGRectMake(gap, (h + gap)*2, HGScreenWidth - 2*gap, h);
    btn.layer.masksToBounds = YES;
    btn.layer.cornerRadius = 5;
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}

- (UITableViewCell *)thirdSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell2"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(10,0, HGScreenWidth-20, 245)];
    contentV.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:contentV];
    
    UIView *titleV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentV.width, 50)];
    titleV.backgroundColor = HGColor(249, 227, 249, 1);
    [contentV addSubview:titleV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleV.bounds;
    maskLayer.path = maskPath.CGPath;
    titleV.layer.mask = maskLayer;

    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 10)];
    titleLab.font = [UIFont boldSystemFontOfSize:24];
    titleLab.text = @"基本信息";
    titleLab.textColor = HGColor(82,118, 215, 1);
    [titleLab sizeToFit];
    titleLab.centerY = titleV.centerY;
    [titleV addSubview:titleLab];
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, titleV.maxY, contentV.width, 185)];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    whiteV.layer.borderWidth = 1;
    [contentV addSubview:whiteV];
    
    UILabel *classLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 15, 100, 10)];
    classLab.font = [UIFont boldSystemFontOfSize:20];
    classLab.text = @"班级简介:";
    classLab.textColor = [UIColor blackColor];
    [classLab sizeToFit];
    [whiteV addSubview:classLab];

    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, classLab.maxY+40, 100, 10)];
    timeLab.font = [UIFont boldSystemFontOfSize:20];
    timeLab.text = @"培训时间:";
    timeLab.textColor = [UIColor blackColor];
    [timeLab sizeToFit];
    [whiteV addSubview:timeLab];
    
    UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, timeLab.maxY+10, 100, 10)];
    numLab.font = [UIFont boldSystemFontOfSize:20];
    numLab.text = @"培训人数:";
    numLab.textColor = [UIColor blackColor];
    [numLab sizeToFit];
    [whiteV addSubview:numLab];
    
    UILabel *teacherLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, numLab.maxY+10, 100, 10)];
    teacherLab.font = [UIFont boldSystemFontOfSize:20];
    teacherLab.text = @"班主任:";
    teacherLab.textColor = [UIColor blackColor];
    [teacherLab sizeToFit];
    [whiteV addSubview:teacherLab];
    
    return cell;
}

- (UITableViewCell *)fourthSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell3"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat h = 80;

    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(10,0, HGScreenWidth-20, 50 + 80*self.teachersAry.count)];
    contentV.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:contentV];
    
    UIView *titleV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentV.width, 50)];
    titleV.backgroundColor = HGColor(249, 227, 249, 1);
    [contentV addSubview:titleV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleV.bounds;
    maskLayer.path = maskPath.CGPath;
    titleV.layer.mask = maskLayer;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 100, 10)];
    titleLab.font = [UIFont boldSystemFontOfSize:24];
    titleLab.text = @"基本信息";
    titleLab.textColor = HGColor(82,118, 215, 1);
    [titleLab sizeToFit];
    titleLab.centerY = titleV.centerY;
    [titleV addSubview:titleLab];
    
    CGFloat x = 5;
    CGFloat y = 0;
    CGFloat w = contentV.width - 10;
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, titleV.maxY, contentV.width, h * self.teachersAry.count)];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    whiteV.layer.borderWidth = 1;
    [contentV addSubview:whiteV];

    for (int i = 0; i < self.teachersAry.count; i++) {
        
        y = h * i;
        
        UIView *teacherV = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        teacherV.backgroundColor = [UIColor whiteColor];
        [whiteV addSubview:teacherV];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, 0, 1000, 10)];
        label.text = @"主讲人/主持人:";
        label.font = [UIFont systemFontOfSize:16];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        label.y = h - label.height - 8;
        [teacherV addSubview:label];
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, h-1, w, 1)];
        lineV.backgroundColor = HGColor(249, 202, 168, 1);
        [teacherV addSubview:lineV];
    }
    
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        
        static NSString *ID = @"section0";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            
            cell = [self firstSectionCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;

    }else if (indexPath.section==1){
        
        static NSString *ID = @"section1";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            
            cell = [self secondSectionCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;

    }else if (indexPath.section==2){
        static NSString *ID = @"section2";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            
            cell = [self thirdSectionCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;

    }else if (indexPath.section==3){
        static NSString *ID = @"section3";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (cell==nil) {
            
            cell = [self fourthSectionCell];
            
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            
        }
        return cell;
        
    }
    return nil;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        return 150;
    }else if (indexPath.section==1){
        return 140;
    }else if(indexPath.section==2){
        return 235;
    }else{
        return 50 + 80*self.teachersAry.count;
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerV = [[UIView alloc]init];
    headerV.backgroundColor = [UIColor whiteColor];
    return headerV;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return .1;
    }
    return 15;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (void)btnClick:(anyButton *)sender{
    
    NSLog(@"%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"成绩单"]) {
        HGMyPointController *vc = [[HGMyPointController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"项目资料"]) {
        HGItemDataController *vc = [[HGItemDataController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"学员手册"]) {
        HGMyDataViewController *vc = [[HGMyDataViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"餐饮签退"]) {
        HGContactUSViewController *vc = [[HGContactUSViewController alloc]init];
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
