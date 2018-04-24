//
//  HGRSModel.h
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HGRSModel : UIView
@property (nonatomic,copy) NSString *receptionId;//id接送信息id
@property (nonatomic,copy) NSString *contact;//联系人
@property (nonatomic,copy) NSString *contact_phone;//联系人电话
@property (nonatomic,copy) NSString *passengerNum;//乘客数
@property (nonatomic,copy) NSString *pickAddress;//接站地点
@property (nonatomic,copy) NSString *arriveTime;//到达时间
@property (nonatomic,copy) NSString *belongClass;//所在班级
@property (nonatomic,copy) NSString *receptionPeople;//接待人
@property (nonatomic,copy) NSString *receptionPhone;//接待人电话
@property (nonatomic,copy) NSString *receptionCar;//接待车辆
@property (nonatomic,copy) NSString *carNum;//车牌号
@property (nonatomic,copy) NSString *driver;//司机
@property (nonatomic,copy) NSString *driverPhone;//司机电话
@property (nonatomic,copy) NSString *remark;//备注
@property (nonatomic,assign) CGFloat remarkH;
@property (nonatomic,assign) CGFloat cellH;
+(instancetype)initWithDict:(NSDictionary *)dict;
@end
