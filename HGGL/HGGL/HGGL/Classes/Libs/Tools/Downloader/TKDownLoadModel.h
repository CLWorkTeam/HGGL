//
//  TKDownLoadModel.h
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDownLoadOperation;
@class TKDownLoadTaskOperation;
typedef NS_ENUM(NSInteger, DownLoadStatus) {
    DownLoadStatusNone = 0,       // 初始状态
    DownLoadStatusRunning = 1,    // 下载中
    DownLoadStatusSuspended = 2,  // 下载暂停
    DownLoadStatusCompleted = 3,  // 下载完成
    DownLoadStatusFailed  = 4,    // 下载失败
    DownLoadStatusWaiting = 5,    // 连接中
    DownLoadStatusCancle = 6 ,   //下载取消
    DownLoadStatusRunqueue = 7    //队列中
};
@interface TKDownLoadModel : NSObject
/**
 资源网络下载地址
 */
@property (nonatomic,copy) NSString *url;
/**
 下载到本地后的固化地址
 */
@property (nonatomic,copy) NSString *localUrl;

/**
 简介图片地址
 */
@property (nonatomic,copy) NSString *imageUrl;
/**
 简介
 */
@property (nonatomic,copy) NSString *intro;
/**
 当前视频的标题
 */
@property (nonatomic,copy) NSString *titleStr;
/**
 类型：0：视频  1：课件  2：学员手册
 */
@property (nonatomic,copy) NSString *liveId;
/**
 *  文件的总大小
 */
@property (nonatomic, assign) long long totalLength;
/**
 *  当前已经写入的文件大小
 */
@property (nonatomic, assign) long long currentLength;

/**
 下载任务的下载状态
 */
@property (nonatomic,assign) DownLoadStatus status;

/**
 当前下载速度（每秒刷新一次）
 */
@property (nonatomic,assign) NSInteger currentSpeed;

/**
 model 对应的下载datask operation
 */
@property (nonatomic,strong) TKDownLoadOperation *operation;


/**
 model 对应的下载downloadtask operation
 */
@property (nonatomic,strong) TKDownLoadTaskOperation *taskOperation;

/**
 写入句柄
 */
@property (nonatomic,strong) NSFileHandle *writeHandle;

//KVO对象
/**
 下载速度 转换后
 */
@property (nonatomic,copy) NSString *speed;
/**
 当前已经写入的文件大小  转换后
 */
@property (nonatomic,copy) NSString *currentLengthStr;
/**
 文件总大小  转换后
 */
@property (nonatomic,copy) NSString *totalLengthStr;

/**
 当前下载进度
 */
@property (nonatomic,assign) float progress;
@end
