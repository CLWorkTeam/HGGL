//
//  HGContactUSViewController.m
//  HGGL
//
//  Created by taikang on 2018/4/15.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGContactUSViewController.h"

@interface HGContactUSViewController ()

@end

@implementation HGContactUSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"联系我们";
    self.rightBtn.hidden = YES;
    [self setupSubviews];
}

- (void)setupSubviews{
    
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), self.bar.maxY+HEIGHT_PT(40), WIDTH_PT(100), HEIGHT_PT(100))];
    label1.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label1.text = @"海关管理学院";
    label1.textColor = [UIColor colorWithHexString:@"#666666"];
    [label1 sizeToFit];
    [self.view addSubview:label1];

    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), label1.maxY+HEIGHT_PT(25), WIDTH_PT(100), HEIGHT_PT(100))];
    label2.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label2.text = @"联系电话：";
    label2.textColor = [UIColor colorWithHexString:@"#666666"];
    [label2 sizeToFit];
    [self.view addSubview:label2];
    
    UIButton *nodataBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    nodataBtn.frame = CGRectMake(label2.maxX - HEIGHT_PT(5), label2.y, WIDTH_PT(150), label2.height);
    [nodataBtn setTitle:@"0335-8013888" forState:UIControlStateNormal];
    [nodataBtn setTitleColor:HGMainColor forState:UIControlStateNormal];
    nodataBtn.titleLabel.textAlignment = NSTextAlignmentLeft;
    nodataBtn.titleLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    [nodataBtn addTarget:self action:@selector(dialNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:nodataBtn];

    
    UILabel *label3 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), label2.maxY+HEIGHT_PT(25), WIDTH_PT(100), HEIGHT_PT(100))];
    label3.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label3.text = @"邮编： 066004";
    label3.textColor = [UIColor colorWithHexString:@"#666666"];
    [label3 sizeToFit];
    [self.view addSubview:label3];
    
    UILabel *label4 = [[UILabel alloc]initWithFrame:CGRectMake(WIDTH_PT(20), label3.maxY+HEIGHT_PT(30), HGScreenWidth-WIDTH_PT(40), HEIGHT_PT(100))];
    label4.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label4.text = @"地址：";
    label4.textColor = [UIColor colorWithHexString:@"#666666"];
    [label4 sizeToFit];
    [self.view addSubview:label4];

    UILabel *label5 = [[UILabel alloc]initWithFrame:CGRectMake(label4.maxX+WIDTH_PT(5), label4.y, HGScreenWidth-label4.maxX-WIDTH_PT(25), HEIGHT_PT(100))];
    label5.font = [UIFont systemFontOfSize:FONT_PT(16)];
    label5.text = @"河北省秦皇岛市海港区河北大街西段89号";
    label5.numberOfLines = 2;
    label5.textColor = [UIColor colorWithHexString:@"#666666"];
    [label5 sizeToFit];
    [self.view addSubview:label5];
}

- (void)dialNumber:(UIButton *)sender{
    
    NSString *str= @"tel:0335-8013888";
    UIWebView *callWebview = [[UIWebView alloc] init];
    [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
    [self.view addSubview:callWebview];

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
