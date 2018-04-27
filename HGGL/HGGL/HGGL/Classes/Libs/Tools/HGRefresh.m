//
//  HGRefresh.m
//  HGGL
//
//  Created by taikang on 2018/3/28.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRefresh.h"

@implementation HGRefresh

//上拉加载
+(MJRefreshFooter *)loadMoreRefreshWithRefreshBlock:(void(^)(void)) refreshBlock{
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        refreshBlock();
    }];
    [footer setTitle:@"点击加载更多" forState:MJRefreshStateIdle];
    [footer setTitle:@"正在刷新..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"没有更多了" forState:MJRefreshStateNoMoreData];
    footer.stateLabel.textColor = [UIColor colorWithHexString:@"#999999"];;
    footer.stateLabel.font = [UIFont systemFontOfSize:FONT_PT(12)];

    return footer;
}
//下拉刷新
+(MJRefreshHeader *)loadNewRefreshWithRefreshBlock:(void(^)(void)) refreshBlock{
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        refreshBlock();
    }];
    [header setTitle:@"松手刷新" forState:MJRefreshStatePulling];
    [header setTitle:@"下拉刷新" forState:MJRefreshStateIdle];
    [header setTitle:@"载入中..." forState:MJRefreshStateRefreshing];
    header.stateLabel.textColor = [UIColor colorWithHexString:@"#999999"];;
    header.stateLabel.font = [UIFont systemFontOfSize:FONT_PT(12)];
    header.lastUpdatedTimeLabel.hidden = YES;

    return header;
}

@end
