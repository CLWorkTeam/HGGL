//
//  TKDownLoadManager.h
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDownLoadOperation;
@interface TKDownLoadManager : NSObject

/**
 创建URLSession单例对象

 @return <#return value description#>
 */
-(NSURLSession *)creatURLSession;
/**
 保存完成block

 
 */
- (void)addCompletionHandler:(void (^)(void))completionHandler
                  forSession:(NSString *)identifier;
/**
 初始化单例

 @return 返回单例对象
 */
+(instancetype)share;
/**
 最大并发线程数： 此属性可以控制并发现在的数量
 */
@property (nonatomic,assign) NSInteger maxDownLoadTask;

/**
 是否自动开启下个任务
 */
@property (nonatomic,assign) BOOL autoBeginNextTask;

@property (nonatomic,assign) BOOL allowsCellular;



/**
 正在下载的数组
 */
@property (nonatomic,strong) NSMutableArray *downloadingArray;

/**
 已下载的数组
 */
@property (nonatomic,strong) NSMutableArray *downloadedArray;


/**
 //全部开始
 */
-(void)allstart;

/**
 全部挂起
 */
-(void)allSuspend;

-(void)allCancle;

/**
 //添加新任务
 
 @param urlArr 包含下载路径的数组
 */
-(void)addNewTaskWith:(NSArray *)urlArr;
/**
 删除相对应URL下的下载任务

 @param urlArr 包含下载路径的数组
 */
-(void)deleteTaskWith:(NSArray *)urlArr forStatus:(BOOL) isComplete;


/**
 重启下载任务

 @param urlArr 包含下载路径的数组
 */
-(void)resumeTaskWith:(NSArray *)urlArr;


/**
 //暂停任务

 @param urlArr 包含下载路径的数组
 */
-(void)suspendTaskWith:(NSArray *)urlArr;

/**
 获取剩余手机内存空间

 @return 手机内存剩余空间
 */
-(long long)getAvailableMemorySize;

/**
 改变是否支持蜂窝网络下载的属性设置
 */
-(void)allowCellular:(BOOL)allow;


@end
