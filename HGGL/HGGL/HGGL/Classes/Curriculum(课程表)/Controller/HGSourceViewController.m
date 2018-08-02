//
//  HGSourceViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSourceViewController.h"
#import "HGPageContentViewController.h"
#import "HGScheduleViewController.h"
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
    [self setRightButton];
    
}

-(void)setContent
{
    HGPageContentViewController *content = [[HGPageContentViewController alloc]init];
    content.changePage = ^(NSInteger index) {
        if (index == 0) {
            
            [self setRightButton];
            
        }else
        {
            [self hiddenRightButton];
        }
    };
    self.pageVC = content;
    content.keyArray = @[@"当日课表",@"班次接待",@"接送站信息",@"餐饮信息",@"教室资源",@"客房资源",@"图书信息"];
    content.ControllerArray = @[@"CurrViewController",@"HGClassAdmitTableViewController",@"HGRecipSendTableViewController",@"HGMealViewController",@"HGClassRViewController",@"HGGuestRoomViewController",@"HGLibraryViewController"];
    [self addChildViewController:content];
    [self.view addSubview:content.view];
    content.view.frame = CGRectMake(0, HGHeaderH, self.view.width, self.view.height-HGHeaderH);
    
}
-(void)setRightButton
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    
//    but.width = 20;
//    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but setTitle:@"班级课表" forState:UIControlStateNormal];
    but.titleLabel.font = [UIFont systemFontOfSize:13];
    [but addTarget:self action:@selector(schedule) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    [but sizeToFit];
    self.navigationItem.rightBarButtonItem = letfBut;
}
-(void)hiddenRightButton
{
    self.navigationItem.rightBarButtonItem = nil;
}

-(void)schedule
{
    [self getProjects];
}
-(void)getProjects
{
    
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *strss = [HGUserDefaults objectForKey:HGUserID];
    NSLog(@"%@/%@",strss,@{@"userId":[HGUserDefaults objectForKey:HGUserID]});
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMyClass.do"];
//    NSString *url = @"http://47.95.235.187/Mentee/getMyClass.do";
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":[HGUserDefaults objectForKey:HGUserID]} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        NSArray *array = [NSArray array];
        
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            array = [responseObject objectForKey:@"data"];
            if (array.count) {
                HGScheduleViewController *schedule = [[HGScheduleViewController alloc]init];
                schedule.isTeacher = YES;
                schedule.array = array;
                [self.navigationController pushViewController:schedule animated:YES];
            }else
            {
                [SVProgressHUD showErrorWithStatus:@"暂无匹配班级"];
            }
        }
        
    } failure:^(NSError *error) {
//        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}

@end
