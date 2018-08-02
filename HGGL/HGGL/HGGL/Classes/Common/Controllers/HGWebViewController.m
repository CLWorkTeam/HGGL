//
//  HGWebViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/11.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGWebViewController.h"
#import <WebKit/WebKit.h>
@interface HGWebViewController ()<UIWebViewDelegate,WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) UIView *bar;
@property (nonatomic,strong) WKWebView *WKWeb;
@property (nonatomic,weak) CALayer *progressLayer;
@property (nonatomic,weak) UIView *progress;
@end

@implementation HGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
//    self.navigationController.navigationBarHidden = YES;
//    [self setNav];
    [self setWKWebView];
}

-(WKWebView *)WKWeb
{
    if (_WKWeb == nil) {
        
        self.automaticallyAdjustsScrollViewInsets = NO;
        WKWebView *web;
        
        WKPreferences *preferences = [WKPreferences new];
        preferences.javaScriptCanOpenWindowsAutomatically = YES;
        WKUserContentController *user = [[WKUserContentController alloc]init];
        [user addScriptMessageHandler:self name:@"closeByNative"];
        
        WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
        config.selectionGranularity = WKSelectionGranularityDynamic;
        WKPreferences *fre = [WKPreferences new];
        fre.javaScriptCanOpenWindowsAutomatically = YES;
        config.preferences = fre;
        config.userContentController =user;
        config.preferences = preferences;
        config.allowsInlineMediaPlayback = YES;
//        config.mediaPlaybackRequiresUserAction = false;
        
        web = [[WKWebView alloc]initWithFrame:CGRectMake(0,self.bar.maxY , HGScreenWidth, HGScreenHeight-self.bar.maxY-HGSafeBottom) configuration:config];
        web.UIDelegate = self;
        web.navigationDelegate = self;
//        NSString *webStr = isTKProduction?@"":@"https://119.253.83.234:8181";
        if ([self.url hasPrefix:@"http"]) {
//            NSString *str = [self.url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            NSURL *url = [[NSURL alloc] initWithString:self.url];
//            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url ];
            NSString *cookie = [self readCurrentCookie];
            [request addValue:cookie forHTTPHeaderField:HGUserCookie];
            [web loadRequest:request];
            
           
            
        }else
        {
            NSURL *url = [NSURL fileURLWithPath:self.url];
            [web loadFileURL:url allowingReadAccessToURL:url];
        }
        
        
        [web addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
        
        _WKWeb = web;
        
    }
    return _WKWeb;
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBarHidden = NO;
}
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    if ([message.name isEqualToString:@"closeByNative"]) {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

-(void)setNav
{
    self.bar = [[UIView alloc]init];
    self.bar.frame = CGRectMake(0, 0, HGScreenWidth, HGHeaderH);
    self.bar.backgroundColor = HGMainColor;
    [self.view addSubview:self.bar];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake((HGScreenWidth-150)/2, HGStautsBarH + (44-20)/2, 150, 20)];
    titleLab.font = [UIFont systemFontOfSize:18];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.textColor = [UIColor whiteColor];
    titleLab.text = self.titleStr;
    [self.bar addSubview:titleLab];
    
    [self addNavBar];
}
- (void)addNavBar{
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"fanhui"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backTo) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, HGStautsBarH, 35 , 44);
    leftBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.bar addSubview:leftBtn];
    
}
//- (void)loadDataFile
//{
//    //    NSURL *fileURL = [NSURL fileURLWithPath:self.webStr];
//    //    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//    //    [self.web loadRequest:request];
//    // 最最常见的一种情况
//    // 打开IE,访问网站,提示你安装Flash插件
//    // 如果没有这个应用程序,是无法用UIWebView打开对应的文件的
//
//    // 应用场景:加载从服务器上下载的文件,例如pdf,或者word,图片等等文件
//    NSURL *fileURL = [NSURL fileURLWithPath:self.url];
//
//    NSURLRequest *request = [NSURLRequest requestWithURL:fileURL];
//    // 服务器的响应对象,服务器接收到请求返回给客户端的
//    NSURLResponse *respnose = nil;
//
//    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&respnose error:NULL];
//
//    NSLog(@"%@", respnose.MIMEType);
//
//    // 在iOS开发中,如果不是特殊要求,所有的文本编码都是用UTF8
//    // 先用UTF8解释接收到的二进制数据流
////    [self.WKWeb loadData:data MIMEType:respnose.MIMEType textEncodingName:@"UTF8" baseURL:nil];
//    [self.WKWeb loadData:data MIMEType:respnose characterEncodingName:@"UTF8" baseURL:nil];
//}
- (void)backTo{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)setWKWebView
{
    [self.view  addSubview:self.WKWeb];
    [self setProgress];
}

-(void)setProgress
{
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, HGHeaderH, HGScreenWidth, 3)];
    self.progress = progress;
    progress.backgroundColor = [UIColor  clearColor];
    [self.view addSubview:progress];
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor greenColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progressLayer = layer;
}

#pragma mark KVO回馈
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        self.progressLayer.opacity = 1;
        if ([change[@"new"] floatValue] <[change[@"old"] floatValue]) {
            return;
        }
        self.progressLayer.frame = CGRectMake(0, 0, HGScreenWidth*[change[@"new"] floatValue], 3);
        if ([change[@"new"]floatValue] == 1.0) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progressLayer.opacity = 0;
                self.progressLayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else if ([keyPath isEqualToString:@"title"]){
        if (object == self.WKWeb) {
            self.title = self.WKWeb.title;
        }else{
            [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
        }
    }
}

-(void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential * _Nullable))completionHandler{
    
    SecTrustRef serverTrust = challenge.protectionSpace.serverTrust;
    CFDataRef exceptions = SecTrustCopyExceptions (serverTrust);
    SecTrustSetExceptions (serverTrust, exceptions);
    CFRelease (exceptions);
    completionHandler (NSURLSessionAuthChallengeUseCredential, [NSURLCredential credentialForTrust:serverTrust]);
}
-(void)dealloc
{
    //如果存在就在最后销毁KVO
    if (_WKWeb) {
        [_WKWeb removeObserver:self forKeyPath:@"estimatedProgress"];
    }
}
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
    
}
- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }])];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:prompt message:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.text = defaultText;
    }];
    [alertController addAction:([UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(alertController.textFields[0].text?:@"");
    }])];
    
    
    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSString *)readCurrentCookie{
    
    NSArray *cookies = [NSKeyedUnarchiver unarchiveObjectWithData:[HGUserDefaults objectForKey:HGUserCookie]];
    NSMutableString *cookieString = [[NSMutableString alloc] init];
    for (NSHTTPCookie*cookie in cookies) {
       
        [cookieString appendFormat:@"%@=%@;",cookie.name,cookie.value];
        
        
    }
    if (cookieString.length > 0) {
        [cookieString deleteCharactersInRange:NSMakeRange(cookieString.length - 1, 1)];
    }
    
    
    return cookieString;
    
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
