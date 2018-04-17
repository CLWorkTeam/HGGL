
//
//  ProjectAuditTableViewCell.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/14.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ProjectAuditTableViewCell.h"
#import "ProjectList.h"
#import "TextFrame.h"
#define stateW  65
#define Font [UIFont systemFontOfSize:HGFont]

@interface ProjectAuditTableViewCell()
@property (nonatomic,weak) UILabel *proName;
@property (nonatomic,weak) UILabel *proType;
@property (nonatomic,weak) UILabel *proState;
@property (nonatomic,weak) UILabel *proDate;

@end
@implementation ProjectAuditTableViewCell
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    ProjectAuditTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[ProjectAuditTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else{
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
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
}
-(void)setPro:(ProjectList *)pro
{
    _pro = pro;
    //项目名称
    UILabel *proName = [[UILabel alloc]init];
    proName.font = Font;
    proName.frame = CGRectMake(CellWMargin, CellHMargin, HGScreenWidth - stateW-2*CellWMargin-CellHMargin,minH);
    //proName.backgroundColor = [UIColor redColor];
    proName.text = pro.project_name;
    _proName = proName;
    [self.contentView addSubview:proName];
    
    //显示项目类型
    UILabel *proType = [[UILabel alloc]init];
    proType.font = Font;
    proType.frame = CGRectMake(CellWMargin, 2*CellHMargin+minH, (HGScreenWidth-2*CellWMargin-CellHMargin)/2, minH);
    proType.text = pro.project_type;
    _proType = proType;
    //proAdmin.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:proType];
    
    //显示项目审批状态
    UILabel *proState = [[UILabel alloc]init];
    proState.font = Font;
    proState.textAlignment = NSTextAlignmentRight;
    proState.frame = CGRectMake(HGScreenWidth-stateW-CellWMargin, CellHMargin, stateW, minH);
    _proState = proState;
    proState.text = pro.project_status;
    //proState.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:proState];
    
    //    UILabel *tel = [[UILabel alloc]init];
    //    tel.font = Font;
    //    tel .frame = CGRectMake((HGScreenWidth-2*CellWMargin-CellHMargin)/2, minH+2*CellHMargin, (HGScreenWidth-2*CellWMargin-CellHMargin)/2, minH);
    //    tel.textAlignment = NSTextAlignmentRight;
    //    //tel.backgroundColor = [UIColor redColor];
    //    tel.text = pro.project_manager_tel;
    //    //tel.text = pro.project_manager_tel;
    //    [self.contentView addSubview:tel];
    
    //显示项目运行周期
    UILabel *proRun = [[UILabel alloc] init];
    proRun.font = Font;
    proRun.frame = CGRectMake(CellWMargin, minH*2+3*CellHMargin, stateW, minH);
    proRun.text = @"运行周期";
    [self.contentView addSubview:proRun];
    UILabel *proDate = [[UILabel alloc]init];
    proDate.font = Font;
    proDate.frame = CGRectMake(CellWMargin+stateW+CellHMargin,minH*2+3*CellHMargin, HGScreenWidth-2*CellWMargin-CellHMargin-stateW, minH );
    _proDate = proDate;
    
    NSString *str = [NSString stringWithFormat:@"%@-%@",pro.project_start,pro.project_end];
    proDate.textAlignment = NSTextAlignmentRight;
    proDate.text = str;
    //proDate.backgroundColor = [UIColor greenColor];
    [self.contentView addSubview:proDate];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
