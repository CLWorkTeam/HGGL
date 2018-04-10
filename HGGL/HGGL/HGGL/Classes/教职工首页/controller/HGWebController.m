//
//  HGWebController.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWebController.h"
#import "TKWebProgressView.h"

@interface HGWebController ()<UIWebViewDelegate>

@property (nonatomic,strong) TKWebProgressView  *progressLine;

@property (nonatomic,strong) UIWebView *webView;


@end

@implementation HGWebController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.name = self.titleStr;
    self.rightBtn.hidden = YES;

    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, HGScreenHeight-self.bar.maxY)];
    webView.delegate = self;
    self.webView = webView;
    [self.view addSubview:webView];
    
    
    self.progressLine = [[TKWebProgressView alloc] initWithFrame:CGRectMake(0, self.bar.maxY, HGScreenWidth, 3)];
    self.progressLine.lineColor = [UIColor greenColor];
    [self.view addSubview:self.progressLine];
    
    //网络地址
    NSString *str = self.url;
    NSURL *url = [[NSURL alloc] initWithString:str];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [webView loadRequest:request];
}
- (void)webViewDidStartLoad:(UIWebView *)webView{
    
    [self.progressLine startLoadingAnimation];
}
-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    
    [self.progressLine endLoadingAnimation];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{
    
    [self.progressLine endLoadingAnimation];
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
