//
//  HGBaseController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBaseController.h"

@interface HGBaseController ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation HGBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setNav
{
    self.bar = [[UIView alloc]init];
    self.bar.frame = CGRectMake(0, 0, HGScreenWidth, HGHeaderH);
    self.bar.backgroundColor = HGMainColor;
    [self.view addSubview:self.bar];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((HGScreenWidth-150)/2, HGStautsBarH + (44-20)/2, 150, 20)];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = @"产品资料库";
    self.titleLab = titleLab;
    [self.bar addSubview:titleLab];
    
    [self addNavBar];
}

- (void)addNavBar{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"icon_return"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(10, HGStautsBarH, 35 , 44);
    leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.leftBtn = leftBtn;
    [self.bar addSubview:leftBtn];
    
}

- (void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}



-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    //    self.navigationController.navigationBarHidden = NO;
}
-(void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
    
}

-(void)setName:(NSString *)name{
    
    _name = name;
    self.titleLab.text = name;
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
