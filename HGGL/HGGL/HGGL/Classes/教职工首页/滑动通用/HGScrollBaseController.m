//
//  HGScrollBaseController.m
//  HGGL
//
//  Created by taikang on 2018/4/25.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGScrollBaseController.h"
#import "HGStudentHomeController.h"
#import "HGContactController.h"
#import "HGMyPointController.h"
#import "HGWebController.h"

@interface HGScrollBaseController ()<UIScrollViewDelegate>

@property (nonatomic,strong) UIView *btnView;
@property (nonatomic,strong) UIScrollView *scrollV;

@property (nonatomic,strong) HGStudentHomeController *myClassVc;
@property (nonatomic,strong) HGContactController *contactVc;

@property (nonatomic,strong) UIButton *infoBtn;
@property (nonatomic,strong) UIButton *contactBtn;


@end

@implementation HGScrollBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = @"我的班级";
    self.rightBtn.hidden = YES;
    [self addBtnView];
    [self addScrollView];
}

- (void)addBtnView{
    UIView *btnView = [[UIView alloc]initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, HEIGHT_PT(70))];
    btnView.backgroundColor = [UIColor whiteColor];
    self.btnView = btnView;
    [self.view addSubview:btnView];
    
    CGFloat w = (HGScreenWidth - WIDTH_PT(30))/2;
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(WIDTH_PT(10), HEIGHT_PT(10), w, WIDTH_PT(40));
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGGrayColor] forState:UIControlStateNormal];
    [btn1 setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
    [btn1 setTitle:@"基本信息" forState:UIControlStateNormal];
    [btn1 setTitleColor:HGMainColor forState:UIControlStateNormal];
    [btn1 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn1 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn1.layer.masksToBounds = YES;
    btn1.layer.cornerRadius = 5;
    self.infoBtn = btn1;
    btn1.selected = YES;
    [btnView addSubview:btn1];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(btn1.maxX + WIDTH_PT(10), HEIGHT_PT(10), w, HEIGHT_PT(40));
    [btn2 setBackgroundImage:[UIImage imageWithColor:HGGrayColor] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageWithColor:HGMainColor] forState:UIControlStateSelected];
    [btn2 setTitle:@"学员通讯录" forState:UIControlStateNormal];
    [btn2 setTitleColor:HGMainColor forState:UIControlStateNormal];
    [btn2 setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    [btn2 addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    btn2.layer.masksToBounds = YES;
    btn2.layer.cornerRadius = 5;
    self.contactBtn = btn2;
    [btnView addSubview:btn2];

    UIView *lineV =[[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_PT(60), HGScreenWidth, HEIGHT_PT(10))];
    lineV.backgroundColor = HGGrayColor;
    [btnView addSubview:lineV];
}


- (void)addScrollView{
    
    UIScrollView *scroll = [[UIScrollView alloc]initWithFrame:CGRectMake(0, self.btnView.maxY, HGScreenWidth, HGScreenHeight-self.btnView.maxY)];
    self.scrollV = scroll;
    scroll.scrollsToTop = NO;
    scroll.delegate = self;
    scroll.pagingEnabled = YES;
    scroll.bounces = NO;
    scroll.showsHorizontalScrollIndicator = NO;
    scroll.contentSize = CGSizeMake(HGScreenWidth * 2, HGScreenHeight - self.btnView.maxY);
    for (int i =0; i < 2; i++) {
        if (i == 0) {
            HGStudentHomeController *vc = [[HGStudentHomeController alloc]init];
            [self addChildViewController:vc];
            vc.view.frame = CGRectMake(0, -HGHeaderH, HGScreenWidth, scroll.height+HGHeaderH);
            vc.bar.hidden = YES;
            vc.tableV.frame = CGRectMake(0, HGHeaderH,HGScreenWidth , scroll.height);
            vc.project_id = self.project_id;
            NSString *type = [HGUserDefaults objectForKey:HGUserType];
            if ([type isEqualToString:@"3"]) { //学员
                vc.secondSectionAry = @[@"成绩单"];
                vc.secondSectionColors = @[HGColor(248, 191, 149, 1)];
            }else if ([type isEqualToString:@"1"]){
                vc.secondSectionAry = @[@"接待确认单",@"班级成绩单"];
                vc.secondSectionColors = @[HGColor(52, 255, 33, 1),HGColor(248, 191, 149, 1)];
            }
            WeakSelf;
            vc.block = ^(NSInteger tag) {
                if (tag==1) { //成绩单
                    HGMyPointController *vc = [[HGMyPointController alloc]init];
                    vc.user_id = [HGUserDefaults objectForKey:HGUserID];
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }else{//接待确认单
                    HGWebController *vc = [[HGWebController alloc]init];
                    vc.url = @"https://www.baidu.com";
                    vc.titleStr = @"接待确认单";
                    [weakSelf.navigationController pushViewController:vc animated:YES];
                }
            };
            [scroll addSubview:vc.view];
        }else if (i ==1){
            HGContactController *vc = [[HGContactController alloc]init];
            vc.view.frame = CGRectMake(HGScreenWidth, -HGHeaderH, HGScreenWidth, scroll.height+HGHeaderH);
            vc.tableV.frame = CGRectMake(0, HGHeaderH,HGScreenWidth , scroll.height);
            vc.bar.hidden = YES;
            vc.project_id = self.project_id;
            [scroll addSubview:vc.view];
            [self addChildViewController:vc];

        }
    }
    
    [self.view addSubview:scroll];
    
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    if (scrollView.contentOffset.x>=HGScreenWidth) {
        self.infoBtn.selected = NO;
        self.contactBtn.selected = YES;
    }else{
        self.infoBtn.selected = YES;
        self.contactBtn.selected = NO;
    }
}

- (void)clickBtn:(UIButton *)sender{
    
    if (sender == self.infoBtn) {
        self.infoBtn.selected = YES;
        self.contactBtn.selected = NO;
        [self.scrollV setContentOffset:CGPointMake(0, 0) animated:YES];
    }else{
        self.infoBtn.selected = NO;
        self.contactBtn.selected = YES;
        [self.scrollV setContentOffset:CGPointMake(HGScreenWidth, 0) animated:YES];
    }
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
