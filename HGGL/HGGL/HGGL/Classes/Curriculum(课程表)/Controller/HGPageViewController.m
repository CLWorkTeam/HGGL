//
//  HGPageViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPageViewController.h"

@interface HGPageViewController ()<UIPageViewControllerDelegate, UIPageViewControllerDataSource>
@property (nonatomic,assign) NSInteger currentIndex;
@end

@implementation HGPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSDictionary *option = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:10] forKey:UIPageViewControllerOptionInterPageSpacingKey];
    NSString *str = (NSString *)self.controllerArray.firstObject;
    Class c = NSClassFromString(str);
    UIViewController *vc = [[c alloc]init];
    [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:NO completion:nil];
    self.currentIndex = 0;
    self.controllerArray[0] = vc;
    self.delegate = self;
    self.dataSource = self;
    HGLog(@"%@--%@",self.dataSource,self.delegate);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    if (index == 0) {
        return nil;
    }
    index--;
    // 返回的ViewController，将被添加到相应的UIPageViewController对象上。
    // UIPageViewController对象会根据UIPageViewControllerDataSource协议方法,自动来维护次序
    // 不用我们去操心每个ViewController的顺序问题
    return [self viewControllerAtIndex:index];
    
    
}
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [self indexOfViewController:(UIViewController *)viewController];
    
    index++;
    if (index == [self.controllerArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index];
    
    
}
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers {
    
    UIViewController *nextVC = [pendingViewControllers firstObject];
    
    NSInteger index = [self.controllerArray indexOfObject:nextVC];
    
    self.currentIndex = index;
}

- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed {
    
    
    if (completed) {
        
//        self.segmentView.selectedIndex = ld_currentIndex ;
        if (_indexChangeBlock) {
            _indexChangeBlock(self.currentIndex);
        }
        
        
    }
}



- (UIViewController *)viewControllerAtIndex:(NSUInteger)index {
    if (([self.controllerArray count] == 0) || (index >= [self.controllerArray count])) {
        return nil;
    }
    // 创建一个新的控制器类，并且分配给相应的数据
    
    id obj = [self.controllerArray objectAtIndex:index];
    UIViewController *vc;
    if ([obj isKindOfClass:([NSString class])]) {
        NSString *vcStr = (NSString *)obj;
        Class c = NSClassFromString(vcStr);
        vc = [[c alloc]init];
        self.controllerArray[index] = vc;
    }else
    {
        vc = (UIViewController *)obj;
    }
    return vc;
}

- (NSUInteger)indexOfViewController:(UIViewController *)viewController {
    
    return  [self.controllerArray indexOfObject:viewController];

}
-(void)changeVCWithIndex:(NSInteger )index
{
    UIViewController *vc = [self viewControllerAtIndex:index];
    
    if (index > self.currentIndex) {
        
        [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            
        }];
    } else {
        
        [self setViewControllers:@[vc] direction:UIPageViewControllerNavigationDirectionReverse animated:YES completion:^(BOOL finished) {
            
        }];
    }
    
    self.currentIndex = index;
    
    
}




@end
