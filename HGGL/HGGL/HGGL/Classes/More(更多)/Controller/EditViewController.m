//
//  EditViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "EditViewController.h"
#import "HGLable.h"
#import "ZKRTextField.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "HGLoginController.h"
@interface EditViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UITextField *account;
@property (nonatomic,weak) UITextField *oldPW;
@property (nonatomic,weak) UITextField *UP1;
@property (nonatomic,weak) UITextField *UP2;
@property (nonatomic ,assign) CGFloat KH;
@property (nonatomic,weak) UIView *content;

@end

@implementation EditViewController
//设置NavItemBtn
-(void)setupLeftNavItem{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
}
//返回前一页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"账号密码修改";

    [self setupLeftNavItem];
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillChangeFrameNotification object:nil];
    UIView *content = [[UIView alloc]init];
    content.bounds = CGRectMake(0, 0, HGScreenWidth, 40*5+10*4);
    self.content.backgroundColor = [UIColor redColor];
    content.center = CGPointMake(HGScreenWidth/2, HGScreenHeight/2);
    [self.view addSubview:content];
    self.content = content;
    UITextField *account = [[UITextField alloc]init];
    account.borderStyle = UITextBorderStyleRoundedRect;
    account.placeholder = [NSString stringWithFormat:@"用户名:         %@",[HGUserDefaults stringForKey:@"account"]] ;
    account.userInteractionEnabled = NO;
    [account setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    account.leftViewMode = UITextFieldViewModeAlways;
    [account setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //account.backgroundColor = [UIColor redColor];
    self.account = account;
    CGFloat W = HGScreenWidth - 40;
    account.frame = CGRectMake(20, 0,W , 40);
    [self.content addSubview:account];
    UITextField *oldPW = [[UITextField alloc]init];
    oldPW.placeholder = @"原始密码";
    oldPW.delegate = self;
    oldPW.autocapitalizationType = UITextAutocapitalizationTypeNone;
    oldPW.borderStyle = UITextBorderStyleRoundedRect;
    oldPW.returnKeyType =UIReturnKeyDone;
    self.oldPW = oldPW;
    oldPW.frame = CGRectMake(20, CGRectGetMaxY(account.frame)+10, W, 40);
   // [oldPW addTarget:self action:@selector(oldPWend) forControlEvents:UIControlEventEditingDidEnd];
    [self.content addSubview:oldPW];
    UITextField *newPW = [[UITextField alloc]init];
    newPW.placeholder = @"新密码";
    newPW.delegate = self;
    newPW.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPW.returnKeyType = UIReturnKeyDone;
    newPW.borderStyle = UITextBorderStyleRoundedRect;
    self.UP1 = newPW;
    newPW.frame = CGRectMake(20, CGRectGetMaxY(oldPW.frame)+10, W, 40);
    [self.content addSubview:newPW];
    UITextField *newPWA = [[UITextField alloc]init];
    newPWA.placeholder =@"请再次输入新密码";
    newPWA.returnKeyType = UIReturnKeyDone;
    newPWA.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPWA.borderStyle  = UITextBorderStyleRoundedRect;
    newPWA.delegate = self;
    self.UP2 = newPWA;
    newPWA.frame = CGRectMake(20, CGRectGetMaxY(newPW.frame)+10, W, 40);
    [self.content addSubview:newPWA];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom ];
    but.frame = CGRectMake(20, CGRectGetMaxY(newPWA.frame)+10, W, 40);
    [but setTitle:@"修改" forState:UIControlStateNormal];
    [self.content addSubview:but];
    //but.backgroundColor = [UIColor redColor];
    [but setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillChangeFrameNotification object:nil];
}
-(void)clickBut:(UIButton *)but
{
    NSString *PW = [HGUserDefaults objectForKey:@"passWord"];
    if (self.UP1.text.length == 0&&self.UP2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }else
    {
        if ([self.oldPW.text isEqualToString:PW]&&[self.UP1.text isEqualToString:self.UP2.text]) {
            NSString *url = [HGURL stringByAppendingString:@"User/pwdChange.do"];
            NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
            HGLog(@"%@-%@-%@",user_id,self.oldPW.text,self.UP1.text);
            
            [HGHttpTool POSTWithURL:url parameters:@{@"user_id":user_id,@"oldPassword":self.oldPW.text,@"newPassword":self.UP1.text,@"tokenval":user_id} success:^(id responseObject) {
                NSString *status = [responseObject objectForKey:@"status"];
                if ([status isEqualToString:@"1"]) {
                    [SVProgressHUD  showSuccessWithStatus:[responseObject objectForKey:@"message"]];
                    [HGUserDefaults setObject:self.UP1.text forKey:@"passWord"];
                    HGLoginController *login = [[HGLoginController alloc]init];
                    [self presentViewController:login animated:YES completion:nil];
                }else if ([status isEqualToString:@"-1"])
                {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
                }else if ([status isEqualToString:@"-2"])
                {
                    [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
                }
            } failure:^(NSError *error) {
                HGLog(@"%@",error);
                [SVProgressHUD showErrorWithStatus:@"请检查网络连接设置"];
                
            }];
        }else if (![self.oldPW.text isEqualToString:PW])
        {
            [SVProgressHUD showErrorWithStatus:@"原始密码输入有误"];
        }else if (![self.UP1.text isEqualToString:self.UP2.text])
        {
            [SVProgressHUD showErrorWithStatus:@"两次新密码输入不相同，请重新输入"];
        }
    }


}
-(void)keyboardWillShow:(NSNotification *)not
{
    NSDictionary *userInfo = not.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
//    HGLog(@"%f--%f",keyboardF.size.height,HGScreenHeight - CGRectGetMaxY(self.content.frame));
    [UIView animateWithDuration:duration animations:^{
        // 工具条的Y值 == 键盘的Y值 - 工具条的高度
        if (keyboardF.size.height > (HGScreenHeight - CGRectGetMaxY(self.content.frame)-50)) {
            self.content.y -= CGRectGetMaxY(self.content.frame)- keyboardF.origin.y;
            HGLog(@"%f",keyboardF.origin.y);
        }
        if (keyboardF.origin.y == HGScreenHeight) {
            self.content.y = HGScreenHeight/2-(40*5+10*4)/2;
        }
    }];
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    
//    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
//    if ([pan respondsToSelector:@selector(locationInView:)]) {
//        pan.maximumNumberOfTouches = NSIntegerMax;
//        pan.minimumNumberOfTouches = 1;
//        pan.delegate = self;
//        [self.view addGestureRecognizer:pan];
//    }
    
    
    //[self.view addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelDiction:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    swipeDown.delegate = self;
    swipeDown.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:swipeDown];
    //[swipeDown requireGestureRecognizerToFail:pan];
//    [pan requireGestureRecognizerToFail:swipeDown];
    return YES;
}
//允许pan 和swipe两种相似的手势共存是调用
//-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
//{
//    return YES;
//}
//实现用户点击return就将键盘缩下去
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //取消成为第一响应者（取消的话 键盘就会消失）
    [textField resignFirstResponder];
    self.view.y = 0;
    for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
        [self.view removeGestureRecognizer:recognizer];
        HGLog(@"移除");
    }
    return YES;
}

//pan手势
//-(void)handelPan:(UIPanGestureRecognizer *)recognizer
//{
//    switch (recognizer.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            HGLog(@"began");
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//        {
//            //HGLog(@"change- %f",self.KH);
//            CGPoint translation = [recognizer translationInView:self.view];
//            if ((self.view.y + translation.y<=0)&&(self.view.y + translation.y> -self.KH)) {
//                self.view.y += translation.y ;
//            }
//            
//            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
//        }
//            break;
//        case UIGestureRecognizerStateEnded:
//        {
//            HGLog(@"end");
//        }
//            break;
//        default:
//            break;
//    }
//}
////下滑swipe 手势
-(void)handelDiction:(UISwipeGestureRecognizer *)recognizer
{
//    HGLog(@"swipdown");
    if (recognizer.direction == UISwipeGestureRecognizerDirectionDown ) {
        
        [self.view endEditing:YES];
        self.view.y = 0;
        for (UIGestureRecognizer *recognizer in self.view.gestureRecognizers) {
            [self.view removeGestureRecognizer:recognizer];
            HGLog(@"移除");
        }
    }
    
}
-(void)backLogin
{
    HGLoginController *login = [[HGLoginController alloc]init];
    [UIApplication sharedApplication].keyWindow.rootViewController = login;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
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
