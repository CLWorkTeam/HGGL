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
@interface HGTabBarViewController ()
@property (nonatomic, weak) HGTabbar *tab;
@end

@implementation HGTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    HGTabbar *tabBar = [[HGTabbar alloc]initWithFrame:self.tabBar.bounds];
    
    tabBar.backgroundColor = HGColor(244, 244, 244);
    
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
    
//    MainViewController *main = [[MainViewController alloc]init];
//    
//    [self setUpOneChildrenController:main withTitle:@"主页" image:[UIImage imageNamed:@"home_normal"] selImage:[UIImage imageNamed:@"home_pressed"]];
//    BlackLogViewController *or = [[BlackLogViewController alloc] init];
//    [self setUpOneChildrenController:or withTitle:@"待办事项" image:[UIImage imageNamed:@"todo_normal"] selImage:[UIImage imageNamed:@"todo_pressed"]];
//    
//    RecViewController*info = [[RecViewController alloc]init];
//    [self setUpOneChildrenController:info withTitle:@"任务查询" image:[UIImage imageNamed:@"task_search_normal"] selImage:[UIImage imageNamed:@"task_search_pressed"]];
//    MoreTableViewController *more = [[MoreTableViewController alloc]init];
//    [self setUpOneChildrenController:more withTitle:@"更多..." image:[UIImage imageNamed:@"more_normal"] selImage:[UIImage imageNamed:@"more_pressed"]];
    
}
-(void)setUpOneChildrenController:(UIViewController *)vc withTitle:(NSString *)title image:(UIImage *)image selImage:(UIImage *)selImage
{
    vc.title = title;
    //image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.image = image;
    selImage = [selImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    vc.tabBarItem.selectedImage = selImage;
    //vc.tabBarItem.badgeValue = @"100";
    UINavigationController *nav = [[HGNavigationController alloc]initWithRootViewController:vc];
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
    }}
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
