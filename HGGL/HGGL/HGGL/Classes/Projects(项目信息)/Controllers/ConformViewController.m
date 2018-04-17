//
//  ConformViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ConformViewController.h"

@interface ConformViewController ()
@property (nonatomic,weak) UIWebView *web;
@property (nonatomic,weak) UIActivityIndicatorView *activity;
@end

@implementation ConformViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIWebView *webView = [[UIWebView alloc]init];
    webView.frame = CGRectMake(0, 0, HGScreenWidth, HGScreenHeight);
    //webView.backgroundColor = [UIColor redColor];
    [self.view addSubview:webView];
    self.navigationItem.title = @"工作流";
    self.web = webView;
    self.web.delegate = self;
    NSString *str = @"http://192.168.200.234/t9/t9/mobile/act/T9PdaLogin/login.act?";
    NSString *USERNAME = @"system";
    NSString *PASSWORD = @"999999";
    NSString *string = self.url;
    NSURL *url2 = [NSURL URLWithString:string];
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    //    NSURL *url1 = [NSURL URLWithString:@"http://192.168.200.234/t9/t9/mobile/act/T9PdaLogin/login.act?USERNAME=system&PASSWORD=999999&TYPE=workflow"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url2];
    //request.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        NSString *html = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        //NSLog(@"%@",html);
        
        //        [html writeToFile:@"/Users/mac/desktop/web.html" atomically:YES encoding:NSUTF8StringEncoding error:nil];
        [self.web loadHTMLString:html baseURL:[NSURL URLWithString:@"http://192.168.200.234/t9/t9/mobile/act/T9PdaLogin"]];
    }];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIActivityIndicatorView *activity = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activity.bounds = CGRectMake(0, 0, 200, 200);
    activity.center = CGPointMake(HGScreenWidth/2, HGScreenHeight/2);
    self.activity = activity;
    [self.web addSubview:activity];
    [activity startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activity removeFromSuperview];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
