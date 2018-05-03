//
//  HGInfoChangeCell.h
//  HGGL
//
//  Created by taikang on 2018/5/2.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HGInfoChangeBlock)(NSString* ,NSString*);

@interface HGInfoChangeCell : UITableViewCell

@property (nonatomic,copy) HGInfoChangeBlock block;//sex 0.男  1.女

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UITextField *textF;

@property (nonatomic,assign) NSInteger type;//用来判断cell的类型.1.label 2.textfield 3.按钮
@property (nonatomic,copy) NSString *sex;//sex 0.男  1.女

@property (nonatomic,strong) NSMutableDictionary *changedDic;


@end
