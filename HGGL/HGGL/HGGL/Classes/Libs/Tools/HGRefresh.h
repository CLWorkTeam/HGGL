//
//  HGRefresh.h
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HGRefresh : NSObject

//上拉加载
+(MJRefreshFooter *)loadMoreRefreshWithRefreshBlock:(void(^)(void)) refreshBlock;
//下拉刷新
+(MJRefreshHeader *)loadNewRefreshWithRefreshBlock:(void(^)(void)) refreshBlock;

@end
