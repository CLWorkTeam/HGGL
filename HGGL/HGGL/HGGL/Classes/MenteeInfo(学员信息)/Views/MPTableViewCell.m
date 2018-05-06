//
//  MPTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MPTableViewCell.h"
#import "HGLable.h"
#import "MenteeProject.h"
#import "TextFrame.h"

#define Width 65
@interface MPTableViewCell ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *name;
@property (nonatomic,weak) UILabel *time;
@end
@implementation MPTableViewCell

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
    self.ima = ima;
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    [self.contentView addSubview:ima];
    
    UILabel *name = [HGLable  lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    name.font = [UIFont fontWithName:@"Helvetica-Bold" size:HGFont];
    [self.contentView addSubview:name];
    self.name = name;
    
    UILabel *time = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    self.time = time;
    [self.contentView addSubview:time];
}
-(void)setMP:(MenteeProject *)MP
{
    _MP = MP;
    
    self.name.text = MP.project_name;
    self.time.text = [NSString stringWithFormat:@"%@ - %@",MP.project_start,MP.project_end];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGFloat H = 30;
    self.ima.frame = CGRectMake(0, H/2-CellWMargin/2, CellWMargin, CellWMargin);
    self.name.frame = CGRectMake(CellWMargin, 0, HGScreenWidth - 2*CellWMargin, H);
    self.time.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.name.frame), self.name.width, H);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"MPTableViewCell";
    MPTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[MPTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSeparatorStyleNone;
    return cell;
}
@end
