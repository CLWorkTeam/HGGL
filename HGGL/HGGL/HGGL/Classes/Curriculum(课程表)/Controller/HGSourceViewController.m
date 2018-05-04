//
//  HGSourceViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSourceViewController.h"
#import "HGPageContentViewController.h"
@interface HGSourceViewController ()
@property (nonatomic,strong) HGPageContentViewController *pageVC;
@end

@implementation HGSourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBarHidden = NO;
    self.title = @"信息共享";
    [self setContent];
    
}
-(void)setContent
{
    HGPageContentViewController *content = [[HGPageContentViewController alloc]init];
    self.pageVC = content;
    content.keyArray = @[@"当日课表",@"班次接待",@"接送站信息",@"餐饮信息",@"教室资源",@"客房资源",@"图书信息"];
    content.ControllerArray = @[@"CurrViewController",@"HGClassAdmitTableViewController",@"HGRecipSendTableViewController",@"HGMealViewController",@"HGClassRViewController",@"HGGuestRoomViewController",@"HGLibraryViewController"];
    [self addChildViewController:content];
    [self.view addSubview:content.view];
    content.view.frame = CGRectMake(0, HGHeaderH, self.view.width, self.view.height-HGHeaderH);
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
