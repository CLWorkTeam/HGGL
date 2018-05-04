//
//  HGNavigationController.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGNavigationController.h"
#import "HGHttpTool.h"
#import "UIImage+image.h"
#import "HGBarBut.h"

@interface HGNavigationController ()<UINavigationControllerDelegate>
@property (nonatomic,strong) id popDelegate;
@end

@implementation HGNavigationController

+(void)initialize
{
//    UINavigationBar *bar = [UINavigationBar appearance];
//    bar.barTintColor = HGMainColor;
    UIBarButtonItem *butItem = [UIBarButtonItem appearance];
    NSMutableDictionary *attribute = [NSMutableDictionary dictionary];
    attribute[NSFontAttributeName] = [UIFont systemFontOfSize:FONT_PT(14)];
    attribute[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [butItem setTitleTextAttributes:attribute forState:UIControlStateNormal];
    NSMutableDictionary *disableDict = [NSMutableDictionary dictionary];
    disableDict[NSForegroundColorAttributeName] = [UIColor whiteColor];
    
    // 给模型设置富文本属性(可以设置字符串的一些颜色,字体大小)
    [butItem setTitleTextAttributes:disableDict forState:UIControlStateDisabled];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationBar.titleTextAttributes = dict;
    
    //    }
    
    
    //NSLog(@"nav");
    _popDelegate = self.interactivePopGestureRecognizer.delegate;
    
    self.delegate = self;
//    NSTimer *timer = [NSTimer timerWithTimeInterval:30 target:self selector:@selector(loadUnreade) userInfo:nil repeats:YES];
//    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    //[self.navigationBar setBackgroundColor:[UIColor redColor]];
    //self.navigationBar setBackgroundImage: forBarMetrics:
    //CGRect rect = self.navigationBar.frame;
    //NSLog(@"导航栏%f",self.navigationBar.frame.size.height);
    
    // Do any additional setup after loading the view.
    //    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithTitle:@"协同办公" style:UIBarButtonItemStyleDone target:self action:@selector(leftButClick)];
    //    UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithTitle:@"当日课表" style:UIBarButtonItemStyleDone target:self action:@selector(rightButClick)];
    //    self.navigationItem.leftBarButtonItem = letfBut;
    //    self.navigationItem.rightBarButtonItem = rightBut;
    
}
-(void)loadUnreade
{
    NSString *url = [HGURL stringByAppendingString:@"MsgPush/getMessage.do"];
    //HGLog(@"timer");
    if ([HGUserDefaults objectForKey:HGUserID]) {
        [HGHttpTool POSTWithURL:url parameters:@{@"user_id":[HGUserDefaults objectForKey:HGUserID]} success:^(id responseObject) {
            NSString *status = [responseObject objectForKey:@"status"];
            if ([status isEqualToString:@"1"]) {
                NSString *data = [responseObject objectForKey:@"data"];
                UILocalNotification *notification = [[UILocalNotification alloc]init];
                notification.timeZone = [NSTimeZone defaultTimeZone];
                notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:1];
                notification.alertBody = [NSString stringWithFormat:@"您有%@条未读通知",data] ;
                notification.alertAction =  [NSString stringWithFormat:@"您有%@条未读通知",data];
                [[UIApplication sharedApplication] scheduleLocalNotification:notification];
            }
        } failure:^(NSError *error) {
        }];
    }
    
    
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    // 只要覆盖了导航条系统自带的左边按钮,这个代理就会做些事情
    // 实现滑动返回功能
    // 直接删除,系统的某些相当于不会调用
    if (viewController == self.viewControllers[0]) { // 是根控制器
        self.interactivePopGestureRecognizer.delegate = _popDelegate;
    }else{
        self.interactivePopGestureRecognizer.delegate = nil;
    }
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.navigationBar.barTintColor = HGMainColor;
    // self.navigationBar.tintColor = [UIColor clearColor];
    //[self.navigationBar setBackgroundColor:[UIColor redColor]];
    if (!self.viewControllers.count) {
        
//        if ([viewController isKindOfClass:NSClassFromString(@"HGTeacherHomeController")]||[viewController isKindOfClass:NSClassFromString(@"HGStudentHomeController")]) {
//
//        }else
//        {
//
//        }
        
//
//        HGBarBut *right = [HGBarBut initWithColor:HGColor(205,0,36,1) andSelColor:HGColor(190, 31, 25,1) andTColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:10]];
//        [right setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
//        //self.but = left;
////        [right setTitle:@"消息通知" forState:UIControlStateNormal];
//        [right setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//        right.frame = CGRectMake(0, 0, 50, 40);
//        //right.imageView.bounds = CGRectMake(0, 0,left.height*0.86 , left.height*0.68);
//        [right addTarget:self action:@selector(rightButClick) forControlEvents:UIControlEventTouchUpInside];
//        //[self.navigationBar addSubview:left];
//        UIBarButtonItem *rightBut = [[UIBarButtonItem alloc]initWithCustomView:right];
//        
//        [rightBut setImage:[UIImage imageNamed:@"notice"]];
//        viewController.navigationItem.leftBarButtonItem = letfBut;
//        viewController.navigationItem.rightBarButtonItem = rightBut;
    }else{
        //[self.but removeFromSuperview];
        viewController.hidesBottomBarWhenPushed = YES;
        self.navigationBarHidden = NO;
//        HGBarBut *left = [HGBarBut initWithColor:nil andSelColor:nil andTColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:10]];
        UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
        [left setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
        [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        left.frame = CGRectMake(0, 0, 50, HGNavgationBarH);
        [left addTarget:self action:@selector(leftButClick:) forControlEvents:UIControlEventTouchUpInside];
        UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:left];
        viewController.navigationItem.leftBarButtonItem = letfBut;
        
    }
    
    
    [super pushViewController:viewController animated:YES];
    //    for (UIView *view in HGKeywindow.subviews) {
    //        if ([view isKindOfClass:[MenteeListHeader class]]||[view isKindOfClass:[BlacklogHeader class]]) {
    //            [view removeFromSuperview];
    //        }
    //    }
    
}
-(void)leftButClick:(UIButton *)but
{
    if (self.topViewController.presentingViewController) {
        [self.topViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.topViewController.navigationController popViewControllerAnimated:YES];
    }
}
-(void)rightButClick
{
//    MessageListController *mess = [[MessageListController alloc]init];
//    UINavigationController *nav = [[UINavigationController  alloc]initWithRootViewController:mess];
//    [self presentViewController:nav animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
