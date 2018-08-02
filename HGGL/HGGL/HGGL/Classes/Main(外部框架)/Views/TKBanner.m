//
//  TKBanner.m
//  泰行销
//
//  Created by 磊陈 on 2017/4/28.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKBanner.h"
#import "TKPageControl.h"

#import "UIImageView+WebCache.h"

@interface TKBanner()<UIScrollViewDelegate>
@property (nonatomic,weak) UIScrollView *scroll;
@property (nonatomic,weak) TKPageControl *page;
@property (nonatomic,strong) NSTimer *timer;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *imageViewArr;
@property (nonatomic,assign) NSInteger a;
@property (nonatomic,weak) UIImageView *singleImage;
@end
@implementation TKBanner
//懒加载
-(NSMutableArray *)imageViewArr
{
    if (_imageViewArr == nil) {
        
        _imageViewArr = [[NSMutableArray alloc]init];
    }
    return _imageViewArr;
}

#pragma mark UI布局
-(void)setImageArr:(NSArray *)imageArr{
    _imageArr = imageArr;
    if (!imageArr.count) {
        if (self.page) {
            [self.page removeFromSuperview];
            self.page = nil;
        }
        if (self.scroll) {
            [self.imageViewArr removeAllObjects];
            [self.scroll removeFromSuperview];
            self.scroll = nil;
            
        }
        if (self.singleImage) {
            [self.singleImage removeFromSuperview];
            self.singleImage = nil;
        }
        if (self.timer) {
            [self.timer invalidate];
            self.timer = nil;
        }
        return;
    }else if (imageArr.count == 1)
    {
        if (self.page) {
            [self.page removeFromSuperview];
            self.page = nil;
        }
        [self setSingleImage];
    }else
    {
        if (self.page) {
            [self.page removeFromSuperview];
            self.page = nil;
        }
        [self setScrollView3];
        

    }
//    if (self.needPageControl) {
        [self setPageControl];
//    }
    [self layoutSubviews];
    
}
-(void)setNeedPageControl:(BOOL)needPageControl
{
    _needPageControl = needPageControl;
    
    
    [self layoutSubviews];
    
}
-(void)setNeedTimer:(BOOL)needTimer
{
    _needTimer = needTimer;
    
    if (needTimer) {
        [self setTimer];
    }else
    {
        [self.timer invalidate];
        self.timer = nil;
        
    }
    [self layoutSubviews];
}
-(void)setSingleImage
{
    if (self.scroll) {
        [self.imageViewArr removeAllObjects];
        [self.scroll removeFromSuperview];
        if (self.needTimer) {
            [self setTimer];
        }else
        {
            [self.timer invalidate];
            self.timer = nil;
        }
        
    }
    self.a = 0;
    UIImageView *ima = [[UIImageView alloc]init];
    ima.userInteractionEnabled = YES;
    self.singleImage = ima;
    [self addSubview:ima];
    [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr lastObject]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {

        if (error) {
            //                        ima.backgroundColor =
            //                        ima.contentMode = UIViewContentModeCenter;
            ima.image = [UIImage imageNamed:@"zhanwei1"];
        }else
        {
            ima.image = image;
        }
        //                    ima.contentMode = UIViewContentModeScaleToFill;

    }];
//    ima.image = [UIImage imageNamed:[self.imageArr lastObject]];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    //tap.delegate = self;
    
    tap.numberOfTapsRequired = 1;
    tap.numberOfTouchesRequired = 1;
    [ima addGestureRecognizer:tap];
    
}

//设置scrollview
-(void)setScrollView3
{
    if (self.singleImage) {
        [self.singleImage removeFromSuperview];
    }
    if (!self.scroll) {
        UIScrollView *scroll = [[UIScrollView alloc]init];
//        scroll.backgroundColor = [UIColor redColor];
        //self.backgroundColor = [UIColor redColor];
        scroll.bounces = YES;
        scroll.delegate = self;
        scroll.scrollEnabled = YES;
        //不允许显示横向的滑轴
        scroll.showsHorizontalScrollIndicator = NO;
        //不允许显示钟祥的滑轴
        scroll.showsVerticalScrollIndicator = NO;
        //自动分页属性打开
        scroll.pagingEnabled = YES;
        self.scroll.frame = CGRectMake(20, 0, self.frame.size.width, self.bounds.size.height);
        
        self.scroll = scroll;
        
        [self addSubview:scroll];
        for (int i = 0; i<3; i++) {
            
            UIImageView *ima = [[UIImageView alloc]init];
//            ima.contentMode = UIViewContentModeCenter;
//            ima.backgroundColor = [UIColor redColor];
            if (i == 0) {
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr lastObject]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    
                    if (error) {
//                        ima.backgroundColor = 
//                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
//                    ima.contentMode = UIViewContentModeScaleToFill;
                    
                }];
                
                [self.arr addObject:[self.imageArr lastObject]];
            }else if(i == 1)
            {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:0]];
//                ima.contentMode = UIViewContentModeCenter;
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:0]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }                }];
                ima.userInteractionEnabled = YES;
                self.a = 0;
                [self.arr addObject:[self.imageArr objectAtIndex:0]];
                UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
                //tap.delegate = self;
                
                tap.numberOfTapsRequired = 1;
                tap.numberOfTouchesRequired = 1;
                [ima addGestureRecognizer:tap];
                
            }else
            {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:1]];
//                ima.contentMode = UIViewContentModeCenter;
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }                }];
                [self.arr addObject:[self.imageArr objectAtIndex:1]];
            }
            ima.tag = i;
            
            //ZKRLog(@"%@",NSStringFromCGRect(ima.frame));
            [self.imageViewArr addObject:ima];
            
            [self.scroll addSubview:ima];
        }
        
        //    ZKRLog(@"%@",self.scroll.subviews);
        
        [self.scroll setContentOffset:CGPointMake(HGScreenWidth, 0) animated:NO];
        
        scroll.contentSize = CGSizeMake(3*HGScreenWidth, self.bounds.size.height);
        
        if (self.needTimer) {
            [self setTimer];
        }else
        {
            [self.timer invalidate];
            self.timer = nil;
        }
        
        
        
        
    }
    [self addSubview:self.scroll];
    
}
//创建页面控制器
-(void)setPageControl
{
    if (!self.page) {
        TKPageControl *page = [[TKPageControl alloc]init];
        self.page = page;
        self.page.numberOfPages = self.imageArr.count;
        self.page.currentPageIndicatorTintColor = HGMainColor;
        self.page.pageIndicatorTintColor = HGColor(200, 200, 200, 1);
        self.page.currentPage = 0;
        [self addSubview:page];
//        [self.page addTarget:self action:@selector(pageControl:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    [self addSubview:self.page];
}
//这个方法是响应pagecontrol的点击事件的，但是在手机上pagecontrol 的点击范围很小所以这里就不写了
-(void)pageControl:(UIPageControl *)page
{
    
}

//创建计时器 用来进行自动翻页功能
-(void)setTimer
{
    if (!self.timer) {
        NSTimer *timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(handleTimer) userInfo:nil repeats:YES];
        //将计时器加到主运行循环中 并且改变当前运行循环的model防止 tableview在default模式下回印象到定时器的运行
        [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
        self.timer = timer;
    }
    
}
-(void)handleTimer
{
    //    NSInteger a = self.page.currentPage;
    
    [self.scroll setContentOffset:CGPointMake(HGScreenWidth*2, 0) animated:YES];
    //下面这句话不需要的原因是：上面的语句会调用scrollviewdidscroll方法 再这个方法中已经让a++过了 如果a++就会跳图了
    //    self.a++;
    //    if (self.a >=self.imageArr.count) {
    //        self.a = 0;
    //    }
    //    [self changeImageWith:self.a];
    //  a++;
    // self.page.currentPage = a;
    //    ZKRLog(@"--%ld",a);
    
}
#pragma mark scrollView 代理方法
/*
 这个实现的思路主要是：
 1：不管传进来的图片是多少个，创建的imageview就只有3个
 2：创建3个imageview的原因就是可以产生翻页的效果，少于3个就不能产生上翻和下翻得效果了
 3：上面两部保证了翻页效果的完整性，那么有了这种完整性之后，就可以利用这种完整性造成视觉上的错觉
 4：第一次进来的时候肯定显示的是中间的那一页
 5：中间的那页显示的就是应该要显示的那个图片，第一个imageview显示的是当前显示的图片的上一个图片（注意：这里的上一个图片是一个循环，也就是说如果当前显示的是第一个那么上一个图片就是最后一张图片）
 6：翻页的时候在翻页的过程中所有的过程都是正常的翻页过程
 7：翻页完成之后马上同时切换当前这个imageview的显示的图片和将第二个imageview还是放在最终见，并且把要显示的图片放到中间这个iamgeview 的上面，然后第一个iamgeview同样切换成这个图片的上一个图片，最后一个imageview切换成当前显示的图片的下一张图片
 8：所有的翻页过程都是这样翻页完成之后就做一次交换图片的过程和imageview的切换的操作 ，但是这里还有一个重点，原来让别人看见的切换的操作是需要有动画效果，但是动画效果之后完成的这些切换过程是不能有动画效果的，要把这些动画效果都隐藏了
 
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSInteger number = self.scroll.contentOffset.x/self.scroll.bounds.size.width +0.5;
    //self.page.currentPage = self.a;
    //ZKRLog(@"%ld",number);
    //self.lastNum = number;
    //ZKRLog(@"==%d",self.a   );
    
    if (self.scroll.contentOffset.x >= HGScreenWidth * 2) {
        
        [self.scroll setContentOffset:CGPointMake(HGScreenWidth*2, 0) animated:YES];
        [self.scroll setContentOffset:CGPointMake(HGScreenWidth, 0) animated:NO];
        self.a++;
        if (self.a >=self.imageArr.count) {
            self.a = 0;
        }
        [self changeImageWith:self.a];
    }
    if (self.scroll.contentOffset.x <= 0) {
        [self.scroll setContentOffset:CGPointMake(0, 0) animated:YES];
        
        [self.scroll setContentOffset:CGPointMake(HGScreenWidth, 0) animated:NO];
        self.a--;
        if (self.a<0) {
            self.a = self.imageArr.count-1;
        }
        
        [self changeImageWith:self.a];
    }
    
}
//当拖拽开始的时候就将定时器取消了
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
    
}
//当拖拽结束的时候就重新开启定时器
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (self.needTimer) {
        [self setTimer];
    }
    
}
#pragma mark 各种触发方法
-(void)tap:(UITapGestureRecognizer *)recognizer
{
    
    if (_bannerBlock) {
        _bannerBlock(self.page.currentPage);
    }
}
//这个方法就是用来在动画效果完成之后进行所有的图片的切换操作和iamgeview的复位操作的

-(void)changeImageWith:(NSInteger )a
{
    
    // ZKRLog(@"==%d",a);
    for (UIImageView *ima in self.imageViewArr) {
        if (a == 0) {
//            ima.contentMode = UIViewContentModeCenter;
            if (ima.tag == 0) {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:self.imageArr.count-1]];
//                ima.contentMode = UIViewContentModeCenter;
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:self.imageArr.count-1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }               }];
            }else if (ima.tag == 1)
            {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                }];
                //                ZKRLog(@"%@",[self.imageArr lastObject]);
            }else
            {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a+1]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a+1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                }];
            }
        }else if (a == self.imageArr.count-1)
        {
            if (ima.tag == 0) {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a-1]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a-1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                    }];
            }else if (ima.tag == 1)
            {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }                }];
                //ZKRLog(@"%@",[self.imageArr objectAtIndex:a]);
            }else
            {
                //ima.image = [UIImage imageNamed:[self.imageArr firstObject]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr firstObject]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }                }];
            }
        }else
        {
            if (ima.tag == 0) {
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a-1]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a-1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                }];
            }else if (ima.tag == 1)
            {
                //ZKRLog(@"%--ld",a);
                //ima.image = [UIImage imageNamed:[self.imageArr objectAtIndex:a]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        //                        ima.backgroundColor =
                        //                        ima.contentMode = UIViewContentModeCenter;
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                }];
            }else
            {
                //ima.image = [UIImage    imageNamed:[self.imageArr objectAtIndex:a+1]];
                [ima sd_setImageWithURL:[NSURL URLWithString:[self.imageArr objectAtIndex:a+1]] placeholderImage:[UIImage imageNamed:@"zhanwei-logo"] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    if (error) {
                        
                        ima.image = [UIImage imageNamed:@"zhanwei1"];
                    }else
                    {
                        ima.image = image;
                    }
                }];
            }
        }
        
        
    }
    self.page.currentPage = a;
    
}
//这个方法的调用时机在于这个view的所有的子视图在发生改变的时候都狐疑自动在次的调用一次这个方法，那么在这个方法中进行最后的所有的子视图的布局操作是最有效的保证在其他视图改变的情况下还能进行正常的布局的地方
-(void)layoutSubviews
{
    [super layoutSubviews];
    if (self.scroll) {
        self.scroll.frame = CGRectMake(0, 0, self.frame.size.width, self.bounds.size.height);
        CGSize size = CGSizeMake(self.imageArr.count*(WIDTH_PT(14)+WIDTH_PT(20))-WIDTH_PT(10), HEIGHT_PT(20));
        
        _page.bounds = CGRectMake(0, 0, size.width, size.height);
        _page.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-15);
        for (int i = 0;i<self.imageViewArr.count;i++) {
            UIImageView *ima = self.imageViewArr[i];
//            if (i != 1) {
//                ima.transform = CGAffineTransformMakeScale(0.5, 0.5);
//
//
//
//            }else
//            {
//                ima.transform = CGAffineTransformMakeScale(1, 1);
//            }
            ima.frame = CGRectMake(HGScreenWidth*i, 0, HGScreenWidth, self.frame.size.height);
        }
        
    }
    if (self.singleImage) {
        self.singleImage.frame = CGRectMake(0, 0, self.frame.size.width, self.bounds.size.height);
        CGSize size = CGSizeMake(self.imageArr.count*(WIDTH_PT(20)+WIDTH_PT(13))-WIDTH_PT(10), HEIGHT_PT(20));
        _page.bounds = CGRectMake(0, 0, size.width, size.height);
        _page.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-15);
    }
    if (self.needPageControl) {
        self.page.hidden = NO;
    }else
    {
        self.page.hidden = YES;
    }
    
    
}
@end
