//
//  HGPageContentViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPageContentViewController.h"
#import "HGPageViewController.h"
#import "HGSelfAdaptationBar.h"

@interface HGPageContentViewController ()
@property (nonatomic,strong) HGPageViewController *pageVC;
@property (nonatomic,weak) HGSelfAdaptationBar *bar;
@end

@implementation HGPageContentViewController
-(HGPageViewController *)pageVC
{
    if (!_pageVC) {
        NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:0] forKey:UIPageViewControllerOptionInterPageSpacingKey];
        
        NSMutableArray *ar = [NSMutableArray arrayWithArray:self.ControllerArray];
        _pageVC = [[HGPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:option];
        WeakSelf
        _pageVC.controllerArray = ar;
        _pageVC.indexChangeBlock = ^(NSInteger index) {
            [weakSelf.bar clickButtonWithTag: index];
        };
        [self addChildViewController:_pageVC];
        [self.view addSubview:_pageVC.view];
    }
    return _pageVC;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setContent];
    // Do any additional setup after loading the view.
}

-(void)setContent
{
    HGSelfAdaptationBar *bar = [[HGSelfAdaptationBar alloc]init];
    bar.minCount = 4;
    bar.keyArray = self.keyArray;
    WeakSelf
    bar.clickButtonBlock = ^(NSInteger index) {
        [weakSelf.pageVC changeVCWithIndex:index];
    };
    bar.frame = CGRectMake(0, 0, self.view.width, 40);
    [self.view addSubview:bar];
    self.bar  = bar;
    
    self.pageVC.view.frame = CGRectMake(0, self.bar.maxY, self.view.width, self.view.height-self.bar.height);
    
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
