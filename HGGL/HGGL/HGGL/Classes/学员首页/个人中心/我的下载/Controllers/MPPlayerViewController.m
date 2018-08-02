//
//  MPPlayerViewController.m
//  高速项目
//
//  Created by Lei on 16/4/18.
//  Copyright (c) 2016年 sinosoft. All rights reserved.
//

#import "MPPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>
#import "AppDelegate.h"
@interface MPPlayerViewController ()
@property (nonatomic,strong) AVPlayerViewController *moviePlayer;//视频播放控制器
@end

@implementation MPPlayerViewController

-(AVPlayerViewController *)moviePlayer{
    if (!_moviePlayer) {

//        _moviePlayer=[[MPMoviePlayerController alloc]init];
//
//        _moviePlayer.view.frame=CGRectMake(0, HGHeaderH, HGScreenWidth, HGScreenHeight-HGHeaderH);
//        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
//        [self.view addSubview:_moviePlayer.view];
        
        // player的控制器对象
        AVPlayerViewController *playerViewController = [[AVPlayerViewController alloc] init];
        // 控制器的player播放器
        
        // 试图的填充模式
        playerViewController.videoGravity = AVLayerVideoGravityResizeAspect;
        // 是否显示播放控制条
        playerViewController.showsPlaybackControls = YES;
        // 设置显示的Frame
        playerViewController.view.frame = CGRectMake(0, HGHeaderH, HGScreenWidth, HGScreenHeight-HGHeaderH);
        
        _moviePlayer = playerViewController;
        // 将播放器控制器添加到当前页面控制器中
        [self addChildViewController:_moviePlayer];
        // view一定要添加，否则将不显示
        [self.view addSubview:playerViewController.view];
        
        
        
    }
    return _moviePlayer;
}
-(NSURL *)getNetWorkUrl
{
    NSString *urlStr = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSURL *url=[NSURL URLWithString:urlStr];
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    return  url;
}
-(NSURL *)getFileUrl
{

    NSString *urlStr1 = self.url;

    HGLog(@"====%@",urlStr1);

    NSURL *url=[NSURL fileURLWithPath:urlStr1];

    return  url;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[AVAudioSession sharedInstance] setCategory: AVAudioSessionCategoryPlayback error: nil];
    if (self.isUrl) {
        
        
    }else
    {

        if (self.url) {
            
            NSString *path  = self.url;
            
            NSURL *url = [NSURL fileURLWithPath:path];
            
            AVPlayer *avPlayer= [AVPlayer playerWithURL:url];
            
            self.moviePlayer.player = avPlayer;
            // 播放
            [self.moviePlayer.player play];
        }
        
    }

    
    
    
    UIButton *left = [UIButton buttonWithType:UIButtonTypeCustom];
    [left setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [left setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    left.frame = CGRectMake(0, 0, 40, HGNavgationBarH);
    [left addTarget:self action:@selector(leftButClick:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:left];
    self.navigationItem.leftBarButtonItem = letfBut;
}
-(void)leftButClick:(UIButton *)but
{
    AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    app.isFull = NO;
    [_moviePlayer.player pause];
    [_moviePlayer.view removeFromSuperview];
    _moviePlayer = nil;
    
    if (self.navigationController.topViewController.presentingViewController) {
        [self.navigationController.topViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController.topViewController.navigationController popViewControllerAnimated:YES];
    }
    
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
