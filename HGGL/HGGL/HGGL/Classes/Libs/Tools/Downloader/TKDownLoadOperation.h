//
//  TKDownLoadOperation.h
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import <Foundation/Foundation.h>
@class TKDownLoadModel;
@interface NSURLSessionTask (VideoModel)

// 为了更方便去获取，而不需要遍历，采用扩展的方式，可直接提取，提高效率
@property (nonatomic, weak) TKDownLoadModel *hyb_videoModel;

@end

@interface TKDownLoadOperation : NSObject
/**
 下载的数据集合
 */
@property (nonatomic,strong) TKDownLoadModel *model;

-(void)cancel;

-(void)resume;
/**
 初始化 创建下载任务

 @param session NSURLSession
 @param model 下载时的数据载体
 @return 本身
 */
-(instancetype)initWithSession:(NSURLSession *)session andDownModel:(TKDownLoadModel *)model;
@end
