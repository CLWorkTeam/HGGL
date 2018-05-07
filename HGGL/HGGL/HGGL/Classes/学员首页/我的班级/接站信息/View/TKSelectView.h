//
//  TKSelectView.h
//  泰行销
//
//  Created by edz on 2017/5/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TKSelectView;

@protocol TKSelectViewDelegate <NSObject>

@required
- (void)didSelectTableView:(TKSelectView *)selectView row:(NSInteger)row;

@optional
- (void)didHiddenSelectView:(TKSelectView *)selectView;

@end

@interface TKSelectView : UIView

@property (nonatomic,strong) NSArray *dataAry;

@property (nonatomic,weak) id<TKSelectViewDelegate> delegate;

@end
