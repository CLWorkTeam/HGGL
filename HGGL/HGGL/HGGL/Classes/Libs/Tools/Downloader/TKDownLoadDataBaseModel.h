//
//  TKDownLoadDataBaseModel.h
//  泰行销
//
//  Created by 陈磊 on 2018/2/5.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TKDownLoadDataBaseModel : NSObject

@property (nonatomic, assign) NSInteger keyBoard;//键值
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
 视频ID
 */
@property (nonatomic,copy) NSString *liveId;

/**
 视频下载地址
 */
@property (nonatomic,copy) NSString *url;

/**
 视频总长度
 */
@property (nonatomic,copy) NSString *totalLength;

/**
 视频本地缓存地址 （不包含沙盒地址  用的时候需要自己去拼接）
 */
@property (nonatomic,copy) NSString *localUrl;
@end
