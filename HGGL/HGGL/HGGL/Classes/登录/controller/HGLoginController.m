//
//  HGLoginController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGLoginController.h"
#import "HGTeacherHomeController.h"
#import "HGNavigationController.h"
#import "HGTabBarViewController.h"


@interface HGLoginController ()
@property (nonatomic,weak) UITextField *accountTextField;
@property (nonatomic,weak) UITextField *pwTextField;
@end

@implementation HGLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, 64)];
    backV.backgroundColor = HGMainColor;
    [self.view addSubview:backV];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, HGStautsBarH, HGScreenWidth, 44)];
    label.text = @"登录";
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:18];
    [backV addSubview:label];

    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(30, backV.maxY + 100, HGScreenWidth-60, 40)];
    imageV.image = [UIImage imageNamed:@"WechatIMG8"];
    [self.view addSubview:imageV];
    
    UITextField *textF = [[UITextField alloc]initWithFrame:CGRectMake(20, imageV.maxY+50, HGScreenWidth-40, 40)];
    textF.font = [UIFont systemFontOfSize:18];
    textF.placeholder = @"账号";
    textF.borderStyle = UITextBorderStyleRoundedRect;
    textF.clearButtonMode = UITextFieldViewModeAlways;
    [self.view addSubview:textF];
    self.accountTextField = textF;
    
    UITextField *textF1 = [[UITextField alloc]initWithFrame:CGRectMake(textF.x, textF.maxY+20, HGScreenWidth-40, 40)];
    textF1.font = [UIFont systemFontOfSize:18];
    textF1.placeholder = @"密码";
    textF1.borderStyle = UITextBorderStyleRoundedRect;
    textF1.clearButtonMode = UITextFieldViewModeAlways;
    [textF1 setSecureTextEntry:YES];
    [self.view addSubview:textF1];
    self.pwTextField = textF1;

    UIButton *loginBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    loginBtn.frame = CGRectMake(textF.x, textF1.maxY + 30, textF.width, 40);
    [loginBtn setTitle:@"登录" forState:UIControlStateNormal];
    [loginBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    loginBtn.titleLabel.font = [UIFont systemFontOfSize:18];
    loginBtn.backgroundColor = HGMainColor;
    loginBtn.layer.masksToBounds = YES;
    loginBtn.layer.cornerRadius = 5;
    [loginBtn addTarget:self action:@selector(login:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:loginBtn];
    
    anyButton *autoBtn = [anyButton buttonWithType:UIButtonTypeCustom];
    autoBtn.frame = CGRectMake(loginBtn.x, loginBtn.maxY+10, 200, 21);
    [autoBtn setImage:[UIImage imageNamed:@"icon_xuanze"] forState:UIControlStateNormal];
    [autoBtn setImage:[UIImage imageNamed:@"icon_xuanze_check"] forState:UIControlStateSelected];
    [autoBtn setTitle:@"自动登录" forState:UIControlStateNormal];
    [autoBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [autoBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [autoBtn changeImageFrame:CGRectMake(0, 0, 21, 21)];
    [autoBtn changeTitleFrame:CGRectMake(30, 0, 170, 21)];
    [autoBtn addTarget:self action:@selector(autoLogin:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:autoBtn];
    
}

- (void)login:(UIButton *)sender{
    
    
    [SVProgressHUD showWithStatus:@"登录中..."];
//<<<<<<< HEAD
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [SVProgressHUD dismiss];
//
//        HGTabBarViewController *vc = [[HGTabBarViewController alloc]init];
////        HGTeacherHomeController *Vc = [[HGTeacherHomeController alloc]init];
////        HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:Vc];
//        HGKeywindow.rootViewController = vc;
//    });
    NSString *account = self.accountTextField.text;
    NSString *passWord = self.pwTextField.text;
    if (account==nil||account.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入账号"];
        return;
    }
    if (passWord==nil||passWord.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入密码"];
        return;
    }
    [HGHttpTool POSTWithURL:[HGURL stringByAppendingString:@"User/Login.do"] parameters:@{@"account":account,@"password":passWord} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = responseObject[@"data"];
        
        [HGUserDefaults setObject:dict[@"user_id"] forKey:HGUserID];
        [HGUserDefaults setObject:dict[@"user_name"] forKey:HGUserName];
        [HGUserDefaults setObject:dict[@"user_type"] forKey:HGUserType];
        [HGUserDefaults setObject:dict[@"real_name"] forKey:HGRealName];
        [HGUserDefaults setObject:account forKey:HGUserAccount];
        [HGUserDefaults setObject:passWord forKey:HGUserPassWord];
        [HGUserDefaults synchronize];
        HGTabBarViewController *vc = [[HGTabBarViewController alloc]init];
        HGKeywindow.rootViewController = vc;
        HGLog(@"%@",[HGUserDefaults objectForKey:HGUserID]);
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
    }];
//=======
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
////        HGTabBarViewController *vc = [[HGTabBarViewController alloc]init];
//        HGTeacherHomeController *Vc = [[HGTeacherHomeController alloc]init];
//        HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:Vc];
//        HGKeywindow.rootViewController = nav;
//    });
//>>>>>>> eaa6810394b5d6645e04535c949d834b4a76d304
}

- (void)autoLogin:(anyButton *)sender{
    sender.selected = !sender.isSelected;
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
