//
//  AppDelegate.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "AppDelegate.h"
#import "HGLoginController.h"
#import "HGSourceViewController.h"
#import "HGNavigationController.h"
#import "HGAutoLoginController.h"
#import "HGMyDownLoadViewController.h"
#import "HGWebViewController.h"
#import <UserNotifications/UserNotifications.h>
#import "UMessage.h"
#import "UMConfigure.h"
@interface AppDelegate ()<UNUserNotificationCenterDelegate>
@property(assign, nonatomic)UIBackgroundTaskIdentifier backIden;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setSVProgress];
//    [self test];
//    return YES;
    [self setWindow];
    [self UMPushWithLaunchOptions:launchOptions];
//    [UMessage startWithAppkey:@"57734aaee0f55ac2d5000a43" launchOptions:launchOptions];
//    
//    [UMessage registerForRemoteNotifications];
    
    return YES;
}
-(void)setWindow
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    BOOL autoLogin = [HGUserDefaults boolForKey:@"autoLogin"];
    if (autoLogin) {
        HGAutoLoginController *vc = [[HGAutoLoginController alloc]init];
        self.window.rootViewController = vc;
    }else{
        HGLoginController *vc = [[HGLoginController alloc]init];
        self.window.rootViewController = vc;
    }
    [self.window makeKeyAndVisible];
    
    [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleLightContent];
}
-(void)setSVProgress
{
    [SVProgressHUD setMinimumDismissTimeInterval:1];
    [SVProgressHUD setMaximumDismissTimeInterval:2];
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
}
-(void)test
{
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    HGMyDownLoadViewController *source = [[HGMyDownLoadViewController alloc]init];
    HGWebViewController *web = [[HGWebViewController alloc]init];
    
    web.navigationItem.title = @"预览";
    
//    NSString *URL = [HGURL2 stringByAppendingString:model.localUrl];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"泰行销-微海报版块建设（2018-04-12）v0.0.3" ofType:@"docx"];
    web.url = @"http://www.xianbear.com/downfile/%E5%85%B3%E4%BA%8E%E4%BD%93%E8%82%B2%E7%9B%B8%E5%85%B3%E8%AE%BA%E6%96%87%E8%8C%83%E6%96%87%E9%9B%86,%E4%B8%8E%E6%96%B0%E9%97%BB%E9%9B%86%E5%9B%A2%E6%94%B6%E8%B4%AD%E6%9B%BC%E8%81%94%E9%98%9F%E7%9A%84%E8%90%A5%E9%94%80%E5%AD%A6%E7%9B%B8%E5%85%B3%E6%AF%95%E4%B8%9A%E8%AE%BA%E6%96%87%E6%A0%BC%E5%BC%8F%E6%A8%A1%E6%9D%BF%E8%8C%83%E6%96%87.doc";
    HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:web];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
}
- (UIInterfaceOrientationMask)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
{
    if (_isFull) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    
    [self beginTask];
    
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    
    [self endBack];
    
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
//申请后台
-(void)beginTask
{
    
    _backIden = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        
        [self endBack];
        
    }];
}

//注销后台
-(void)endBack
{
    [[UIApplication sharedApplication] endBackgroundTask:_backIden];
    
    _backIden = UIBackgroundTaskInvalid;
}

#pragma mark 友盟推送相关
-(void)UMPushWithLaunchOptions:(NSDictionary *)launchOptions
{
    [UMConfigure initWithAppkey:@"5b3c83f5f43e487306000034" channel:@"App Store"];
//    [UMConfigure initWithAppkey:@"5afe9387b27b0a1ca6000147" channel:@"App Store"];
    
    [UMConfigure setLogEnabled:YES];
    // Push组件基本功能配置
    UMessageRegisterEntity * entity = [[UMessageRegisterEntity alloc] init];
    //type是对推送的几个参数的选择，可以选择一个或者多个。默认是三个全部打开，即：声音，弹窗，角标
    entity.types = UMessageAuthorizationOptionSound|UMessageAuthorizationOptionAlert;
    [UNUserNotificationCenter currentNotificationCenter].delegate=self;
    [UMessage registerForRemoteNotificationsWithLaunchOptions:launchOptions Entity:entity     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
        }else{
        }
    }];
    if (launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey]) {
        NSDictionary *userInfo = launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        [self pushToViewControllerWithTitl:userInfo[@"type"] andMessage:userInfo[@"aps"][@"alert"] with:userInfo[@"hg_url"] WithState:[UIApplication sharedApplication].applicationState];
    }
    
//    [self configUSharePlatforms];
}
//iOS10以下使用这两个方法接收通知
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    [UMessage setAutoAlert:NO];
    if([[[UIDevice currentDevice] systemVersion]intValue] < 10){
        UIApplicationState status = [UIApplication sharedApplication].applicationState;
        if (status == 0) {
            [UMessage didReceiveRemoteNotification:userInfo];
        }else
        {
            [self pushToViewControllerWithTitl:userInfo[@"type"] andMessage:userInfo[@"aps"][@"alert"] with:userInfo[@"hg_url"] WithState:[UIApplication sharedApplication].applicationState];
        }
        
    }
    completionHandler(UIBackgroundFetchResultNewData);
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    NSDictionary * userInfo = notification.request.content.userInfo;
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        [UMessage setAutoAlert:YES];
        //应用处于前台时的远程推送接受
        //必须加这句代码
        
        [UMessage didReceiveRemoteNotification:userInfo];
    }else{
        //应用处于前台时的本地推送接受
    }
    completionHandler(UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}

//iOS10新增：处理后台点击通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    NSDictionary * userInfo = response.notification.request.content.userInfo;
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        //必须加这句代码
//        [UMessage didReceiveRemoteNotification:userInfo];
        [self pushToViewControllerWithTitl:userInfo[@"type"] andMessage:userInfo[@"aps"][@"alert"] with:userInfo[@"hg_url"] WithState:[UIApplication sharedApplication].applicationState];
    }else{
        //应用处于后台时的本地推送接受
    }
}
-(void)pushToViewControllerWithTitl:(NSString *)title andMessage:(NSString *)message with:(NSString *)url WithState:(UIApplicationState)state
{
    
        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"UMPush" object:nil];
//
//        if([title isEqualToString:@"下载完成"])
//        {
//            MyDownLoadViewController *down = [[MyDownLoadViewController alloc]init];
//            down.isWindowGoin = YES;
//            ZKRNavigationController *nav = [[ZKRNavigationController alloc]initWithRootViewController:down];
//            [self.window.rootViewController  presentViewController:nav animated:NO completion:nil];
//        }else
//        {
//            ZKRWebViewController *notice = [[ZKRWebViewController alloc]init];
//            notice.navTitle = title;
//            notice.webStr = url;
//            ZKRNavigationController *nav = [[ZKRNavigationController alloc]initWithRootViewController:notice];
//            [self.window.rootViewController  presentViewController:nav animated:NO completion:nil];
//        }
    UIViewController *vc = [self topViewControllerWithRootViewController:self.window.rootViewController];
    
    HGWebViewController *web = [[HGWebViewController alloc]init];
    
    web.titleStr = title;
    
    web.url = url;
    
    [vc presentViewController:web animated:YES completion:nil];
    
    
}
//获取当前最前方的控制器
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end
