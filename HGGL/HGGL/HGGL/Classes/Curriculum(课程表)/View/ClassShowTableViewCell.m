

//
//  ClassShowTableViewCell.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/28.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "ClassShowTableViewCell.h"

@implementation ClassShowTableViewCell

-(void)setCurrseList:(CurrseList *)currseList
{
    _currseList = currseList;
    
//    CGFloat width = self.contentView.frame.size.width;
//    CGFloat height = self.contentView.frame.size.height;

    
    UILabel *classNameLabel = [[UILabel alloc] init];
    classNameLabel.text = @"课程/会议:";
    classNameLabel.font = [UIFont systemFontOfSize:HGFont];
    classNameLabel.frame = CGRectMake(0, 15, 85, 20);
    classNameLabel.backgroundColor = [UIColor clearColor];
    classNameLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:classNameLabel];
    UILabel *classNameLabelC = [[UILabel alloc] init];
    classNameLabelC.text = currseList.course_name;
    classNameLabelC.frame = CGRectMake(90, 15, 150, 20);
    classNameLabelC.font = [UIFont systemFontOfSize:HGFont];
    [self.contentView addSubview:classNameLabelC];
    
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.frame = CGRectMake(0, 40, 85, 20);
    timeLabel.text = @"时间:";
    timeLabel.font = [UIFont systemFontOfSize:HGFont];
    timeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:timeLabel];
    
    UILabel *starAndEnd = [[UILabel alloc] init];
    starAndEnd.frame = CGRectMake(90, 40, HGScreenWidth-30-90-15, 20);
    starAndEnd.backgroundColor = [UIColor clearColor];
    starAndEnd.font = [UIFont systemFontOfSize:HGFont];
    starAndEnd.text = [NSString stringWithFormat:@"%@至 %@", currseList.course_start, currseList.course_end];
    [self.contentView addSubview:starAndEnd];
    
    UILabel *speakPerson = [[UILabel alloc] init];
    speakPerson.frame = CGRectMake(0, 65, 85, 20);
    speakPerson.text = @"主讲/主持人:";
    speakPerson.textAlignment = NSTextAlignmentRight;
    speakPerson.font = [UIFont systemFontOfSize:HGFont];
    [self.contentView addSubview:speakPerson];
    UILabel *speakPersonC = [[UILabel alloc] init];
    speakPersonC.frame = CGRectMake(90, 65, HGScreenWidth-30-90-15, 20);
    speakPersonC.font = [UIFont systemFontOfSize:HGFont];
    speakPersonC.text = currseList.course_teacher;
    [self.contentView addSubview:speakPersonC];
    
    UILabel *owner = [[UILabel alloc] init];
    owner.frame = CGRectMake(0, 90, 85, 20);
    owner.text = @"分配人:";
    owner.textAlignment = NSTextAlignmentRight;
    owner.font = [UIFont systemFontOfSize:HGFont];
    [self.contentView addSubview:owner];
    UILabel *ownerC = [[UILabel alloc] init];
    ownerC.frame = CGRectMake(90, 90, HGScreenWidth-30-90-15, 20);
    ownerC.font = [UIFont systemFontOfSize:HGFont];
    ownerC.text = currseList.classOwner;
    [self.contentView addSubview:ownerC];
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
    ClassShowTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ClassShowTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}

@end
