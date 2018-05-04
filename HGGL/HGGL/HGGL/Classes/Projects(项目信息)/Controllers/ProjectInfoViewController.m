//
//  ProjectInfoViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProjectInfoViewController.h"
#import "HeaderView.h"
#import "UIView+Frame.h"
#import "CurrImageView.h"
#import "ProjectCollectionViewController.h"
#import "TeachToolBar.h"
#import "ProjectList.h"
@interface ProjectInfoViewController ()
@property (nonatomic,strong)ProjectCollectionViewController *tcv;
@property (nonatomic,weak)  TeachToolBar *toolBar;
@end

@implementation ProjectInfoViewController
-(ProjectCollectionViewController *)tcv
{
    if (_tcv == nil) {
        _tcv = [[ProjectCollectionViewController alloc]init];
        __weak typeof (self)weakself = self;
        _tcv.VCBlock = ^(id vc)
        {
            [weakself.navigationController pushViewController:vc animated:YES];
        };
        _tcv.project_id = self.project_id;
//        _tcv.PL = self.PL;
    }
    return _tcv;
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"项目详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupLeftNavItem];
    // Do any additional setup after loading the view.
    [self setToolBar];
    [self setBottom];
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
    
    // Do any additional setup after loading the view.
}
-(void)setToolBar
{
    UIView *content = [[UIView alloc]init];

    
    
    TeachToolBar *toolBar = [[TeachToolBar alloc]init];
    toolBar.arr = [NSArray arrayWithObjects:@"基本信息",@"学员信息",@"课程信息", nil];
    toolBar.frame = CGRectMake(0, HGHeaderH, self.view.bounds.size.width, 43);
    self.toolBar = toolBar;
    [self.view addSubview:toolBar];
    
    UIView *grayLine = [[UIView alloc]init];
    grayLine.backgroundColor = HGGrayColor;
    [content addSubview:grayLine];
    grayLine.frame = CGRectMake(0, self.toolBar.maxY, self.view.width, 10);
    [self.view addSubview:grayLine];
    
}
-(void)setBottom
{
    CurrImageView *bottom = [CurrImageView showInRect:CGRectMake(0, HGHeaderH+self.toolBar.height+10, HGScreenWidth, HGScreenHeight - (HGHeaderH+self.toolBar.height+10))];
    
    [self.view addSubview:bottom];
    bottom.contentView = self.tcv.collectionView;
}
//-(void)setNav
//{
//    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"主页" style:UIBarButtonItemStyleDone target:self action:@selector(clickBack)];
//    self.navigationItem.leftBarButtonItem = back;
//}
//-(void)setImageView
//{
//    CurrImageView *topView = [CurrImageView  showInRect:CGRectMake(0, 134, HGScreenWidth, HGScreenHeight - 134)];
//    
//   
//    topView.contentView = self.tableView.tableView;
//
//    [self.view addSubview:topView];
//    
//}
//-(void)clickBack
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}
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
