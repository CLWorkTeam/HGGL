//
//  HGMyDownLoadViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/9.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMyDownLoadViewController.h"
#import "TKDownLoadManager.h"
#import "TKDownLoadModel.h"
#import "HGPageViewController.h"
#import "HGDownloadedViewController.h"
#import "HGDownloadingViewController.h"
#import "anyButton.h"
#import "TextFrame.h"
#import "HGMyDownLoadViewController.h"
@interface HGMyDownLoadViewController ()
@property (nonatomic,weak) UIButton *RButton;
@property (nonatomic,weak) UIButton *selectedBut;
@property (nonatomic,weak) UIButton *LButton;
@property (nonatomic,weak) UIView *header;
@property (nonatomic,strong) HGPageViewController *pageVC;
@property (nonatomic,assign) NSInteger currentIndex;
@property (nonatomic,assign) UIViewController *currentVC;
@end

@implementation HGMyDownLoadViewController
-(HGPageViewController *)pageVC
{
    if (!_pageVC) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        
        NSMutableArray *ar = [NSMutableArray arrayWithArray:@[@"HGDownloadingViewController",@"HGDownloadedViewController"]];
        _pageVC = [[HGPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        WeakSelf
        _pageVC.controllerArray = ar;
        _pageVC.indexChangeBlock = ^(NSInteger index) {
            
            if (index) {
                
                [weakSelf clickButtonWith:weakSelf.RButton];
                
            }else
            {
                
                [weakSelf clickButtonWith:weakSelf.LButton];
                
            }
            
            weakSelf.currentIndex = index;
            
        };
        _pageVC.justChangeIndex = ^(NSInteger index) {
            
                weakSelf.currentIndex = index;
            
        };
        [self addChildViewController:_pageVC];
        [self.view addSubview:_pageVC.view];
    }
    return _pageVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"我的下载";
//    [self setRightButton];
//    [self test];
    [self setToolBar];
    [self setPageVC];
//    [self test];
}

-(void)setRightButton:(id)sender
{
    self.currentVC = sender;
    anyButton *but = [anyButton buttonWithType:UIButtonTypeCustom];
//    NSString *selImage = [[NSBundle mainBundle] pathForResource:@"icon_teachers" ofType:@"png"];
//    NSString *norImage = [[NSBundle mainBundle] pathForResource:@"icon_new_teacher" ofType:@"png"];
//    [but setImage:[UIImage imageWithContentsOfFile:selImage] forState:UIControlStateSelected];
//    [but setImage:[UIImage imageWithContentsOfFile:norImage] forState:UIControlStateNormal];
//    [but setTitle:@"编辑" forState:UIControlStateNormal];
    
    NSString *imaPath = [[NSBundle mainBundle]pathForResource:@"icon_dustbin" ofType:@"png"];
    
    NSString *selImaPath = [[NSBundle mainBundle]pathForResource:@"icon_cancel" ofType:@"png"];
    
    [but setImage:[UIImage imageWithContentsOfFile:imaPath] forState:UIControlStateNormal];
    
    [but setImage:[UIImage imageWithContentsOfFile:selImaPath] forState:UIControlStateSelected];
    
    [but setTitle:@"取消" forState:UIControlStateSelected];
    
    but.titleLabel.font = [UIFont systemFontOfSize:13];
    
    if ([sender isKindOfClass:NSClassFromString(@"HGDownloadingViewController")]) {
        
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        HGDownloadingViewController *downLoading = (HGDownloadingViewController *)sender;
        
        but.selected = downLoading.isEdit;
        
    }else
    {
        [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        
        HGDownloadedViewController *downLoaded = (HGDownloadedViewController *)sender;
        
        but.selected = downLoaded.isEdit;
        
    }
    
    [but addTarget:self action:@selector(clickEdit:) forControlEvents:UIControlEventTouchUpInside];

//    [but sizeToFit];
    but.frame = CGRectMake(HGScreenWidth-60, 0, 60, HGNavgationBarH);
    
    CGFloat imageH = [TextFrame frameOfText:@"哈哈哈" With:[UIFont systemFontOfSize:13] Andwidth:300].height+10;
    
    UIImage *image = [UIImage imageWithContentsOfFile:imaPath];
    
    CGFloat imageW = imageH*image.size.height/image.size.width;
    
    [but changeImageFrame:CGRectMake(image.size.width/2-imageW/2, but.height/2-imageH/2, imageW, imageH)];
    
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    
    self.navigationItem.rightBarButtonItem = letfBut;
    
    

}
-(void)clickEdit:(UIButton *)button
{
    button.selected = !button.selected;
    
    if ([self.currentVC isKindOfClass:NSClassFromString(@"HGDownloadingViewController")]) {
        
        HGDownloadingViewController *downLoading = (HGDownloadingViewController *)self.currentVC;
        
        downLoading.isEdit = button.selected;
        
    }else
    {
        
        HGDownloadedViewController *downLoaded = (HGDownloadedViewController *)self.currentVC;
        
        downLoaded.isEdit = button.selected;
        
    }
    
    if ([self.currentVC respondsToSelector:@selector(clickRightButtonItem)]) {
        
        [self.currentVC performSelector:@selector(clickRightButtonItem) withObject:nil];
        
    }
    
}
-(void)hiddenRightButton:(id)sender
{
    
    if ([sender isKindOfClass:NSClassFromString(@"HGDownloadingViewController")]) {
        
        if (self.currentIndex == 0) {
            
            self.navigationItem.rightBarButtonItem = nil;
            self.currentVC = nil;
        }
        
    }else
    {
        if (self.currentIndex == 1) {
            
            self.navigationItem.rightBarButtonItem = nil;
            self.currentVC = nil;
            
        }
    }
    
    
}

-(void)setToolBar
{
    UIView *header = [[UIView alloc]init];
    
    header.backgroundColor = [UIColor whiteColor];
    
    header.frame = CGRectMake(0, HGHeaderH, self.view.width, 43);
    
    [self.view addSubview:header];
    
    self.header = header;
    
    UIButton *LButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LButton setTitle:@"下载中" forState:UIControlStateNormal];
    [LButton setTitleColor:HGColor(193, 193, 193, 1) forState:UIControlStateNormal];
    [LButton setTitleColor:HGMainColor forState:UIControlStateSelected];
    LButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    LButton.titleLabel.font = ZKRButFont;
    LButton.tag = 500;
    [LButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:LButton];
    LButton.selected = YES;
    self.LButton = LButton;
    self.selectedBut = LButton;
    LButton.bounds = CGRectMake(0, 0, 100, 30);
    LButton.center = CGPointMake(header.width/4, header.height/2);
    
    
    UIButton *RButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [RButton setTitle:@"已下载" forState:UIControlStateNormal];
    [RButton setTitleColor:HGColor(193, 193, 193, 1) forState:UIControlStateNormal];
    [RButton setTitleColor:HGMainColor forState:UIControlStateSelected];
    RButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    RButton.titleLabel.font = ZKRButFont;
    RButton.tag = 501;
    [RButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:RButton];
    self.RButton = RButton;
    RButton.selected = NO;
    RButton.bounds = CGRectMake(0, 0, 100, 30);
    RButton.center = CGPointMake(header.width*3/4, header.height/2);
    
    
}
-(void)clickBut:(UIButton *)button
{
    if ([button isEqual:self.selectedBut]) {
        return;
    }
    button.selected = YES;
    
    self.selectedBut.selected = NO;
    
    self.selectedBut = button;
    if (button.tag == 500) {
        
        [self.pageVC changeVCWithIndex:0];
        
    }else
    {
        
        [self.pageVC changeVCWithIndex:1];
        
    }
    
}

-(void)clickButtonWith:(UIButton *)button
{
    if ([button isEqual:self.selectedBut]) {
        return;
    }
    button.selected = YES;
    
    self.selectedBut.selected = NO;
    
    self.selectedBut = button;
}
-(void)setPageVC
{
    self.pageVC.view.frame = CGRectMake(0, self.header.maxY, self.view.width, self.view.height-self.header.height-HGHeaderH);
}
-(void)test
{
    TKDownLoadManager *manager = [TKDownLoadManager share];
    
    manager.maxDownLoadTask = 1;
    
    manager.allowsCellular = YES;
    
    TKDownLoadModel *model = [[TKDownLoadModel alloc]init];
    
    model.url = @"http://1253804083.vod2.myqcloud.com/37128721vodgzp1253804083/67fa41766150355543222001993/EUzhNsybbYsA.mp4";
    
    model.titleStr = @"别紧张测试一下而已";
    
    model.intro = @"";
    
    model.imageUrl = @"";
    
    model.liveId = @"0";
    
    [manager addNewTaskWith:@[model]];
    // Do any additional setup after loading the view.
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
