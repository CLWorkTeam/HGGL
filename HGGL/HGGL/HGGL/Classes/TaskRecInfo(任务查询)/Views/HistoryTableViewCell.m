//
//  HistoryTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "HistoryTableViewCell.h"
#import "History.h"
#import "HGLable.h"
#import "TextFrame.h"
//#define margin  15
//#define H 25
#define W 65

@interface HistoryTableViewCell ()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *contanct;
@property (nonatomic,weak) UILabel *contanctN;
@property (nonatomic,weak) UILabel *contanctT;
@property (nonatomic,weak) UILabel *manger;
@property (nonatomic,weak) UILabel *mangerN;
@property (nonatomic,weak) UILabel *mangerT;
@property (nonatomic,weak) UILabel *time;
@property (nonatomic,weak) UILabel *timeN;
@end
@implementation HistoryTableViewCell


-(void)setHis:(History *)his
{
    _his = his;
    UIImageView *ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(0, minH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    HGLog(@"%@",his.list_contact);
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.text = his.list_name;
    self.title = title;
    [self.contentView addSubview:title];
    UILabel *contanct = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    contanct.text = @"联系人:";
    self.contanct =contanct;
    [self.contentView addSubview:contanct];
    UILabel *contanctN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    contanctN.text = his.list_contact;
    self.contanctN = contanctN;
    [self.contentView addSubview:contanctN];
    UILabel *contanctT = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    contanctT.text = his.list_contactmobile;
    self.contanctT = contanctT;
    [self.contentView addSubview:contanctT];
    UILabel *manger = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    manger.text = @"负责人:";
    self.manger = manger;
    [self.contentView addSubview:manger];
    UILabel *mangerN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    mangerN.text = his.list_principal;
    self.mangerN = mangerN;
    [self.contentView addSubview:mangerN];
    UILabel *mangerT = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    mangerT.text = his.list_principalmobile;
    self.mangerT = mangerT;
    [self.contentView addSubview:mangerT];
    UILabel *time = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    time.text = @"时  间:";
    self.time = time;
    [self.contentView addSubview:time];
    UILabel *timeN = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    timeN.text = [NSString stringWithFormat:@"%@至%@",his.list_start,his.list_end];
    self.timeN = timeN;
    [self.contentView addSubview:timeN];
//    title.backgroundColor = [UIColor redColor];
//    contanct.backgroundColor = [UIColor blueColor];
//    contanctN.backgroundColor = [UIColor purpleColor];
//    contanctT.backgroundColor = [UIColor yellowColor];
//    manger.backgroundColor = [UIColor orangeColor];
//    mangerN.backgroundColor = [UIColor greenColor];
//    mangerT.backgroundColor = [UIColor grayColor];
//    time.backgroundColor = [UIColor brownColor];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.title.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth-CellWMargin-CellHMargin-30 , minH);
    self.contanct.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.title.frame)+CellHMargin, W, minH);
    self.contanctN.frame = CGRectMake(CGRectGetMaxX(self.contanct.frame)+CellHMargin, CGRectGetMaxY(self.title.frame)+CellHMargin, W, minH  );
    self.contanctT.frame = CGRectMake(CGRectGetMaxX(self.contanctN.frame)+CellHMargin, CGRectGetMaxY(self.title.frame)+CellHMargin, HGScreenWidth-30-2*W-CellWMargin-2*CellHMargin, minH);
    self.manger.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.contanct.frame)+CellHMargin, W, minH);
    self.mangerN.frame = CGRectMake(CGRectGetMaxX(self.manger.frame)+CellHMargin, CGRectGetMaxY(self.contanct.frame)+CellHMargin, W, minH);
    self.mangerT.frame = CGRectMake(CGRectGetMaxX(self.mangerN.frame)+CellHMargin, CGRectGetMaxY(self.contanct.frame)+CellHMargin, HGScreenWidth-30-W-CellHMargin-CellWMargin, minH);
    self.time.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.manger.frame)+CellHMargin, W, minH);
    self.timeN.frame = CGRectMake(CGRectGetMaxX(self.time.frame)+CellHMargin, CGRectGetMaxY(self.manger.frame)+CellHMargin, HGScreenWidth-CellHMargin-CellWMargin-30-W, minH);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    HistoryTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
