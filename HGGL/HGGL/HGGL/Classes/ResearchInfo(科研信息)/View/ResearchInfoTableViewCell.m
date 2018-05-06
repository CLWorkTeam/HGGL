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
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *ResearchNV;
@property (nonatomic,weak) UILabel *typeNV;
@property (nonatomic,weak) UILabel *typeN;
@property (nonatomic,weak) UILabel *managerN;
@property (nonatomic,weak) UILabel *managerNV;
@property (nonatomic,weak) UILabel *stateN;
@property (nonatomic,weak) UILabel *stateNV;
@property (nonatomic,weak) UIImageView *JD;
@end

@implementation ResearchInfoTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubViews];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}
-(void)setUpAllSubViews
{
    UIImageView *ima = [[UIImageView alloc]init];
//    ima.frame = CGRectMake(0, minH/2-CellWMargin/2+CellHMargin,CellWMargin , CellWMargin);
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    self.ima = ima;
    [self.contentView addSubview:ima];
    
    
    UILabel *ResearchNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    ResearchNV.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.contentView addSubview:ResearchNV];
    self.ResearchNV = ResearchNV;
    
    UILabel *typeN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.typeN = typeN;
    [self.contentView addSubview:typeN];
    
    UILabel *typeNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    [self.contentView addSubview:typeNV];
    self.typeNV = typeNV;
    
    UILabel *managerN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    managerN.text = @"负责人:";
    self.managerN = managerN;
    [self.contentView addSubview:managerN];
    
    UILabel *managerNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor ]];
    self.managerNV = managerNV;
    [self.contentView addSubview:managerNV];
    
    UILabel *stateN = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.stateN = stateN;
    [self.contentView addSubview:stateN];
    
    UILabel *stateNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    self.stateNV = stateNV;
    [self.contentView addSubview:stateNV];
    
    UIImageView *JD = [[UIImageView alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_right" ofType:@"png"];
    JD.image = [UIImage imageWithContentsOfFile:path];
    self.JD = JD;
    [self.contentView addSubview:JD];
    
}

-(void)setRL:(ResearchList *)RL
{
    
    _RL = RL;
    self.ResearchNV.text = RL.research_name;
    self.typeNV.text = RL.research_type;
    self.managerNV.text = RL.research_manager;
    self.operations = RL.research_control;
    self.stateNV.text = RL.research_status;
    

    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat minW = [TextFrame frameOfText:@"课题类型:" With:[UIFont systemFontOfSize:14] AndHeigh:1000].width;
    CGFloat H = 30;
    CGFloat mar = 5;
    self.ima.frame = CGRectMake(0, H/2-CellWMargin/2, CellWMargin, CellWMargin);
//    [self.JD sizeToFit];
    self.JD.bounds = CGRectMake(0, 0, 20, 20);
    self.JD.frame = CGRectMake(self.width-CellWMargin-self.JD.width, self.height/2-self.JD.height/2, self.JD.width, self.JD.height);
    
    self.ResearchNV.frame = CGRectMake(self.ima.maxX, 0, self.width-2*CellWMargin-mar-self.JD.width, H);
    self.typeN.frame = CGRectMake(CellWMargin, self.ResearchNV.maxY, minW, H);
    self.typeN.attributedText = [TextFrame bothLeftAndRightAlignmentWithSymbolWithString:@"项目类型:" WithFont:[UIFont systemFontOfSize:14] AndWidth:self.typeN.width];
    self.typeNV.frame = CGRectMake(self.typeN.maxX+mar, self.typeN.y, self.ResearchNV.width-self.typeN.width-mar, H);
    self.managerN.frame = CGRectMake(self.typeN.x, self.typeN.maxY, minW, H);
    self.managerN.attributedText = [TextFrame bothLeftAndRightAlignmentWithSymbolWithString:@"负责人:" WithFont:[UIFont systemFontOfSize:14] AndWidth:self.typeN.width];
    self.managerNV.frame = CGRectMake(self.managerN.maxX+mar, self.managerN.y, self.typeNV.width, H);
    self.stateN.frame = CGRectMake(self.typeN.x, self.managerN.maxY, minW, H);
    self.stateN.attributedText = [TextFrame bothLeftAndRightAlignmentWithSymbolWithString:@"课题状态:" WithFont:[UIFont systemFontOfSize:14] AndWidth:self.typeN.width];
    self.stateNV.frame = CGRectMake(self.stateN.maxX+mar, self.stateN.y, self.managerNV.width, H);
    
}
-(void)clickBut:(UIButton *)but
{
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    ResearchInfoTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ResearchInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
@end
