//
//  HGCPWViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/31.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCPWViewController.h"
#import "HGLable.h"
#import "HGHttpTool.h"
#import "SVProgressHUD.h"
#import "HGLoginController.h"
@interface HGCPWViewController ()<UITextFieldDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UITextField *account;
@property (nonatomic,weak) UITextField *oldPW;
@property (nonatomic,weak) UITextField *UP1;
@property (nonatomic,weak) UITextField *UP2;
@property (nonatomic ,assign) CGFloat KH;
@end

@implementation HGCPWViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    UITextField *account = [[UITextField alloc]init];
    account.borderStyle = UITextBorderStyleRoundedRect;
    account.placeholder = [NSString stringWithFormat:@"用户名:         %@",[HGUserDefaults stringForKey:HGUserAccount]] ;
    account.userInteractionEnabled = NO;
    [account setValue:[UIColor grayColor] forKeyPath:@"_placeholderLabel.textColor"];
    account.leftViewMode = UITextFieldViewModeAlways;
    [account setValue:[UIFont boldSystemFontOfSize:16] forKeyPath:@"_placeholderLabel.font"];
    //account.backgroundColor = [UIColor redColor];
    self.account = account;
    CGFloat W = HGScreenWidth - 40;
    account.frame = CGRectMake(20, 84,W , 40);
    [self.view addSubview:account];
    UITextField *oldPW = [[UITextField alloc]init];
    oldPW.placeholder = @"原始密码";
    oldPW.delegate = self;
    oldPW.autocapitalizationType = UITextAutocapitalizationTypeNone;
    oldPW.borderStyle = UITextBorderStyleRoundedRect;
    oldPW.returnKeyType =UIReturnKeyDone;
    self.oldPW = oldPW;
    oldPW.frame = CGRectMake(20, CGRectGetMaxY(account.frame)+10, W, 40);
    // [oldPW addTarget:self action:@selector(oldPWend) forControlEvents:UIControlEventEditingDidEnd];
    [self.view addSubview:oldPW];
    UITextField *newPW = [[UITextField alloc]init];
    newPW.placeholder = @"新密码";
    newPW.delegate = self;
    newPW.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPW.returnKeyType = UIReturnKeyDone;
    newPW.borderStyle = UITextBorderStyleRoundedRect;
    self.UP1 = newPW;
    newPW.frame = CGRectMake(20, CGRectGetMaxY(oldPW.frame)+10, W, 40);
    [self.view addSubview:newPW];
    UITextField *newPWA = [[UITextField alloc]init];
    newPWA.placeholder =@"请再次输入新密码";
    newPWA.returnKeyType = UIReturnKeyDone;
    newPWA.autocapitalizationType = UITextAutocapitalizationTypeNone;
    newPWA.borderStyle  = UITextBorderStyleRoundedRect;
    newPWA.delegate = self;
    self.UP2 = newPWA;
    newPWA.frame = CGRectMake(20, CGRectGetMaxY(newPW.frame)+10, W, 40);
    [self.view addSubview:newPWA];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom ];
    but.frame = CGRectMake(20, CGRectGetMaxY(newPWA.frame)+10, W, 40);
    [but setTitle:@"修改" forState:UIControlStateNormal];
    [self.view addSubview:but];
    //but.backgroundColor = [UIColor redColor];
    [but setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    
    
    
}
-(void)clickBut:(UIButton *)but
{
    NSString *PW = [HGUserDefaults objectForKey:HGUserPassWord];
    if (self.UP1.text.length == 0&&self.UP2.text.length == 0) {
        [SVProgressHUD showErrorWithStatus:@"密码不能为空"];
    }else
    {
        if ([self.oldPW.text isEqualToString:PW]&&[self.UP1.text isEqualToString:self.UP2.text]) {
            NSString *url = [HGURL stringByAppendingString:@"User/pwdChange.do"];
            NSString *user_id = [HGUserDefaults stringForKey:HGUserID];
            HGLog(@"%@-%@-%@",user_id,self.oldPW.text,self.UP1.text);
            [HGHttpTool POSTWithURL:url parameters:@{@"user_id":user_id,@"oldPassword":self.oldPW.text,@"newPassword":self.UP1.text} success:^(id responseObject) {
                NSString *status = [responseObject objectForKey:@"status"];
                if ([status isEqualToString:@"1"]) {
                    [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"message"]];
//                    [HGUserDefaults setObject:self.UP1.text forKey:HGUserPassWord];
//                    HGLoginController *login = [[HGLoginController alloc]init];
//                    [self presentViewController:login animated:YES completion:nil];
                    [self backLogin];
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
    NSDictionary *inf = [not userInfo];
    NSValue *value = [inf objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardF = [value CGRectValue];
    CGFloat keyboardH = keyboardF.size.height;
    self.KH = keyboardH;
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(handelPan:)];
    if ([pan respondsToSelector:@selector(locationInView:)]) {
        pan.maximumNumberOfTouches = NSIntegerMax;
        pan.minimumNumberOfTouches = 1;
        pan.delegate = self;
        [self.view addGestureRecognizer:pan];
    }
    
    
    //[self.view addGestureRecognizer:swipeUp];
    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelDiction:)];
    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
    swipeDown.delegate = self;
    swipeDown.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:swipeDown];
    //[swipeDown requireGestureRecognizerToFail:pan];
    [pan requireGestureRecognizerToFail:swipeDown];
    return YES;
}
//允许pan 和swipe两种相似的手势共存是调用
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}
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
-(void)handelPan:(UIPanGestureRecognizer *)recognizer
{
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
        {
            HGLog(@"began");
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            //HGLog(@"change- %f",self.KH);
            CGPoint translation = [recognizer translationInView:self.view];
            if ((self.view.y + translation.y<=0)&&(self.view.y + translation.y> -self.KH)) {
                self.view.y += translation.y ;
            }
            
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        }
            break;
        case UIGestureRecognizerStateEnded:
        {
            HGLog(@"end");
        }
            break;
        default:
            break;
    }
}
//下滑swipe 手势
-(void)handelDiction:(UISwipeGestureRecognizer *)recognizer
{
    HGLog(@"swipdown");
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
