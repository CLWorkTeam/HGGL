//
//  HGStudentHomeController.m
//  HGGL
//
//  Created by taikang on 2018/4/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStudentHomeController.h"
#import "HGNavigationController.h"
#import "CurrViewController.h"
#import "MessageListController.h"
#import "HGMyPointController.h"
#import "HGItemDataController.h"
#import "HGMyDataViewController.h"
#import "HGItemCertController.h"
#import "HGContactUSViewController.h"
#import "HGStudentItemModel.h"
#import "HGClassDetailController.h"
#import "HGWebController.h"

@interface HGStudentHomeController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UIImageView *imageV;

@property (nonatomic,strong) NSArray *dataAry;
@property (nonatomic,strong) NSDictionary *infoDic;




@end

@implementation HGStudentHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的班级";
    [self.leftBtn setImage:[UIImage imageNamed:@"icon_schedule"] forState:UIControlStateNormal];
    [self.leftBtn addTarget:self action:@selector(schedule) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    
    [self addTableview];
    [self.tableV.mj_header beginRefreshing];
}

- (void)requestData{
    
    NSString *projectId = [HGUserDefaults objectForKey:HGProjectID];
    NSString *url = [HGURL stringByAppendingString:@"Project/getProjectInfo.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":self.project_id?self.project_id:projectId} success:^(id responseObject) {
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
        [self.tableV.mj_header endRefreshing];
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            self.infoDic = responseObject[@"data"];
            NSArray *tempAry = responseObject[@"data"][@"project_course"][@"course"];
            self.dataAry = [HGStudentItemModel mj_objectArrayWithKeyValuesArray:tempAry];
            [self.tableV reloadData];
        }
    } failure:^(NSError *error) {
        [self.tableV.mj_header endRefreshing];
    }];

}

-(void)schedule
{
    CurrViewController *curr = [[CurrViewController alloc]init];
    [self.navigationController   pushViewController:curr animated:YES];
}
-(void)message
{
    MessageListController *list = [[MessageListController   alloc]init];
    
    HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:list];
    
    [self presentViewController:nav animated:YES completion:nil];
}
- (void)addTableview{
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0,self.bar.maxY , HGScreenWidth, HGScreenHeight - self.bar.maxY - HGTabbarH) style:UITableViewStyleGrouped];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.backgroundColor = [UIColor whiteColor];
    tableV.rowHeight = HEIGHT_PT(120);
    tableV.delegate = self;
    tableV.dataSource = self;
    self.tableV = tableV;
    [self.view addSubview:tableV];
    
    self.tableV.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock:^{
        [self requestData];
    }];
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
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, HEIGHT_PT(150))];
    [cell.contentView addSubview:imageV];
    
    NSString *url = [HGURL stringByAppendingString:@"Banner/getBannerInfo.do"];
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    [HGHttpTool POSTWithURL:url parameters:@{@"type":type} success:^(id responseObject) {
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);

        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            NSString *resultUrl = [responseObject[@"data"] firstObject][@"imageUrl"];
            NSString *imgUrl = [NSString stringWithFormat:@"%@%@",HGURL,resultUrl];
            [imageV sd_setImageWithURL:[NSURL URLWithString:imgUrl]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                if (error) {
                    imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
                }
            }];
        }else{
            imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
        }
    } failure:^(NSError *error) {
            imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
    }];

    return cell;
}

- (UITableViewCell *)secondSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell1"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat gap = WIDTH_PT(10);
    CGFloat x;
    CGFloat y=0;
    CGFloat w;
    CGFloat h = HEIGHT_PT(40);
    
    if (self.secondSectionAry.count) {
        
        NSInteger count = self.secondSectionAry.count;
        
        for (int i =0; i < count; i++) {
            
            anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
            w = (HGScreenWidth - (count+1) *gap)/count;
            x = i *(gap + w) + gap;
            btn.frame = CGRectMake(x, y, w, h);
            [btn changeImageFrame:CGRectMake(WIDTH_PT(5), HEIGHT_PT(7), WIDTH_PT(25), HEIGHT_PT(25))];
            [btn changeTitleFrame:CGRectMake(WIDTH_PT(30), HEIGHT_PT(7), w-WIDTH_PT(30), HEIGHT_PT(25))];
            btn.backgroundColor = self.secondSectionColors[i];
            [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
            btn.layer.masksToBounds = YES;
            btn.layer.cornerRadius = 5;
            [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setImage:[self imageWithName:self.secondSectionAry[i]] forState:UIControlStateNormal];
            [btn setTitle:self.secondSectionAry[i] forState:UIControlStateNormal];
            [cell.contentView addSubview:btn];
        }
        
        return cell;
    }
    
    for (int i =0; i<3; i++) {
        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
        w = (HGScreenWidth - 4 *gap)/3;
        x = i *(gap + w) + gap;
        btn.frame = CGRectMake(x, y, w, h);
        [btn changeImageFrame:CGRectMake(WIDTH_PT(5), HEIGHT_PT(7), WIDTH_PT(25), HEIGHT_PT(25))];
        [btn changeTitleFrame:CGRectMake(WIDTH_PT(30), HEIGHT_PT(7), w-WIDTH_PT(30), HEIGHT_PT(25))];
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.layer.masksToBounds = YES;
        btn.layer.cornerRadius = 5;
        [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        if (i==0) {
            [btn setImage:[UIImage imageNamed:@"icon_manual"] forState:UIControlStateNormal];
            [btn setTitle:@"学员手册" forState:UIControlStateNormal];
            btn.backgroundColor = HGColor(65, 243, 64, 1);
        }else if (i==1){
            [btn setImage:[UIImage imageNamed:@"icon_sign_out"] forState:UIControlStateNormal];
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
        [btn changeImageFrame:CGRectMake(WIDTH_PT(5), HEIGHT_PT(7), WIDTH_PT(25), HEIGHT_PT(25))];
        [btn changeTitleFrame:CGRectMake(WIDTH_PT(30), HEIGHT_PT(7), w-WIDTH_PT(30), HEIGHT_PT(25))];
        btn.backgroundColor = HGColor(57, 207, 189, 1);
        [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
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
    btn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(14)];
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    [cell.contentView addSubview:btn];
    
    return cell;
}

- (UITableViewCell *)thirdSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell2"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10),0, HGScreenWidth-WIDTH_PT(20), HEIGHT_PT(230))];
    contentV.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:contentV];
    
    UIView *titleV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentV.width, HEIGHT_PT(40))];
    titleV.backgroundColor = HGColor(249, 227, 249, 1);
    [contentV addSubview:titleV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleV.bounds;
    maskLayer.path = maskPath.CGPath;
    titleV.layer.mask = maskLayer;

    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), 0, WIDTH_PT(100), HEIGHT_PT(10))];
    titleLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    titleLab.text = @"基本信息";
    titleLab.textColor = HGColor(82,118, 215, 1);
    [titleLab sizeToFit];
    titleLab.centerY = titleV.centerY;
    [titleV addSubview:titleLab];
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, titleV.maxY, contentV.width, HEIGHT_PT(190))];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    whiteV.layer.borderWidth = 1;
    [contentV addSubview:whiteV];
    
    UILabel *classLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), HEIGHT_PT(15), WIDTH_PT(100), HEIGHT_PT(10))];
    classLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    classLab.text = @"班级简介:";
    classLab.textColor = [UIColor blackColor];
    [classLab sizeToFit];
    [whiteV addSubview:classLab];
    
    UILabel *classDescLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), classLab.maxY+HEIGHT_PT(10), WIDTH_PT(100), HEIGHT_PT(10))];
    classDescLab.font = [UIFont systemFontOfSize:FONT_PT(15)];
    classDescLab.text = [self.infoDic[@"project_info"] length]?self.infoDic[@"project_info"]:@"暂无简介";
    classDescLab.textColor = [UIColor lightGrayColor];
    [classDescLab sizeToFit];
    [whiteV addSubview:classDescLab];


    UILabel *timeLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, classLab.maxY+HEIGHT_PT(45), WIDTH_PT(100), HEIGHT_PT(10))];
    timeLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    timeLab.text = @"培训时间:";
    timeLab.textColor = [UIColor blackColor];
    [timeLab sizeToFit];
    [whiteV addSubview:timeLab];
    
    UILabel *timeDescLab = [[UILabel alloc]initWithFrame:CGRectMake(timeLab.maxX + WIDTH_PT(5), timeLab.y, WIDTH_PT(100), HEIGHT_PT(10))];
    timeDescLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    timeDescLab.text = [NSString stringWithFormat:@"%@~%@",self.infoDic[@"project_start"],self.infoDic[@"project_end"]];
    timeDescLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [timeDescLab sizeToFit];
    [whiteV addSubview:timeDescLab];

    
    UILabel *numLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, timeLab.maxY+HEIGHT_PT(10), WIDTH_PT(100), HEIGHT_PT(10))];
    numLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    numLab.text = @"培训人数:";
    numLab.textColor = [UIColor blackColor];
    [numLab sizeToFit];
    [whiteV addSubview:numLab];
    
    UILabel *numDescLab = [[UILabel alloc]initWithFrame:CGRectMake(numLab.maxX + WIDTH_PT(5), numLab.y, WIDTH_PT(100), HEIGHT_PT(10))];
    numDescLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    numDescLab.text = self.infoDic[@"project_Num"];
    numDescLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [numDescLab sizeToFit];
    [whiteV addSubview:numDescLab];
    
    UILabel *teacherLab = [[UILabel alloc]initWithFrame:CGRectMake(classLab.x, numLab.maxY+HEIGHT_PT(10), WIDTH_PT(100), HEIGHT_PT(10))];
    teacherLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    teacherLab.text = @"班主任:";
    teacherLab.textColor = [UIColor blackColor];
    [teacherLab sizeToFit];
    [whiteV addSubview:teacherLab];
    
    UILabel *teacherDescLab = [[UILabel alloc]initWithFrame:CGRectMake(numDescLab.x , teacherLab.y, WIDTH_PT(100), HEIGHT_PT(10))];
    teacherDescLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    teacherDescLab.text = self.infoDic[@"project_manager"];
    teacherDescLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [teacherDescLab sizeToFit];
    [whiteV addSubview:teacherDescLab];
    
    UILabel *teacherPhoneLab = [[UILabel alloc]initWithFrame:CGRectMake(teacherDescLab.maxX + WIDTH_PT(25), teacherLab.y, WIDTH_PT(100), HEIGHT_PT(10))];
    teacherPhoneLab.font = [UIFont systemFontOfSize:FONT_PT(16)];
    teacherPhoneLab.text = self.infoDic[@"project_manager_tel"];
    teacherPhoneLab.textColor = [UIColor colorWithHexString:@"#333333"];
    [teacherPhoneLab sizeToFit];
    [whiteV addSubview:teacherPhoneLab];


    return cell;
}

- (UITableViewCell *)fourthSectionCell{
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"UITableViewCell3"];
    for (UIView *subview in cell.contentView.subviews) {
        [subview removeFromSuperview];
    }
    
    CGFloat h = HEIGHT_PT(90);

    UIView *contentV = [[UIView alloc]initWithFrame:CGRectMake(WIDTH_PT(10),0, HGScreenWidth-WIDTH_PT(20), HEIGHT_PT(40) + HEIGHT_PT(80)*self.dataAry.count)];
    contentV.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:contentV];
    
    UIView *titleV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, contentV.width, HEIGHT_PT(40))];
    titleV.backgroundColor = HGColor(249, 227, 249, 1);
    [contentV addSubview:titleV];
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:titleV.bounds byRoundingCorners:UIRectCornerTopLeft | UIRectCornerTopRight cornerRadii:CGSizeMake(5, 5)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = titleV.bounds;
    maskLayer.path = maskPath.CGPath;
    titleV.layer.mask = maskLayer;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(10), 0, WIDTH_PT(100), HEIGHT_PT(10))];
    titleLab.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
    titleLab.text = @"项目课程";
    titleLab.textColor = HGColor(82,118, 215, 1);
    [titleLab sizeToFit];
    titleLab.centerY = titleV.centerY;
    [titleV addSubview:titleLab];
    
    CGFloat x = WIDTH_PT(5);
    CGFloat y = 0;
    CGFloat w = contentV.width - WIDTH_PT(10);
    
    UIView *whiteV = [[UIView alloc]initWithFrame:CGRectMake(0, titleV.maxY, contentV.width, h * self.dataAry.count)];
    whiteV.backgroundColor = [UIColor whiteColor];
    whiteV.layer.borderColor = HGColor(249, 202, 168, 1).CGColor;
    whiteV.layer.borderWidth = 1;
    [contentV addSubview:whiteV];

    for (int i = 0; i < self.dataAry.count; i++) {
        
        HGStudentItemModel *model = self.dataAry[i];
        
        y = h * i;
        
        UIView *teacherV = [[UIView alloc]initWithFrame:CGRectMake(x, y, w, h)];
        teacherV.backgroundColor = [UIColor whiteColor];
        teacherV.tag = 1000+i;
        [whiteV addSubview:teacherV];
        
        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickClass:)];
        [teacherV addGestureRecognizer:tapGes];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(x, HEIGHT_PT(8), WIDTH_PT(1000), HEIGHT_PT(10))];
        label.text = model.courseName;
        label.font = [UIFont boldSystemFontOfSize:FONT_PT(16)];
        label.textColor = [UIColor blackColor];
        [label sizeToFit];
        [teacherV addSubview:label];
        
        UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(x, label.maxY+HEIGHT_PT(9), WIDTH_PT(1000), HEIGHT_PT(10))];
        label1.text = model.courseInfo;
        label1.font = [UIFont systemFontOfSize:FONT_PT(14)];
        label1.textColor = [UIColor colorWithHexString:@"#333333"];
        [label1 sizeToFit];
        [teacherV addSubview:label1];

        
        UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(x, label1.maxY+HEIGHT_PT(8), WIDTH_PT(1000), HEIGHT_PT(10))];
        label2.text = [NSString stringWithFormat:@"主讲人/主持人:%@",model.teacher];
        label2.font = [UIFont systemFontOfSize:FONT_PT(14)];
        label2.textColor = [UIColor colorWithHexString:@"#333333"];
        [label2 sizeToFit];
        label2.y = h - label2.height - HEIGHT_PT(8);
        [teacherV addSubview:label2];
        
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
        return HEIGHT_PT(150);
    }else if (indexPath.section==1){
        if (self.secondSectionAry.count) {
            return HEIGHT_PT(40);
        }
        return HEIGHT_PT(140);
    }else if(indexPath.section==2){
        return HEIGHT_PT(230);
    }else{
        return HEIGHT_PT(40) + HEIGHT_PT(90)*self.dataAry.count;
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
    return HEIGHT_PT(10);
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1f;
}

- (void)btnClick:(anyButton *)sender{
    
    if (self.secondSectionAry.count) {
        NSString *title = sender.titleLabel.text;
        NSInteger tag = 0;
        if ([title isEqualToString:@"成绩单"]||[title isEqualToString:@"班级成绩单"]) {
            tag = 1;
        }else if ([title isEqualToString:@"接待确认单"]){
            tag = 2;
        }
        if (self.block) {
            self.block(tag);
        }
        return;
    }
    
    NSLog(@"%@",sender.titleLabel.text);
    if ([sender.titleLabel.text isEqualToString:@"成绩单"]) {
        HGMyPointController *vc = [[HGMyPointController alloc]init];
        vc.user_id = [HGUserDefaults objectForKey:HGUserID];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"项目资料"]) {
        HGItemDataController *vc = [[HGItemDataController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"学员手册"]) {
        if ([self.infoDic[@"project_manualUrl"] isNull]) {
            [SVProgressHUD showErrorWithStatus:@"资源地址无效"];
            return;
        }
        HGWebController *vc = [[HGWebController alloc]init];
        vc.url = self.infoDic[@"project_manualUrl"];
        vc.titleStr = [self.infoDic[@"project_manualName"] isNull]?@"学员手册":self.infoDic[@"project_manualName"];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([sender.titleLabel.text isEqualToString:@"餐饮签退"]) {
        HGContactUSViewController *vc = [[HGContactUSViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)clickClass:(UITapGestureRecognizer *)ges{
    UIView *view = ges.view;
    HGStudentItemModel *model = self.dataAry[view.tag - 1000];
    HGClassDetailController *vc = [[HGClassDetailController alloc]init];
    vc.course_id = model.courseId;
    [self.navigationController pushViewController:vc animated:YES];
}

- (UIImage *)imageWithName:(NSString *)name{
    NSDictionary *imageDic = @{@"接待确认单":@"icon_manual",@"班级成绩单":@"icon_report",@"成绩单":@"icon_report"};
    return [UIImage imageNamed:imageDic[name]];
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
