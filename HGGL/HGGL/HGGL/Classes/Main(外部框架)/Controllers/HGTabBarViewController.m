//
//  HGTabBarViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/3/27.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTabBarViewController.h"
#import "HGNavigationController.h"
#import "HGTabbar.h"

#import "HGStudentHomeController.h"
#import "HGClassController.h"
#import "HGContactController.h"
#import "HGPersonalController.h"

@interface HGTabBarViewController ()
@property (nonatomic, weak) HGTabbar *tab;
@end

@implementation HGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HGTabbar *tabBar = [[HGTabbar alloc]initWithFrame:self.tabBar.bounds];
    
    tabBar.backgroundColor = HGMainColor;
    
    __weak typeof (self) weakSelf = self;
    tabBar.tabBarBlock = ^(NSInteger selectedIndex){
        if ((selectedIndex == 2)&&(selectedIndex == weakSelf.selectedIndex)) {
            
        }
        weakSelf.selectedIndex = selectedIndex;
    };
    _tab = tabBar;
    [self.tabBar addSubview:tabBar];
    //    NSTimer *timer = [NSTimer timerWithTimeInterval:30 target:self selector:@selector(loadUnreade) userInfo:nil repeats:YES];
    //    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [self setUpAllChildrenController];
}

-(void)setUpAllChildrenController
{
    
    HGStudentHomeController *main = [[HGStudentHomeController alloc]init];
    [self setUpOneChildrenController:main withTitle:@"我的班级" image:[UIImage imageNamed:@"icon_tab_class_unpress"] selImage:[UIImage imageNamed:@"icon_tab_class"]];
    
    HGContactController *or = [[HGContactController alloc] init];
    [self setUpOneChildrenController:or withTitle:@"学员通讯录" image:[UIImage imageNamed:@"icon_book_address_unpress"] selImage:[UIImage imageNamed:@"icon_book_address"]];
    
    HGClassController*info = [[HGClassController alloc]init];
    [self setUpOneChildrenController:info withTitle:@"班级风采" image:[UIImage imageNamed:@"icon_tab_active_unpress"] selImage:[UIImage imageNamed:@"icon_tab_active"]];
    
    HGPersonalController *more = [[HGPersonalController alloc]init];
    [self setUpOneChildrenController:more withTitle:@"个人中心" image:[UIImage imageNamed:@"icon_tab_personal_unpress"] selImage:[UIImage imageNamed:@"icon_tab_personal"]];
    
}
-(void)setUpOneChildrenController:(UIViewController *)vc withTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage
{
    vc.title = title;
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = image;
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImage;
    //vc.tabBarItem.badgeValue = @"100";
    HGNavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:vc];
    [self  addChildViewController:nav];
    [_tab addButtonWith:vc.tabBarItem];
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[HGTabbar class]]) {
            [view removeFromSuperview];
        }
    }
}

-(void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    for (UIView *view in self.tabBar.subviews) {
        if (![view isKindOfClass:[HGTabbar class]]) {
            [view removeFromSuperview];
        }
    }
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
