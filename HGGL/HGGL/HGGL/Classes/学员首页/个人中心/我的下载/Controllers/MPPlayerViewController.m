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
#import "AppDelegate.h"
@interface MPPlayerViewController ()
@property (nonatomic,strong) MPMoviePlayerController *moviePlayer;//视频播放控制器
@end

@implementation MPPlayerViewController

-(MPMoviePlayerController *)moviePlayer{
    if (!_moviePlayer) {
//        NSString *urlStr = [@"http://devimages.apple.com/iphone/samples/bipbop/bipbopall.m3u8" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
//        NSURL *url=[NSURL URLWithString:urlStr];
        
        _moviePlayer=[[MPMoviePlayerController alloc]init];
        
        _moviePlayer.view.frame=CGRectMake(0, HGHeaderH, HGScreenWidth, HGScreenHeight-HGHeaderH);
        _moviePlayer.view.autoresizingMask=UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        [self.view addSubview:_moviePlayer.view];
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
        
        self.moviePlayer.contentURL = [self getNetWorkUrl];
        [self.moviePlayer prepareToPlay];
        [self.moviePlayer play];
    }else
    {

        if (self.str) {
            [[PHImageManager defaultManager] requestAVAssetForVideo:self.str options:nil resultHandler:^(AVAsset *  asset, AVAudioMix *  audioMix, NSDictionary *  info) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    AVURLAsset *urlAsset = (AVURLAsset *)asset;
                    
                    self.moviePlayer.contentURL = urlAsset.URL;
                    [self.moviePlayer prepareToPlay];
                    [self.moviePlayer play];
                    
                });
            }];
            
        }else
        {
            self.moviePlayer.contentURL = [self getFileUrl];
            
            [self.moviePlayer prepareToPlay];
            [self.moviePlayer play];
        }
        
    }

    
    
    [self addNotification];
    //        HGBarBut *left = [HGBarBut initWithColor:nil andSelColor:nil andTColor:[UIColor whiteColor] andFont:[UIFont systemFontOfSize:10]];
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
    if (self.navigationController.topViewController.presentingViewController) {
        [self.navigationController.topViewController dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController.topViewController.navigationController popViewControllerAnimated:YES];
    }
    
//    [self.moviePlayer pause];
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    [self.moviePlayer.view removeFromSuperview];
    self.moviePlayer = nil;
    [self.moviePlayer pause];
}


-(void)addNotification{
    NSNotificationCenter *notificationCenter=[NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackStateChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:nil];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerPlaybackFinished:) name:MPMoviePlayerPlaybackDidFinishNotification object:nil];
    
}
-(void)mediaPlayerPlaybackStateChange:(NSNotification *)notification{
//    switch (self.moviePlayer.playbackState) {
//        case MPMoviePlaybackStatePlaying:
//            NSLog(@"正在播放...");
//            break;
//        case MPMoviePlaybackStatePaused:
//            NSLog(@"暂停播放.");
//            break;
//        case MPMoviePlaybackStateStopped:
//            NSLog(@"停止播放.");
//            break;
//        default:
//            NSLog(@"播放状态:%li",self.moviePlayer.playbackState);
//            break;
//    }
}
-(void)mediaPlayerPlaybackFinished:(NSNotification *)notification{
    [self.moviePlayer pause];
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
