//
//  HGTeacherHomeController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTeacherHomeController.h"
#import "HGItemPlanController.h"
#import "HGWeekMenuController.h"
#import "SDWebImageManager.h"
#import "HGWebController.h"
#import "TKButton.h"
#import "HGMyDataViewController.h"
#import "HGSchoolFCController.h"
#import "HGPersonalController.h"
#import "HGSourceViewController.h"
#import "ProjectListViewController.h"
#import "TeachListViewController.h"
#import "MenteeListViewController.h"
#import "ResearchViewController.h"
#import "MessageListController.h"
#import "AppDelegate.h"
#import "TKBanner.h"
@interface HGTeacherHomeController ()

@property (nonatomic,strong) NSArray *menuAry;
@property (nonatomic,strong) NSArray *colorAry;
@property (nonatomic,weak) TKBanner *banner;
@property (nonatomic,weak) UIImageView *imageV;

@end

@implementation HGTeacherHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuAry=@[@"协同办公",@"项目计划",@"项目信息",@"信息共享",@"科研信息",@"师资信息",@"学员信息",@"每周菜谱",@"校园风采"];
    self.colorAry=@[@"#80be1e",@"#9d76ec",@"#cbc31e",@"#dfb1dd",@"#f2936f",@"#a91f9e",@"#7cdaa1",@"#6ccbfb",@"#25f8ca"];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, 44+HGStautsBarH)];
    backV.backgroundColor = HGMainColor;
    [self.view addSubview:backV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HGStautsBarH, HGScreenWidth, 44)];
    label.text = @"首页";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [backV addSubview:label];

    UIButton *persionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    persionBtn.frame = CGRectMake(20, HGStautsBarH+5, 30, 30);
    [persionBtn setImage:[UIImage imageNamed:@"icon_top_personal"] forState:UIControlStateNormal];
    persionBtn.backgroundColor = HGMainColor;
    [persionBtn addTarget:self action:@selector(clickPersion) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:persionBtn];
    
    UIButton *messageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(HGScreenWidth-45, persionBtn.y, 30, 30);
    [messageBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    messageBtn.backgroundColor = HGMainColor;
    [messageBtn addTarget:self action:@selector(clickMessage:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:messageBtn];
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, backV.maxY, HGScreenWidth, HEIGHT_PT(150))];
    if (HGScreenWidth>320) {
        imageV.height = HEIGHT_PT(200);
    }
    self.imageV = imageV;
    [self.view addSubview:imageV];
    
    
    NSString *url = [HGURL stringByAppendingString:@"Banner/getBannerInfo.do"];
    NSString *type = [HGUserDefaults objectForKey:HGUserType];
    [HGHttpTool POSTWithURL:url parameters:@{@"type":type} success:^(id responseObject) {
        NSLog(@"%@---%@\n---\n%@",[self class],url,responseObject);
    
        if ([responseObject[@"status"] isEqualToString:@"1"]) {
            NSMutableArray *bannerArr = [NSMutableArray array];
            for (NSDictionary *dict1 in responseObject[@"data"]) {
                NSString *resultUrl = dict1[@"imageUrl"];
                NSString *imgUrl = [NSString stringWithFormat:@"%@%@",HGURL,resultUrl];
//                [bannerArr addObject:imgUrl];
                
            }
            
            TKBanner *banner = [[TKBanner alloc]init];
            self.banner = banner;
            banner.needTimer = YES;
            banner.needPageControl = YES;
            banner.frame = self.imageV.frame;
            [self.imageV removeFromSuperview];
            self.banner = banner;
            banner.imageArr = bannerArr;
//            [self.view addSubview:banner];
//            NSString *resultUrl = [responseObject[@"data"] firstObject][@"imageUrl"];
//            NSString *imgUrl = [NSString stringWithFormat:@"%@%@",HGURL,resultUrl];
//            [imageV sd_setImageWithURL:[NSURL URLWithString:imgUrl] placeholderImage:[UIImage imageNamed:@"WechatIMG79.jpeg"]  completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
//                if (error) {
//                    imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
//                }
//            }];
        }else{
            imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
        }
    } failure:^(NSError *error) {
        imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
    }];

    [self addMenuBtn];
}
-(void)clickMessage:(UIButton *)button
{
    MessageListController *message = [[MessageListController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    AppDelegate *del = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    if (del.presentBlock) {
        
        del.presentBlock();
        
        del.presentBlock = nil;
        
    }
}

//点击个人中心
- (void)clickPersion{
    
    HGPersonalController *vc = [[HGPersonalController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addMenuBtn{
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, self.imageV.maxY, HGScreenWidth, HGScreenHeight-self.imageV.maxY)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    CGFloat x = 0;
    CGFloat y = self.imageV.maxY;
    CGFloat w = HGScreenWidth/3;
    CGFloat h = w;//(HGScreenHeight-self.imageV.maxY)/3;
    UIImage *image = nil;
    NSString *title = nil;
    UIColor *color = nil;
    for (int i =0; i<3; i++) {
        for (int j=0; j<3; j++) {
            x = w * j;
            y = h * i;
            if (i==0) {
                image = [self imageWithTitle:self.menuAry[j]];
                title = self.menuAry[j];
                color = [UIColor colorWithHexString:self.colorAry[j]];
            }else if (i==1){
                image = [self imageWithTitle:self.menuAry[j+3]];
                title = self.menuAry[j+3];
                color = [UIColor colorWithHexString:self.colorAry[j+3]];
            }else{
                image = [self imageWithTitle:self.menuAry[j+6]];
                title = self.menuAry[j+6];
                color = [UIColor colorWithHexString:self.colorAry[j+6]];
            }
            TKUpDownButton *btn = [[TKUpDownButton alloc]initWithImage:image title:title color:color];
            btn.frame = CGRectMake(x, y, w, h);
            [btn addTarget:self action:@selector(clickMenu:) forControlEvents:UIControlEventTouchUpInside];
            [backV addSubview:btn];
        }
    }
}

- (void)clickMenu:(TKButton *)sender{
    
    NSString *title = sender.titleLab.text;
    if ([title isEqualToString:@"项目计划"]) {
        HGItemPlanController *vc = [[HGItemPlanController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"协同办公"]){
        if ([[HGUserDefaults objectForKey:HGOpenFun] isEqualToString:@"1"]) {
            [SVProgressHUD showWithStatus:@"请稍后..."];
            NSString *url = @"http://10.93.1.190:8081/t9/mobile/act/T9PdaLogin/login.act";
            [HGHttpTool POSTWithURL:url parameters:@{@"USERNAME":[HGUserDefaults objectForKey:HGUserName],@"PASSWORD":@""} success:^(id responseObject) {
                if ([responseObject[@"status"] boolValue]){
                    HGWebController *vc = [[HGWebController alloc]init];
                    vc.titleStr = @"协同办公";
                    vc.url = @"http://10.93.1.190:8081/t9/mobile/workflow/act/T9PdaWorkflowIndexAct/index.act";
                    [self.navigationController pushViewController:vc animated:YES];
                }else{
                    [SVProgressHUD showErrorWithStatus:@"协同办公暂时无法查看，请您检查登录的账号"];
                }
            } failure:^(NSError *error) {
                [SVProgressHUD showErrorWithStatus:@"协同办公暂时无法查看，请您连接学院内网"];
            }];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"该功能尚未开放，敬请期待"];
            
        }
        
    }else if ([title isEqualToString:@"每周菜谱"]){
        HGWeekMenuController *vc = [[HGWeekMenuController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"校园风采"]){
        HGSchoolFCController *vc =[[HGSchoolFCController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }else if ([title isEqualToString:@"信息共享"])
    {
        HGSourceViewController *source = [[HGSourceViewController alloc]init];
        [self.navigationController pushViewController:source animated:YES];
        
    }else if ([title isEqualToString:@"项目信息"])
    {
        ProjectListViewController *project = [[ProjectListViewController alloc]init];
        [self.navigationController pushViewController:project animated:YES];
        
    }else if ([title isEqualToString:@"科研信息"])
    {
        if ([[HGUserDefaults objectForKey:HGOpenFun] isEqualToString:@"1"]) {
            ResearchViewController *resa = [[ResearchViewController alloc]init];
            [self.navigationController pushViewController:resa animated:YES];
        }else
        {
            [SVProgressHUD showInfoWithStatus:@"该功能尚未开放，敬请期待"];
            
        }
        
        
    }else if ([title isEqualToString:@"师资信息"])
    {
        TeachListViewController *project = [[TeachListViewController alloc]init];
        [self.navigationController pushViewController:project animated:YES];
        
    }else if ([title isEqualToString:@"学员信息"])
    {
        MenteeListViewController *mentee = [[MenteeListViewController alloc]init];
        [self.navigationController pushViewController:mentee animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithTitle:(NSString *)title{
    UIImage *image = nil;
    if ([title isEqualToString:@"协同办公"]) {
        image = [UIImage imageNamed:@"icon_administration"];
    }else if ([title isEqualToString:@"项目计划"]){
        image = [UIImage imageNamed:@"icon_new_plan"];
    }else if ([title isEqualToString:@"项目信息"]){
        image = [UIImage imageNamed:@"icon_new_project"];
    }else if ([title isEqualToString:@"信息共享"]){
        image = [UIImage imageNamed:@"icon_new_share"];
    }else if ([title isEqualToString:@"科研信息"]){
        image = [UIImage imageNamed:@"icon_new_keyan"];
    }else if ([title isEqualToString:@"师资信息"]){
        image = [UIImage imageNamed:@"icon_new_teacher"];
    }else if ([title isEqualToString:@"学员信息"]){
        image = [UIImage imageNamed:@"icon_new_student"];
    }else if ([title isEqualToString:@"每周菜谱"]){
        image = [UIImage imageNamed:@"icon_new_menu"];
    }else if ([title isEqualToString:@"校园风采"]){
        image = [UIImage imageNamed:@"icon_new_active"];
    }
    return image;
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
