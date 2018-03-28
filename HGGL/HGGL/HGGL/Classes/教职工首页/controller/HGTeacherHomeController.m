//
//  HGTeacherHomeController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTeacherHomeController.h"
#import "HGItemPlanController.h"
#import "HGWebController.h"
#import "TKButton.h"

@interface HGTeacherHomeController ()

@property (nonatomic,strong) NSArray *menuAry;
@property (nonatomic,strong) NSArray *colorAry;
@property (nonatomic,strong) UIImageView *imageV;


@end

@implementation HGTeacherHomeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.menuAry=@[@"行政办公",@"项目计划",@"项目信息",@"信息共享",@"科研信息",@"师资信息",@"学员信息",@"每周菜谱",@"校园风采"];
 self.colorAry=@[@"#80be1e",@"#9d76ec",@"#cbc31e",@"#dfb1dd",@"#f2936f",@"#a91f9e",@"#7cdaa1",@"#6ccbfb",@"#25f8ca"];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, 64)];
    backV.backgroundColor = HGMainColor;
    [self.view addSubview:backV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HGStautsBarH, HGScreenWidth, 44)];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [backV addSubview:label];

    UIButton *persionBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    persionBtn.frame = CGRectMake(20, HGStautsBarH+5, 30, 30);
    [persionBtn setImage:[UIImage imageNamed:@"icon_top_personal"] forState:UIControlStateNormal];
    persionBtn.backgroundColor = HGMainColor;
    [persionBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:persionBtn];
    
    UIButton *messageBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    messageBtn.frame = CGRectMake(HGScreenWidth-45, persionBtn.y, 30, 30);
    [messageBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    messageBtn.backgroundColor = HGMainColor;
    [messageBtn addTarget:self action:@selector(clickMessage:) forControlEvents:UIControlEventTouchUpInside];
    [backV addSubview:messageBtn];
    
    UIImageView *imageV =[[UIImageView alloc]initWithFrame:CGRectMake(0, backV.maxY, HGScreenWidth, 150)];
    imageV.image = [UIImage imageNamed:@"WechatIMG79.jpeg"];
    self.imageV = imageV;
    [self.view addSubview:imageV];
    

    [self addMenuBtn];
}

- (void)addMenuBtn{
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, self.imageV.maxY, HGScreenWidth, HGScreenHeight-self.imageV.maxY)];
    backV.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:backV];
    
    CGFloat x = 0;
    CGFloat y = self.imageV.maxY;
    CGFloat w = HGScreenWidth/3;
    CGFloat h = (HGScreenHeight-self.imageV.maxY)/3;
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
    }else if ([title isEqualToString:@"行政办公"]){
        HGWebController *vc = [[HGWebController alloc]init];
        vc.titleStr = @"行政办公";
        vc.url = @"https://www.baidu.com";
        [self.navigationController pushViewController:vc animated:YES];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)imageWithTitle:(NSString *)title{
    UIImage *image = nil;
    if ([title isEqualToString:@"行政办公"]) {
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
