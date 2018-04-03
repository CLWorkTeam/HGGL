//
//  MessageTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MessageTableViewCell.h"
#import "Message.h"
#import "TextFrame.h"
#import "Common.h"
#import "HGLable.h"
//#define margin 15
//#define UP 5
#define labHeigh 25
#define Width 65
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:14] Andwidth:Width].height

@implementation MessageTableViewCell


-(void)setMes:(Message *)mes
{
    _mes = mes;
    UIImageView *ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(0, minH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    UIButton *type = [UIButton buttonWithType:UIButtonTypeCustom];
    NSMutableDictionary *att = [NSMutableDictionary dictionary];
    att[NSFontAttributeName] = [UIFont systemFontOfSize:ZKRFont];
    
    switch ([mes.msg_type integerValue]) {
        case message:
            [type setTitle:@"[通知公告]" forState:UIControlStateNormal];
            break;
        case sys:
            [type setTitle:@"[系统消息]" forState:UIControlStateNormal];
            break;
        case workFlow:
            [type setTitle:@"[工作流]" forState:UIControlStateNormal];
            break;
        case research:
            [type setTitle:@"[科研审批]" forState:UIControlStateNormal];
            break;
        case report:
            [type setTitle:@"[公告审批]" forState:UIControlStateNormal];
            break;
        case misson:
            [type setTitle:@"[个人任务]" forState:UIControlStateNormal];
            break;
        default:
            break;
    }
    
    type.titleLabel.font = [UIFont systemFontOfSize:ZKRFont];
    type.userInteractionEnabled = NO;
    CGRect rect1 = [type.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, minH) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    [type setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    type.frame = CGRectMake(CellWMargin, CellHMargin,rect1.size.width, minH);
    //[type sizeToFit];
    [self.contentView addSubview:type];
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:ZKRFont Color:[UIColor blackColor]];
    name.font = [UIFont fontWithName:@"Helvetica-Bold" size:ZKRFont];
    name.text = mes.msg_name;
    CGFloat nameW = HGScreenSize.size.width-type.frame.size.width-2*CellWMargin-CellHMargin;

    CGRect rect = [mes.msg_name boundingRectWithSize:CGSizeMake(MAXFLOAT, minH) options:NSStringDrawingUsesLineFragmentOrigin attributes:att context:nil];
    CGFloat W = rect.size.width >=nameW?nameW:rect.size.width;
    name.frame = CGRectMake(CGRectGetMaxX(type.frame)+CellHMargin, CellHMargin, W, minH);
    [self.contentView addSubview:name];
    if (![mes.msg_status intValue]) {
        UIImageView *image = [[UIImageView alloc]init];
        image.image = [UIImage imageNamed:@"new"];
        image.frame = CGRectMake(CGRectGetMaxX(name.frame), CellHMargin, 10, 4);
        //image.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:image];
    }
    UILabel *publisher = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor lightGrayColor]];
    publisher.text = mes.msg_publisher;
    publisher.frame = CGRectMake(CellWMargin, CGRectGetMaxY(name.frame)+CellHMargin, 100, minH);
    [self.contentView addSubview:publisher ];
    UILabel *time = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    time.text = mes.msg_send_time;
    time.frame = CGRectMake(CGRectGetMaxX(publisher.frame), CGRectGetMaxY(name.frame)+CellHMargin, HGScreenSize.size.width-2*CellWMargin-100, minH);
    [self.contentView addSubview:time];
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    MessageTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
