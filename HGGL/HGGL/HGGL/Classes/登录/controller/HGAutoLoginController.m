//
//  HGAutoLoginController.m
//  HGGL
//
//  Created by taikang on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGAutoLoginController.h"
#import "HGTeacherHomeController.h"
#import "HGNavigationController.h"
#import "HGTabBarViewController.h"
#import "HGLoginController.h"

@interface HGAutoLoginController ()

@end

@implementation HGAutoLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageV.image = [UIImage imageNamed:@"icon_splash1.jpg"];
    [self.view addSubview:imageV];
    [self login:nil];
}

- (void)login:(UIButton *)sender{
    
    [SVProgressHUD showWithStatus:@"登录中..."];
    NSString *account = [HGUserDefaults objectForKey:HGUserName];
    NSString *passWord = [HGUserDefaults objectForKey:HGUserPassWord];
    [HGHttpTool POSTWithURL:[HGURL stringByAppendingString:@"User/Login.do"] parameters:@{@"account":account,@"password":passWord} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSLog(@"登录信息\n %@",responseObject);
        if ([responseObject[@"data"] isNull]||[responseObject[@"status"] isEqualToString:@"-1"]) {
            [SVProgressHUD showErrorWithStatus:responseObject[@"message"]];
            HGLoginController *vc =[[HGLoginController alloc]init];
            HGKeywindow.rootViewController = vc;
            return ;
        }
        [SVProgressHUD showSuccessWithStatus:responseObject[@"message"]];
        NSDictionary *dict1 = responseObject[@"data"];
        NSDictionary *dict = [dict1 changeValueToString];
        
        [HGUserDefaults setObject:dict[@"user_id"] forKey:HGUserID];
        [HGUserDefaults setObject:dict[@"user_name"] forKey:HGUserName];
        [HGUserDefaults setObject:dict[@"user_type"] forKey:HGUserType];
        [HGUserDefaults setObject:dict[@"real_name"] forKey:HGRealName];
        if (![dict[@"project_id"] isNull]) {
            [HGUserDefaults setObject:dict[@"project_id"] forKey:HGProjectID];
        }
        [HGUserDefaults setObject:account forKey:HGUserAccount];
        [HGUserDefaults setObject:passWord forKey:HGUserPassWord];
        [HGUserDefaults synchronize];
        if ([dict[@"user_type"] isEqualToString:@"1"]) {
            HGTeacherHomeController *vc =[[HGTeacherHomeController alloc]init];
            HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:vc];
            HGKeywindow.rootViewController = nav;
        }else if ([dict[@"user_type"] isEqualToString:@"3"]){
            HGTabBarViewController *vc = [[HGTabBarViewController alloc]init];
            HGKeywindow.rootViewController = vc;
        }
    } failure:^(NSError *error) {
        HGLoginController *vc =[[HGLoginController alloc]init];
        HGKeywindow.rootViewController = vc;
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
