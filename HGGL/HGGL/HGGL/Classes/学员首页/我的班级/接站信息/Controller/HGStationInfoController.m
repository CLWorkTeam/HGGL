//
//  HGStationInfoController.m
//  HGGL
//
//  Created by taikang on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGStationInfoController.h"
#import "TKSelectView.h"

@interface HGStationInfoController ()

@end

@implementation HGStationInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"填报接站信息";
    self.rightBtn.hidden = YES;
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
