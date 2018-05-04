//
//  HGRSTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/20.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRSTableViewCell.h"
#import "TextFrame.h"
#import "HGLable.h"
#import "HGRSModel.h"
@interface HGRSTableViewCell ()
@property (nonatomic,weak) UIView *BG;
@property (nonatomic,weak) UIView *receiveBG;
@property (nonatomic,weak) UILabel *guestTitle;
@property (nonatomic,weak) UIView *whiteLine;
@property (nonatomic,weak) UILabel *guestName;
@property (nonatomic,weak) UILabel *guestTel;
@property (nonatomic,weak) UILabel *guestNum;
@property (nonatomic,weak) UILabel *guestPlace;
@property (nonatomic,weak) UILabel *guestTime;
@property (nonatomic,weak) UILabel *guestClass;
@property (nonatomic,weak) UILabel *receiveTitle;
@property (nonatomic,weak) UIView *grayLine;
@property (nonatomic,weak) UILabel *receiveName;
@property (nonatomic,weak) UILabel *receiveCar;
@property (nonatomic,weak) UILabel *receiveNum;
@property (nonatomic,weak) UILabel *receiveDriver;
@property (nonatomic,weak) UILabel *receiveNote;
@end
@implementation HGRSTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUpAllSubviews];
        
    }
    return self;
}

-(void)setUpAllSubviews
{
    UIView *BG = [[UIView alloc] init];
    [self.contentView addSubview:BG];
    BG.backgroundColor = [UIColor whiteColor];
    self.BG = BG;
    
    UIView *receiveBG = [[UIView alloc]init];
    receiveBG.backgroundColor = HGGrayColor;
    [self.BG addSubview:receiveBG];
    self.receiveBG = receiveBG;
    
    UILabel *guestTitle = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    guestTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.receiveBG  addSubview:guestTitle];
    self.guestTitle = guestTitle;
    
    UIView *whiteLine = [[UIView alloc]init];
    whiteLine.backgroundColor = [UIColor whiteColor];
    self.whiteLine = whiteLine;
    [self.receiveBG addSubview:whiteLine];
    
    UILabel *guestName = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.receiveBG  addSubview:guestName];
    self.guestName = guestName;
    
    UILabel *guestTel = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.receiveBG  addSubview:guestTel];
    self.guestTel = guestTel;
    
    UILabel *guestNum = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
    [self.receiveBG  addSubview:guestNum];
    self.guestNum = guestNum;
    
    UILabel *guestPlace = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
    [self.receiveBG  addSubview:guestPlace];
    self.guestPlace = guestPlace;
    
    UILabel *guestTime = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
    [self.receiveBG  addSubview:guestTime];
    self.guestTime = guestTime;
    
    UILabel *guestClass = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.receiveBG  addSubview:guestClass];
    self.guestClass = guestClass;
    
    UILabel *receiveTitle = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    receiveTitle.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.BG  addSubview:receiveTitle];
    self.receiveTitle = receiveTitle;
    
    UIView *grayLine = [[UIView alloc]init];
    grayLine.backgroundColor = HGGrayColor;
    self.grayLine = grayLine;
    [self.BG addSubview:grayLine];
    
    UILabel *receiveName = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
    [self.BG  addSubview:receiveName];
    self.receiveName = receiveName;
    
    UILabel *receiveCar = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.BG  addSubview:receiveCar];
    self.receiveCar = receiveCar;
    
    UILabel *receiveNum = [HGLable lableWithAlignment:NSTextAlignmentRight Font:HGFont Color:[UIColor blackColor]];
    [self.BG  addSubview:receiveNum];
    self.receiveNum = receiveNum;
    
    UILabel *receiveDriver = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
    [self.BG  addSubview:receiveDriver];
    self.receiveDriver = receiveDriver;
    
    UILabel *receiveNote = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.BG  addSubview:receiveNote];
    self.receiveNote = receiveNote;
    
    
    
    
    
}
-(void)setModel:(HGRSModel *)model
{
    _model = model;
    
    self.guestTitle.text = @"乘车人信息";
    
    self.guestName.text = [NSString stringWithFormat:@"联系人：%@",model.contact];
    
    self.guestTel.text = model.contact_phone;
    
    self.guestNum.text = [NSString stringWithFormat:@"人数：%@",model.passengerNum];
    
    if ([self.fillType isEqualToString:@"1"]) {
        
        self.guestPlace.text = [NSString stringWithFormat:@"接站地点：%@",model.pickAddress];
        
    }else
    {
        self.guestPlace.text = [NSString stringWithFormat:@"送站地点：%@",model.pickAddress];
    }
    
    self.guestTime.text = [NSString stringWithFormat:@"到达时间：%@",model.arriveTime];
    
    self.guestClass.text = [NSString stringWithFormat:@"所在班级：%@",model.belongClass];
    
    self.receiveTitle.text = @"接待人信息";
    
    self.receiveName.text = [NSString stringWithFormat:@"接待人：%@",model.receptionPeople];
    
    self.receiveCar.text = [NSString stringWithFormat:@"车辆：%@",model.receptionCar];
    
    self.receiveNum.text = [NSString stringWithFormat:@"车牌号：%@",model.receptionCar];
    
    self.receiveDriver.text = [NSString stringWithFormat:@"司机：%@",model.driver];
    
    self.receiveNote.text = [NSString stringWithFormat:@"备注：%@",model.remark];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Wmar = 10;
    
    CGFloat Wmargin = 5;
    
    CGFloat H = 30;
    
    CGFloat line = 1;
    
//    self.BG.frame = self.bounds;
    self.BG.layer.masksToBounds = YES;
    self.BG.layer.cornerRadius = 5;
    self.BG.layer.borderColor = HGGrayColor.CGColor;
    self.BG.layer.borderWidth = line/2;
    self.BG.frame = CGRectMake(Wmar, 0, self.width-2*Wmar, self.height);
    
    self.receiveBG.frame = CGRectMake(0, 0, self.width-2*Wmar, 4*H+line);
    self.guestTitle.frame = CGRectMake(Wmargin, 0, self.receiveBG.width-2*Wmargin, H);
    self.whiteLine.frame = CGRectMake(0, self.guestTitle.maxY, self.receiveBG.width, line);
    [self.guestTel sizeToFit];
    self.guestTel.bounds = CGRectMake(0, 0, self.guestTel.width, H);
    self.guestTel.center = CGPointMake(self.width/2, self.whiteLine.maxY + H/2);
    self.guestName.frame = CGRectMake(Wmargin, self.whiteLine.maxY, self.receiveBG.width/2-self.guestTel.width/2-2*Wmargin, H);
//    self.guestNum.frame = CGRectMake(self.guestTel.maxX+Wmargin, self.guestName.y, self.guestName.width, H);
    [self.guestNum sizeToFit];
    self.guestNum.frame = CGRectMake(self.receiveBG.width-self.guestNum.width-Wmargin, self.guestName.y, self.guestNum.width, H);
    [self.guestTime sizeToFit];
    self.guestTime.frame = CGRectMake(self.receiveBG.width-self.guestTime.width-Wmargin, self.guestNum.maxY, self.guestTime.width, H);
    self.guestPlace.frame = CGRectMake(Wmargin, self.guestNum.maxY, self.receiveBG.width-3*Wmargin, H);
    self.guestClass.frame = CGRectMake(Wmargin, self.guestPlace.maxY, self.receiveBG.width-2*Wmargin, H);
    self.receiveTitle.frame = CGRectMake(Wmargin, self.receiveBG.maxY, self.receiveBG.width-2*Wmargin, H);
    self.grayLine.frame = CGRectMake(0, self.receiveTitle.maxY, self.receiveBG.width, line);
    self.receiveName.frame = CGRectMake(Wmargin, self.grayLine.maxY, self.receiveBG.width-2*Wmargin, H);
    [self.receiveNum sizeToFit];
    self.receiveNum.frame = CGRectMake(self.receiveBG.width-self.receiveNum.width-Wmargin, self.receiveName.maxY, self.receiveNum.width, H);
    self.receiveCar.frame = CGRectMake(Wmargin, self.receiveNum.y, self.receiveBG.width-3*Wmargin-self.receiveNum.width, H);
    self.receiveDriver.frame = CGRectMake(Wmargin, self.receiveCar.maxY, self.receiveBG.width-2*Wmargin, H);
    self.receiveNote.frame = CGRectMake(Wmargin, self.receiveDriver.maxY,self.receiveBG.width-2*Wmargin , self.model.remarkH);
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGRSTableViewCell";
    HGRSTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGRSTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

@end
