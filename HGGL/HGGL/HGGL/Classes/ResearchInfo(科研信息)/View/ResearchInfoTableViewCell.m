//
//  ResearchInfoTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchInfoTableViewCell.h"
#import "ResearchList.h"
#import "HGLable.h"
#import "TextFrame.h"
#import "ResearchCommon.h"
//#define butH 25
//#define margin 15


@interface ResearchInfoTableViewCell ()
@property (nonatomic,strong) NSArray *operations;
@end

@implementation ResearchInfoTableViewCell

-(void)setRL:(ResearchList *)RL
{
    UIImageView *ima = [[UIImageView alloc]init];
    ima.frame = CGRectMake(0, minH/2-CellWMargin/2+CellHMargin,CellWMargin , CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    _RL = RL;
    CGFloat MW = (HGScreenWidth-2*CellWMargin-CellHMargin)*0.85;
    UILabel *ResearchNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    ResearchNV.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    ResearchNV.text = RL.research_name;
    ResearchNV.frame = CGRectMake(CellWMargin,CellHMargin,MW , minH);
    [self.contentView addSubview:ResearchNV];
    UILabel *typeN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    typeN.text = @"类      型:";
    typeN.frame  = CGRectMake(CellWMargin, CGRectGetMaxY(ResearchNV.frame)+CellHMargin, MW*0.3, minH);
    [self.contentView addSubview:typeN];
    UILabel *typeNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    typeNV.text = RL.research_type;
    typeNV.frame = CGRectMake(CGRectGetMaxX(typeN.frame)+CellHMargin, CGRectGetMaxY(ResearchNV.frame)+CellHMargin, MW*0.7, minH);
    [self.contentView addSubview:typeNV];
    UILabel *managerN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    managerN.text = @"负  责 人:";
    managerN.frame = CGRectMake(CellWMargin , CGRectGetMaxY(typeN.frame)+CellHMargin, MW*0.3, minH);
    [self.contentView addSubview:managerN];
    UILabel *managerNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor ]];
    managerNV.text = RL.research_manager;
    managerNV.frame = CGRectMake(CGRectGetMaxX(managerN.frame)+CellHMargin, CGRectGetMaxY(typeN.frame)+CellHMargin, MW*0.7, minH);
    [self.contentView addSubview:managerNV];
    UILabel *stateN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    stateN.text = @"课题状态:";
    stateN.frame = CGRectMake(CellWMargin, CGRectGetMaxY(managerN.frame)+CellHMargin, MW*0.3, minH);
    [self.contentView addSubview:stateN];
    UILabel *stateNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor greenColor]];
    self.operations = RL.research_control;
    stateNV.text = RL.research_status;
    stateNV.frame = CGRectMake(CGRectGetMaxX(stateN.frame)+CellHMargin, CGRectGetMaxY(managerN.frame)+CellHMargin, MW*0.7, minH);
    [self.contentView addSubview:stateNV];
//    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
//    [but setTitle:@"课题操作" forState:UIControlStateNormal];
//    but.titleLabel.font = [UIFont systemFontOfSize:14];
//    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
//    but.bounds = CGRectMake(0, 0, 69, 30);
//    but.backgroundColor = [UIColor redColor];
//    but.center = CGPointMake((HGScreenWidth-2*margin)*0.87, 100*0.5);
//    [self.contentView     addSubview:but];
//    UIImageView  *ima = [[UIImageView alloc]init];
//    ima.backgroundColor  = [UIColor redColor];
//    ima.bounds  = CGRectMake(0, 0, 30, 30);
//    ima.center =CGPointMake((HGScreenWidth-2*margin)*0.87, 100*0.5);
//    [self.contentView addSubview:ima];
    
}
-(void)clickBut:(UIButton *)but
{
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    ResearchInfoTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ResearchInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
