
//
//  TeacViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-19.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacViewController.h"
#import "TeachToolBar.h"
#import "CurrImageView.h"
#import "TeachResCollectionViewController.h"
#import "UIView+Frame.h"
@interface TeacViewController ()
@property (nonatomic,strong)TeachResCollectionViewController *tcv;
@property (nonatomic,weak) TeachToolBar *toolBar;
@end

@implementation TeacViewController
-(TeachResCollectionViewController *)tcv
{
    if (_tcv == nil) {
        TeachResCollectionViewController *tcv = [[TeachResCollectionViewController alloc]init];
        tcv.teacher_id = self.teacher_id;
        _tcv = tcv;
    }
    return _tcv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setupLeftNavItem];
//    NSString *path1 = [[NSBundle mainBundle] pathForResource:@"TeacherInfo" ofType:@"plist" inDirectory:@"teacher"];
    
    self.navigationItem.title = @"师资详情";
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    [self setToolBar];
    [self setBottom];
    __weak typeof(self) weekSelf = self;
    self.tcv.PushVC = ^(id vc){
        
        [weekSelf.navigationController pushViewController:vc animated:YES];
        UITableViewController *v = (UITableViewController *)vc;
        v.navigationItem.title = @"评分详情";
    };
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
//-(void)setupLeftNavItem{
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    [but sizeToFit];
//    but.width = 20;
//    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
//    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
//    self.navigationItem.leftBarButtonItem = letfBut;
//}
//返回前一页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setToolBar
{
    TeachToolBar *toolBar = [[TeachToolBar alloc]init];
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
