//
//  MenteeViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeViewController.h"
#import "MenteeCollectionViewController.h"
#import "Mentee.h"
#import "MenteeToolBar.h"
#import "CurrImageView.h"
@interface MenteeViewController ()
@property (nonatomic,strong) MenteeCollectionViewController *tcv;
@property (nonatomic,weak) MenteeToolBar *toolBar;
@end

@implementation MenteeViewController
-(MenteeCollectionViewController *)tcv
{
    if (_tcv == nil) {
        _tcv = [[MenteeCollectionViewController alloc] init];
        _tcv.mentee = self.mentee;
        _tcv.mentee_id = self.mentee_id;
    }
    return _tcv;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    self.navigationItem.title = @"学员详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setToolBar];
    [self setBottom];
    [self setupLeftNavItem];
    __weak typeof(self) weekSelf = self;
    //    self.tcv.PushVC = ^(id vc){
    //        [weekSelf.navigationController pushViewController:vc animated:YES];
    //    };
    self.tcv.VCChange = ^(NSInteger tag ){
        [ weekSelf.toolBar clickbutWith:tag];
        //HGLog(@"tcv");
    };
    self.toolBar.clickChange = ^(NSInteger page){
        
        [weekSelf.tcv.collectionView setContentOffset:CGPointMake(HGScreenWidth*page, 0) animated:NO];
        //HGLog(@"toolbar");
    };
    

}
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

-(void)setToolBar
{
    MenteeToolBar *toolBar = [[MenteeToolBar alloc]init];
    toolBar.frame = CGRectMake(0, 64, self.view.bounds.size.width, 43);
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
}
-(void)setBottom
{
    CurrImageView *bottom = [CurrImageView showInRect:CGRectMake(0, 107, HGScreenWidth, HGScreenHeight - 107)];
    
    [self.view addSubview:bottom];
    bottom.contentView = self.tcv.collectionView;
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
