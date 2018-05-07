//
//  HGInfoChangeCell.h
//  HGGL
//
//  Created by taikang on 2018/5/2.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^HGStationInfoBlock)(NSString* ,NSString*);
typedef void(^HGClickMenuBlock)(BOOL,NSInteger);

@interface HGStationInfoCell : UITableViewCell

@property (nonatomic,copy) HGStationInfoBlock block;//更新数据后的回调
//@property (nonatomic,copy) HGClickMenuBlock clickBlock;//点击按钮后的回调

@property (nonatomic,strong) UILabel *titleLab;
@property (nonatomic,strong) UITextField *textF;

@property (nonatomic,assign) NSInteger type;//用来判断cell的类型.1.label 2.textfield 3.单选按钮 4.下拉按钮
@property (nonatomic,assign) BOOL sendStation;//是否接送站

@property (nonatomic,assign) NSInteger mark;//用来标记点了那个按钮

//@property (nonatomic,strong) NSMutableDictionary *changedDic;

@property (nonatomic,strong) anyButton *selectBtn;

@end
