//
//  ProInfoTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProInfoTableViewCell.h"
#import "HGProjectListModel.h"
#import "TextFrame.h"
//#define margin  8
//#define heigh 25
#define stateW  65
#define Font [UIFont systemFontOfSize:HGFont]
@interface ProInfoTableViewCell()
@property (nonatomic,weak) UILabel *proName;
@property (nonatomic,weak) UILabel *proType;
@property (nonatomic,weak) UILabel *proState;
@property (nonatomic,weak) UILabel *proDate;

@end
@implementation ProInfoTableViewCell

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
    
    //项目名称
    UILabel *proName = [[UILabel alloc]init];
    proName.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    
    proName.textAlignment = NSTextAlignmentLeft;
    proName.textColor = [UIColor blackColor];
    _proName = proName;
    [self.contentView addSubview:proName];
    
    UILabel *proType = [[UILabel alloc]init];
    proType.font = Font;
    proType.frame = CGRectMake(CellWMargin, 2*CellHMargin+minH, (HGScreenWidth-2*CellWMargin-CellHMargin)/2, minH);
    proName.textAlignment = NSTextAlignmentLeft;
    proName.textColor = [UIColor blackColor];
    _proType = proType;
    [self.contentView addSubview:proType];
    
    UILabel *proState = [[UILabel alloc]init];
    proState.font = Font;
    proState.textAlignment = NSTextAlignmentRight;
    proState.frame = CGRectMake(HGScreenWidth-stateW-CellWMargin, CellHMargin, stateW, minH);
    _proState = proState;
    [self.contentView addSubview:proState];
    
    
    UILabel *proDate = [[UILabel alloc]init];
    proDate.font = Font;
    proDate.frame = CGRectMake(CellWMargin+stateW+CellHMargin,minH*2+3*CellHMargin, HGScreenWidth-2*CellWMargin-CellHMargin-stateW, minH );
    _proDate = proDate;
    proDate.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:proDate];
    
}
-(void)setPro:(HGProjectListModel *)pro
{
    _pro = pro;
    //项目名称
    self.proName.text = pro.project_name;
    //显示项目当前状态
    self.proState.text = pro.running_status;
    
    //显示项目类型
    
    self.proType.text = [NSString stringWithFormat:@"%@ %@",pro.project_contact,pro.contact_phone];
    
    

    
    //显示项目运行周期
    
    NSString *str = [NSString stringWithFormat:@"%@-%@",pro.project_start,pro.project_end];
    self.proDate.text = str;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat H = 30;
    
    CGFloat Wmar = 10;
    
    CGFloat Wmargin = 5;
    
    [self.proState sizeToFit];
    
    self.proState.frame = CGRectMake(self.width-Wmar-self.proState.width, 0, self.proState.width, H);
    
    self.proName.frame = CGRectMake(Wmar, 0 , self.width-2*Wmar-Wmargin-self.proState.width,H);
    
    [self.proDate sizeToFit];
    
    self.proDate.frame = CGRectMake(self.width-Wmar-self.proDate.width, self.proName.maxY, self.proDate.width, H);
    
    self.proType.frame = CGRectMake(Wmar, self.proDate.y, self.width-2*Wmar-Wmargin-self.proDate.width, H);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"ProInfoTableViewCell";
    ProInfoTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
