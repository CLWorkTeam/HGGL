
//
//  CurrentTableViewCell.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "CurrentTableViewCell.h"
#import "CurrseList.h"

@implementation CurrentTableViewCell
//-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        
//    }
//    return self;
//}
-(void)setCurrse:(CurrseList *)currse
{
    _currse = currse;
//    self.myArr = arr;
    //教室号
//    UILabel *course_classroom = [[UILabel alloc] init];
//    course_classroom.textAlignment = NSTextAlignmentCenter;
//    course_classroom.text = currse.classroom;
//    self.course_classroom  = course_classroom;
//    [self.contentView addSubview:course_classroom];
//    
//    //课程数
//    UIButton *course_classCount = [UIButton buttonWithType:UIButtonTypeCustom];
//    course_classCount.backgroundColor = [UIColor clearColor];
//    [course_classCount setTitle:[NSString stringWithFormat:@"%ld节", currse.roomContent.count] forState:UIControlStateNormal];
//    
//    course_classCount.titleLabel.font = [UIFont systemFontOfSize:HGTextFont1];
//    course_classCount.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
//    [course_classCount setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//    [course_classCount addTarget:self action:@selector(classCountClick:) forControlEvents:UIControlEventTouchUpInside];
//    self.course_classCount = course_classCount;
//    [self.contentView addSubview:course_classCount];
//    
//    
//    UIView *viewLine = [[UIView alloc] init];
//    viewLine.frame = CGRectMake(5, 29, HGScreenWidth-10, 1);
//    viewLine.backgroundColor = HGColor(220, 220, 220,1);
//    [self.contentView addSubview:viewLine];
//    
//    UIView *viewLine1 = [[UIView alloc] init];
//    viewLine1.frame = CGRectMake(HGScreenWidth/2, 8, 0.5, 14);
//    viewLine1.backgroundColor = HGColor(220, 220, 220,1);;
//    [self.contentView addSubview:viewLine1];
    
}
-(void)classCountClick:(UIButton *)btn
{
//    HGLog(@"点击");
//    ClassCountViewController *classVC = [[ClassCountViewController alloc] init];
//    [classVC setViewRect:CGRectMake(15, 200, HGScreenWidth-30, HGScreenHeight-400) and:self.currse.roomContent];
//    self.classVC = classVC;
    
}
-(void)layoutSubviews
{
    self.course_classroom.frame = CGRectMake(0, 0, HGScreenWidth/2, 30);
    self.course_classCount.frame = CGRectMake(HGScreenWidth/2, 0, HGScreenWidth/2, 30);
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    CurrentTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CurrentTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}

@end
