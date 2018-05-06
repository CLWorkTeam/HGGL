//
//  HGBaseController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGBaseController.h"
#import "MessageListController.h"
@interface HGBaseController ()

@property (nonatomic,strong) UILabel *titleLab;

@end

@implementation HGBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNav];
//    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];
}

-(void)setNav
{
    self.bar = [[UIView alloc]init];
    self.bar.frame = CGRectMake(0, 0, HGScreenWidth, HGHeaderH);
    self.bar.backgroundColor = HGMainColor;
    [self.view addSubview:self.bar];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((HGScreenWidth-WIDTH_PT(150))/2, HGStautsBarH + (44-20)/2, WIDTH_PT(150), HEIGHT_PT(20))];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
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
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightBtn setImage:[UIImage imageNamed:@"icon_message"] forState:UIControlStateNormal];
    [rightBtn addTarget:self action:@selector(message) forControlEvents:UIControlEventTouchUpInside];
    rightBtn.frame = CGRectMake(HGScreenWidth - 50, HGStautsBarH, 35 , 44);
    rightBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.rightBtn = rightBtn;
    [self.bar addSubview:rightBtn];

    
}

- (void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)message
{
    MessageListController *message = [[MessageListController alloc]init];
    [self.navigationController pushViewController:message animated:YES];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
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
