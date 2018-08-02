//
//  MPPlayerViewController.h
//  高速项目
//
//  Created by Lei on 16/4/18.
//  Copyright (c) 2016年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Photos/Photos.h>
@interface MPPlayerViewController : UIViewController
@property (nonatomic,copy) NSString *url;
@property (nonatomic,assign) BOOL isUrl;

@property (nonatomic,copy) void (^videoBlock)(id url,BOOL isUrl);
@end
