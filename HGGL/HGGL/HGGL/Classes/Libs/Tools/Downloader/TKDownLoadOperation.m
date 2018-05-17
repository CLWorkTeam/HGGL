//
//  TKDownLoadOperation.m
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import "TKDownLoadOperation.h"
#import "TKDownLoadModel.h"
#import <objc/runtime.h>
@interface TKDownLoadOperation ()<NSURLSessionDataDelegate>
@property (nonatomic,strong)NSURLSessionDataTask *task;
@property (nonatomic,strong)NSURLSession *session;
@end
@implementation TKDownLoadOperation


//初始化方法
-(instancetype)initWithSession:(NSURLSession *)session andDownModel:(TKDownLoadModel *)model
{
    if (self = [super init]) {
        self.model = model;
        self.session = session;
        [self creatRequest];
        self.task.hyb_videoModel = self.model;
        
    }
    return self;
}
//创建请求
-(void)creatRequest
{
    
    NSURL *url = [NSURL URLWithString:self.model.url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:0 timeoutInterval:20 ];
    NSString *range = [NSString stringWithFormat:@"bytes=%lld-", self.model.currentLength];
    [request setValue:range forHTTPHeaderField:@"Range"];
    self.task = [self.session dataTaskWithRequest:request];
    [self.task resume];
    self.task.hyb_videoModel.status = DownLoadStatusRunqueue;
    
}

//取消方法
-(void)cancel
{
    
    if (self.task) {
        [self.task cancel];
        self.task = nil;
    }
    
}

-(void)resume
{
    [self creatRequest];
}
@end
static const void *s_hyb_videoModelKey = "s_hyb_videoModelKey";
@implementation NSURLSessionTask (VideoModel)

-(void)setHyb_videoModel:(TKDownLoadModel *)hyb_videoModel
{
    objc_setAssociatedObject(self, s_hyb_videoModelKey, hyb_videoModel, OBJC_ASSOCIATION_ASSIGN);
}

-(TKDownLoadModel *)hyb_videoModel
{
    return objc_getAssociatedObject(self, s_hyb_videoModelKey);
}
@end
