//
//  FullNavViewController.m
//  DLZX
//
//  Created by Lei on 15/12/17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "FullNavViewController.h"

@interface FullNavViewController ()

@end

@implementation FullNavViewController
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
    // Do any additional setup after loading the view.
    self.navigationBarHidden = NO;
}
-(void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    self.navigationBar.barTintColor = HGMainColor;
    viewController.hidesBottomBarWhenPushed = YES;
    self.navigationBarHidden = NO;
   
    [super pushViewController:viewController animated:YES];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//是否支持自动旋转
- (BOOL)shouldAutorotate
{
    return YES;
}
//支持的旋转方向
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    //除了下
    // UIInterfaceOrientationMaskLandscape(支持左右)
    return UIInterfaceOrientationMaskAllButUpsideDown;
}
//进入视图是的默认旋转方向
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
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
