
//
//  ProjectAuditDetailViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ProjectAuditDetailViewController.h"

@interface ProjectAuditDetailViewController ()

@property(nonatomic, strong)UIWebView *myWebView;

@end

@implementation ProjectAuditDetailViewController
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
    
    self.navigationItem.title = @"项目详情";
    [self setupLeftNavItem];
    HGLog(@"self.project_id = %@", self.project_id);
    NSString *str = [HGURL stringByAppendingString:@""];
    NSURL *urlStr = [NSURL URLWithString:[NSString stringWithFormat:@"%@?projectId=%@", str, self.project_id]];
    NSURLRequest *request = [NSURLRequest requestWithURL:urlStr];
    UIWebView *myWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, HGScreenWidth, HGScreenHeight)];
    myWebView.backgroundColor = [UIColor redColor];
    [myWebView loadRequest:request];
    [self.view addSubview:myWebView];
    self.myWebView = myWebView;
    
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
