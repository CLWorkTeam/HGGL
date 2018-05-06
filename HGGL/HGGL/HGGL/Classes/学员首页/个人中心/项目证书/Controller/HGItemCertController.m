//
//  HGItemCertController.m
//  HGGL
//
//  Created by taikang on 2018/4/15.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemCertController.h"

@interface HGItemCertController ()

@end

@implementation HGItemCertController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"项目证书";
    self.rightBtn.hidden = YES;
    [self addNodataBtn];
}

- (void)addNodataBtn{
    
    UIButton *nodataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nodataBtn.frame = CGRectMake(0, self.bar.maxY, HGScreenWidth, HGScreenHeight-self.bar.maxY);
    [nodataBtn setTitle:@"暂无数据，点击刷新" forState:UIControlStateNormal];
    [nodataBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    nodataBtn.titleLabel.textAlignment = NSTextAlignmentCenter;
    nodataBtn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    [nodataBtn addTarget:self action:@selector(requestData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nodataBtn];
}

- (void)requestData:(UIButton *)sender{
    [SVProgressHUD showWithStatus:@"请求中...."];
    [SVProgressHUD dismissWithDelay:1.0];
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
