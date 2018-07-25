//
//  TKDownLoadManager.m
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import "TKDownLoadManager.h"
#import "TKDownLoadModel.h"
#import "TKDownLoadOperation.h"
#import <mach/mach.h>
#import <objc/runtime.h>
#import "TKDownLoadDataBaseModel.h"
#import "TKDownLoadDataBase.h"
#import "SVProgressHUD.h"
#import "AppDelegate.h"
#include <sys/param.h>
#include <sys/mount.h>
//#import "TKSettingViewController.h"
//#define self.allCell ([TKUserDefaults boolForKey:@"TKAllowDownload"])
typedef void (^completionHandlerType)(void);
@interface TKDownLoadManager ()<NSURLSessionDataDelegate>
/**
 下载队列
 */
@property (nonatomic, strong) NSOperationQueue *queue;
/**
 nsurlsession
 */
@property (nonatomic,strong) NSURLSession *session;
/**
 
 */
@property (nonatomic,strong) NSMutableDictionary *completionHandlerDictionary;

//@property (nonatomic,assign) BOOL isForeGround;//是否是前台

/**
 当前网络状态
 */
@property (nonatomic,assign) NetworkStatus netStatus;

@property (nonatomic,assign) BOOL allCell;
@end

@implementation TKDownLoadManager
static  TKDownLoadManager *manager = nil;
static  NSURLSession *session = nil;
-(NSMutableArray *)downloadedArray
{
    if (_downloadedArray == nil) {
        _downloadedArray = [NSMutableArray array];
        
    }
    return _downloadedArray;
}
-(NSMutableArray *)downloadingArray
{
    if (_downloadingArray == nil) {
        _downloadingArray = [NSMutableArray array];
    }
    return _downloadingArray;
}
#pragma mark 初始化方法
+(instancetype)share
{
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        manager = [[self alloc]init];
        
    });
    return manager;
}
-(id) copyWithZone:(struct _NSZone *)zone
{
    return [TKDownLoadManager share];
}

-(instancetype)init
{
    if (self = [super init]) {
        self.completionHandlerDictionary = [NSMutableDictionary dictionaryWithCapacity:0];
        NSURLSession *session = [self creatURLSession];
        self.session = session;
        
        [[TKDownLoadDataBase shareInstance] openDB];
        [[TKDownLoadDataBase shareInstance] createDownLoadTable];
        [[TKDownLoadDataBase shareInstance] closeDB];
        [self searchDownloadedData];
        [self searchDownloadingData];
        
        
        
    }
    return self;
}
-(void)setAllowsCellular:(BOOL)allowsCellular
{
    _allowsCellular = allowsCellular;
    _allCell = allowsCellular;
    if (!allowsCellular) {
        [self allSuspend];
    }
    
    
}
-(NSURLSession *)creatURLSession
{
//    static NSURLSession *session = nil;
    static dispatch_once_t onceToken;
    _dispatch_once(&onceToken, ^{
        
//        NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration backgroundSessionConfigurationWithIdentifier:@"com.taikanglife.isalessystem"];
                 NSURLSessionConfiguration *cfg = [NSURLSessionConfiguration defaultSessionConfiguration];
        //允许移动网络下载
        
        NSOperationQueue *queue = [[NSOperationQueue alloc] init];
        
        queue.maxConcurrentOperationCount = self.maxDownLoadTask;
        
        self.queue = queue;
        
        cfg.allowsCellularAccess = YES;
        
        cfg.discretionary = YES;
        
        session = [NSURLSession sessionWithConfiguration:cfg delegate:self delegateQueue:queue];
        
        [self setupReachability];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterBackGround) name:@"TKEnterBackground" object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(enterForeGround) name:@"TKEnterForeground" object:nil];
        
    });
    
    return session;
    
}
-(void)searchDownloadedData
{
    [[TKDownLoadDataBase shareInstance] openDB];
    NSArray *arr ;
    arr = [[TKDownLoadDataBase shareInstance] downedItems];
    for (TKDownLoadDataBaseModel *baseModel in arr) {
        TKDownLoadModel *dModel = [[TKDownLoadModel alloc]init];
        dModel.url = baseModel.url;
        dModel.status = DownLoadStatusCompleted;
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        dModel.localUrl = baseModel.localUrl;
        
        if (dModel.localUrl) {
            dModel.localUrl = [document stringByAppendingPathComponent:baseModel.localUrl];
        }
        
        dModel.totalLength = [baseModel.totalLength longLongValue];
        dModel.imageUrl = baseModel.imageUrl;
        dModel.titleStr = baseModel.titleStr;
        dModel.intro = baseModel.intro;
        dModel.liveId = baseModel.liveId;
        NSFileManager *mgr = [NSFileManager defaultManager];
        if ([mgr fileExistsAtPath:dModel.localUrl]) {
            dModel.currentLength = [baseModel.totalLength longLongValue];
            
        }else
        {
            dModel.currentLength = 0;
        }
        dModel.progress = (float)dModel.currentLength/dModel.totalLength;
        [self.downloadedArray addObject:dModel];
    }
    [[TKDownLoadDataBase shareInstance] closeDB];
}
-(void)searchDownloadingData
{
    [[TKDownLoadDataBase shareInstance] openDB];
    NSArray *arr;
    arr = [[TKDownLoadDataBase shareInstance] downingItems];
    for (TKDownLoadDataBaseModel *baseModel in arr) {
        TKDownLoadModel *dModel = [[TKDownLoadModel alloc]init];
        dModel.url = baseModel.url;
        dModel.status = DownLoadStatusNone;
        NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        dModel.localUrl = baseModel.localUrl;
        
        if (dModel.localUrl) {
            dModel.localUrl = [document stringByAppendingPathComponent:baseModel.localUrl];
        }
        
        dModel.totalLength = [baseModel.totalLength longLongValue];
        dModel.imageUrl = baseModel.imageUrl;
        dModel.titleStr = baseModel.titleStr;
        dModel.intro = baseModel.intro;
        dModel.liveId = baseModel.liveId;
        NSFileManager *mgr = [NSFileManager defaultManager];
        if ([mgr fileExistsAtPath:dModel.localUrl]) {
            NSDictionary *att = [mgr attributesOfItemAtPath:dModel.localUrl  error:nil];
            dModel.currentLength = att.fileSize;
            dModel.progress = (float)dModel.currentLength/dModel.totalLength;
        }else
        {
            dModel.currentLength = 0;
            dModel.progress = 0;
        }
        
        [self.downloadingArray addObject:dModel];
    }
    [[TKDownLoadDataBase shareInstance] closeDB];
}
//设置最大下载线程
-(void)setMaxDownLoadTask:(NSInteger)maxDownLoadTask
{
    _maxDownLoadTask = maxDownLoadTask;
    self.queue.maxConcurrentOperationCount = maxDownLoadTask;
}

//全部开始
-(void)allstart
{
    [self resumeTaskWith:self.downloadingArray];
}
-(void)allSuspend
{
    [self suspendTaskWith:self.downloadingArray];
}
-(void)allCancle
{
//    [self deleteTaskWith:self.downloadingArray forStatus:NO];
}
//开始新任务
-(void)addNewTaskWith:(NSArray *)urlArr
{
    [self insertToDataBaseWith:urlArr];
    
}

-(void)insertToDataBaseWith:(NSArray *)array
{
    [[TKDownLoadDataBase shareInstance] openDB];
    
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    for (TKDownLoadModel *model in array) {
        
        if ((!model.url)||([model.url isEqualToString:@""])) {
            [SVProgressHUD showErrorWithStatus:@"资源地址无效"];
            return;
        }
        
        TKDownLoadDataBaseModel *modle1 = [[TKDownLoadDataBase shareInstance] haveDownLoad:model.url];
        
        if (model.status == DownLoadStatusSuspended) {
            [model.operation resume];
        }else
        {
            if (modle1) {
                
                
                
                NSFileManager *mgr = [NSFileManager defaultManager];
                
                if ([mgr fileExistsAtPath:[document stringByAppendingPathComponent:modle1.localUrl]]) {
                    NSDictionary *att = [mgr attributesOfItemAtPath:[document stringByAppendingPathComponent:modle1.localUrl]  error:nil];
                    if ((modle1.totalLength)&&(att.fileSize >= [modle1.totalLength longLongValue])) {
                        [self showSuccessAlertWithStatus:1];
                        return;
                    }else
                    {
                        if ((self.netStatus == ReachableViaWiFi)||self.allCell) {
                            if ((self.netStatus == ReachableViaWWAN)&&self.allCell) {
                                [self showSuccessAlertWithStatus:-1];
                            }
                            
                        }else
                        {
                            
                            [self showCancelAlert];
                            return;
                        }
                        for (TKDownLoadModel *model2 in self.downloadingArray) {
                            if ([model.url isEqualToString:model2.url]) {
                                [self resumeTaskWith:@[model2]];
                                break;
                            }
                        }
                        
                        
                        
                        
                    }
                }else
                {
                    model.currentLength = 0.0;
                    model.totalLength = [modle1.totalLength longLongValue];
                    [self showSuccessAlertWithStatus:2];
                    TKDownLoadOperation *operation = [[TKDownLoadOperation alloc]initWithSession:self.session andDownModel:model];
                    model.status = DownLoadStatusRunqueue;
                    model.operation = operation;
                    
                }
            }else
            {
                
                [self.downloadingArray addObject:model];
                TKDownLoadDataBaseModel *model1 = [[TKDownLoadDataBaseModel alloc]init];
                model1.imageUrl = model.imageUrl;
                model1.titleStr = model.titleStr;
                model1.url = model.url;
                model1.intro = model.intro;
                model1.liveId = model.liveId;
                [[TKDownLoadDataBase shareInstance] downLoadInsertDataBaseModel:model1];
                if ((self.netStatus == ReachableViaWiFi)||self.allCell) {
                    if ((self.netStatus == ReachableViaWWAN)&&self.allCell) {
                        [self showSuccessAlertWithStatus:-1];
                    }else
                    {
                        [self showSuccessAlertWithStatus:0];
                    }
                    TKDownLoadOperation *operation = [[TKDownLoadOperation alloc]initWithSession:self.session andDownModel:model];
                    model.status = DownLoadStatusRunqueue;
                    model.operation = operation;
                    
                    
                    
                }else
                {
                    
                    [self showCancelAlert];
                    

                    
                }
                
                
                
            }
        }

    }
    [[TKDownLoadDataBase shareInstance] closeDB];
}
-(void)deleteTaskWith:(NSArray *)urlArr forStatus:(BOOL) isComplete
{
    
    
    if (!urlArr.count) {
        return;
    }
    
    for (TKDownLoadModel *model in urlArr) {
        
        if (isComplete) {
            [self.downloadedArray removeObject:model];
   
        }else
        {
            [self.downloadingArray removeObject:model];
        }
        [[TKDownLoadDataBase shareInstance] openDB];
        if (model.operation) {
            [model.operation cancel];
            model.operation = nil;
            model.status = DownLoadStatusCancle;
            
        }
        TKDownLoadDataBaseModel *model1 = [[TKDownLoadDataBase shareInstance]haveDownLoad:model.url];
        if (model1) {
            
            NSFileManager *mgr = [NSFileManager defaultManager];
            if ([mgr fileExistsAtPath:model1.localUrl]) {
                [mgr removeItemAtPath:model1.localUrl error:nil];
            }
            [[TKDownLoadDataBase  shareInstance]downLoadDeleteDataBaseModelWithurl:model.url];
            
            
        }
        
        [[TKDownLoadDataBase shareInstance]closeDB];
    }
    
}



-(void)suspendTaskWith:(NSArray *)urlArr
{
    for (TKDownLoadModel *model in urlArr) {
        
        [model.operation cancel];
        model.operation = nil;
        model.status = DownLoadStatusCancle;
        
    }
}
-(void)resumeTaskWith:(NSArray *)urlArr
{
    
    
    if ((self.netStatus == ReachableViaWiFi)||self.allCell) {
        if ((self.netStatus == ReachableViaWWAN)&&self.allCell) {
            [self showSuccessAlertWithStatus:-1];
            
        }
        for (TKDownLoadModel *model in urlArr) {
            
            
            TKDownLoadOperation *operation = [[TKDownLoadOperation alloc]initWithSession:self.session andDownModel:model];
            model.status = DownLoadStatusRunqueue;
            model.operation = operation;
            
            
        }
        
    }else
    {
        if ((self.netStatus == ReachableViaWWAN)&&self.allCell) {
            
            [self showSuccessAlertWithStatus:-1];
            
            for (TKDownLoadModel *model in urlArr) {
                
                
                TKDownLoadOperation *operation = [[TKDownLoadOperation alloc]initWithSession:self.session andDownModel:model];
                model.status = DownLoadStatusRunqueue;
                model.operation = operation;
                
                
            }
            
        }
        
    }
    
    
    
}
#pragma mark 下载任务回调函数
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    long long needSpace = 0;
    //如果原来数据库就有 又再一次到这一步 会重复调用！！！
    for (TKDownLoadModel *model2 in self.downloadingArray) {
        if (model2.status == DownLoadStatusRunning) {
            needSpace += model2.totalLength;
        }
    
    }
    if ((needSpace + response.expectedContentLength)>= ([self getAvailableMemorySize]-1024*1024)) {
    
//        [TKCodeErrorView showAlertInfo:@"内存空间不足" sureClick:nil];
        [SVProgressHUD showErrorWithStatus:@"内存空间不足"];
        
        [self suspendTaskWith:@[dataTask.hyb_videoModel]];
        
        return;
    }
    
    NSString *document = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    
    
    dataTask.hyb_videoModel.status = DownLoadStatusRunning;
    NSFileManager *mgr = [NSFileManager defaultManager];
    
    NSString *l =dataTask.hyb_videoModel.localUrl;
    if (dataTask.hyb_videoModel.localUrl||[mgr fileExistsAtPath:dataTask.hyb_videoModel.localUrl])
    {
        dataTask.hyb_videoModel.writeHandle = [NSFileHandle fileHandleForWritingAtPath:dataTask.hyb_videoModel.localUrl];
        if (dataTask.hyb_videoModel.totalLength<=0) {
            dataTask.hyb_videoModel.totalLength = response.expectedContentLength;
        }
        
        completionHandler(NSURLSessionResponseAllow);
        return;
    }else
    {
        NSString *path = [document stringByAppendingString:@"/TKXVIDEO"];
        dataTask.hyb_videoModel.status = DownLoadStatusRunning;
        if (![mgr fileExistsAtPath:path]) {
            
//            self.path = path;
            [mgr createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        }
        
        NSString *filepath = [path stringByAppendingPathComponent:response.suggestedFilename];
        [mgr createFileAtPath:filepath contents:nil attributes:nil];
        
        
        dataTask.hyb_videoModel.totalLength = response.expectedContentLength;
        
        [[TKDownLoadDataBase shareInstance] openDB];
        TKDownLoadDataBaseModel *model = [[TKDownLoadDataBase shareInstance] haveDownLoad:dataTask.hyb_videoModel.url];
        if (model.localUrl == nil) {
            dataTask.hyb_videoModel.localUrl = filepath;
            
            model.totalLength = [NSString stringWithFormat:@"%lld",dataTask.hyb_videoModel.totalLength];
            model.localUrl = [NSString stringWithFormat:@"TKXVIDEO/%@",response.suggestedFilename];
            
            dataTask.hyb_videoModel.writeHandle = [NSFileHandle fileHandleForWritingAtPath:dataTask.hyb_videoModel.localUrl];
            [[TKDownLoadDataBase shareInstance] downLoadUpdateDataBaseModel:model withUrl:model.url];
            
        }
        [[TKDownLoadDataBase shareInstance]closeDB];
        completionHandler(NSURLSessionResponseAllow);
    }
    
}
-(void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    
    if ((dataTask.hyb_videoModel.operation == nil)||(dataTask.hyb_videoModel.writeHandle == nil)) {
        
        return;
    }
    
    
    [dataTask.hyb_videoModel.writeHandle seekToEndOfFile];
    
    
    // 将数据写入沙盒
    [dataTask.hyb_videoModel.writeHandle writeData:data];
    
    // 累计文件的长度
    
//    NSLog(@"data.length----%ld",(unsigned long)data.length);
    dataTask.hyb_videoModel.currentLength += data.length;
    
    dataTask.hyb_videoModel.currentSpeed = data.length;
    
    
    
    dataTask.hyb_videoModel.progress = (double)dataTask.hyb_videoModel.currentLength/dataTask.hyb_videoModel.totalLength;
    
    HGLog(@"%f",dataTask.hyb_videoModel.progress);
}
-(void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    if (task.hyb_videoModel == nil) {
        return;
    }
    TKDownLoadModel *model = task.hyb_videoModel;
    dispatch_async(dispatch_get_main_queue(), ^{
    NSURLSessionDataTask *dataTask = (NSURLSessionDataTask *)task;
    if (error) {
        NSDictionary * userinfo = [error userInfo];
        NSString * failurl = [userinfo objectForKey:NSURLErrorFailingURLStringErrorKey];
        NSString * localDescription = [userinfo objectForKey:NSLocalizedDescriptionKey];
        if (([failurl isEqualToString:dataTask.hyb_videoModel.url] )&&(!(([userinfo[@"NSLocalizedDescription"] isEqualToString:@"cancelled"]||[userinfo[@"NSLocalizedDescription"] isEqualToString:@"已取消"])&&(error.code == NSURLErrorCancelled))))
//            && [localDescription isEqualToString:@"cancelled"]
        {
            
            TKDownLoadModel *model = task.hyb_videoModel;
            [dataTask.hyb_videoModel.operation cancel];
            dataTask.hyb_videoModel.status = DownLoadStatusFailed;
            dataTask.hyb_videoModel.operation = nil;
            [dataTask.hyb_videoModel.writeHandle closeFile];
            dataTask.hyb_videoModel.writeHandle = nil;
            
            
            
            
           
        }else
        {
            TKDownLoadModel *model = task.hyb_videoModel;
            [dataTask.hyb_videoModel.operation cancel];
            dataTask.hyb_videoModel.status = DownLoadStatusCancle;
            dataTask.hyb_videoModel.operation = nil;
            [dataTask.hyb_videoModel.writeHandle closeFile];
            dataTask.hyb_videoModel.writeHandle = nil;
        }
    }else
    {
        
            TKDownLoadModel *model = task.hyb_videoModel;   
            dataTask.hyb_videoModel.status = DownLoadStatusCompleted;
            [dataTask.hyb_videoModel.operation cancel];
            [dataTask.hyb_videoModel.writeHandle closeFile];
            dataTask.hyb_videoModel.operation = nil;
            dataTask.hyb_videoModel.writeHandle = nil;
            [self.downloadedArray addObject:dataTask.hyb_videoModel];
            [self.downloadingArray removeObject:dataTask.hyb_videoModel];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"downLoadComplete" object:nil];
            
 
        
        
        
        
    }
    if (dataTask.hyb_videoModel.operation) {
        [dataTask.hyb_videoModel.operation cancel];
    }
    });
    
}

//获取剩余存储大小
-(long long)getAvailableMemorySize
{

    struct statfs buf;
    
    unsigned long long freeSpace = -1;
    
    if (statfs("/var", &buf) >= 0) {
        
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
        
    }
    
    return freeSpace;
    
    
}




#pragma mark 监听前台后台的变化及相关处理代码

//-(void)enterBackGround
//{
//    [self allAutoCancle];
//    self.isForeGround = NO;
//}
//-(void)enterForeGround
//{
////    AppDelegate *app = [AppDelegate getAppDelegate];
//    if ((self.netStatus == ReachableViaWWAN)&&(!self.allCell)) {
//
//        [self allAutoCancle];
//
//
//    }else if (self.netStatus == ReachableViaWiFi)
//    {
//
//        [self allAutoStart];
//
//    }
//    self.isForeGround = YES;
//}

#pragma mark 监听网络变化及相关处理代码

#pragma mark - 断网提示  及操作
-(void)setupReachability{
    //发布通知
    
    //创建
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    NSString *remoteHostName = @"www.baidu.com";
    Reachability *hostReachability = [Reachability reachabilityWithHostName:remoteHostName];
    self.netStatus = hostReachability.currentReachabilityStatus;
    
    [hostReachability startNotifier];//开始通知
    
}
- (void) reachabilityChanged:(NSNotification *)note
{
    Reachability* curReach = [note object];
    NSParameterAssert([curReach isKindOfClass:[Reachability class]]);
    //    [self updateInterfaceWithReachability:curReach];
    NetworkStatus netStatus = [curReach currentReachabilityStatus];
    self.netStatus = netStatus;
    if ((netStatus == ReachableViaWWAN)&&(!self.allCell)) {
        
        [self allAutoCancle];
        
    }else if (netStatus == ReachableViaWiFi)
    {
        
        [self allAutoStart];
        
    }
    
}

-(void)allAutoStart
{
    //    BOOL needAlert = NO;
    if ((self.netStatus == ReachableViaWiFi)||self.allCell) {
        
        if ((self.netStatus == ReachableViaWWAN)&&self.allCell) {
            
            [self showSuccessAlertWithStatus:-1];
            
        }
        for (TKDownLoadModel *model in self.downloadingArray) {
            
            if ((model.status == DownLoadStatusSuspended)) {
            
                model.status = DownLoadStatusRunqueue;
            
                TKDownLoadOperation *operation = [[TKDownLoadOperation alloc]initWithSession:self.session andDownModel:model];
               
                model.operation = operation;
                
            }

        }
    }else
    {
            [self showCancelAlert];
        
    }
}
-(void)allAutoCancle
{
    for (TKDownLoadModel *model in self.downloadingArray ) {
        
        if (model.operation) {
            [model.operation cancel];
            model.operation = nil;
            // 让正在下载、等待中和正在队列中的任务都变成自动挂起状态等到  网络环境达到要求的时候就开始自动下载
            if ((model.status == DownLoadStatusRunning)||(model.status == DownLoadStatusWaiting)||(model.status == DownLoadStatusRunqueue)) {
                model.status = DownLoadStatusSuspended;
            }
            
        }
        
        
    }
}

#pragma mark 提示信息

-(void)showCancelAlert
{
    
}
-(void)showSuccessAlertWithStatus:(DownLoadStatus)status
{
    
    
    switch (status) {
        case -1:
        {
           [SVProgressHUD showSuccessWithStatus:@"您已允许4G环境下载视频"];
        }
            break;
        case 0:
        {
            [SVProgressHUD showSuccessWithStatus:@"已成功加入下载队列"];
        }
            break;
        case 1:
        {
            [SVProgressHUD showSuccessWithStatus:@"任务已下载完成，请在已下载列表中查看"];
        }
            break;
        case 2:
        {
            [SVProgressHUD showSuccessWithStatus:@"已在下载队列中"];
        }
            break;
        
            
        default:
            break;
    }
    
}

-(NSMutableArray *)getDownedArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    
    
    return array;
}
-(NSMutableArray*)getDowningArray
{
    NSMutableArray *array = [NSMutableArray array];
    
    
    
    return array;
}

//获取当前最前方的控制器
- (UIViewController *)topViewControllerWithRootViewController:(UIViewController*)rootViewController
{
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}
@end

