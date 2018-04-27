//
//  HGItemDataController.m
//  HGGL
//
//  Created by taikang on 2018/4/15.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGItemDataController.h"

@interface HGItemDataController ()

@end

@implementation HGItemDataController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"项目资料";
    self.rightBtn.hidden = YES;
    [self setupSubviews];
    
}

- (void)setupSubviews{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, self.bar.maxY+10, 100, 100)];
    label1.font = [UIFont systemFontOfSize:FONT_PT(20)];
    label1.text = @"课件:";
    label1.textColor = [UIColor blackColor];
    [label1 sizeToFit];
    [self.view addSubview:label1];
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, label1.maxY+10, HGScreenWidth-20,100)];
    label2.font = [UIFont systemFontOfSize:FONT_PT(18)];
    label2.text = @"无数据";
    label2.textColor = [UIColor lightGrayColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(10, label2.maxY+10, 100, 100)];
    label3.font = [UIFont systemFontOfSize:FONT_PT(20)];
    label3.text = @"视频:";
    label1.textColor = [UIColor blackColor];
    [label3 sizeToFit];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(10, label3.maxY+10, label2.width,label2.height)];
    label4.font = [UIFont systemFontOfSize:FONT_PT(18)];
    label4.text = @"无数据";
    label4.textColor = [UIColor lightGrayColor];
    label4.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label4];
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
