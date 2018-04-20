//
//  HGTRcordTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/18.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGTRcordTableViewCell.h"
#import "HGLable.h"
#import "TextFrame.h"
#import "HGTeachRecord.h"
#import "CSTableViewController.h"
#define butH 30

@interface HGTRcordTableViewCell ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *timeL;
@property (nonatomic,weak) UILabel *timeV;
@property (nonatomic,weak) UILabel *courseNL;
@property (nonatomic,weak) UILabel *courseNV;
@property (nonatomic,weak) UILabel *projectNL;
@property (nonatomic,weak) UILabel *projectNV;
@property (nonatomic,weak) UIButton *scoreB;
@end
@implementation HGTRcordTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
    UIImageView *ima = [[UIImageView alloc]init];
    ima.contentMode = UIViewContentModeCenter;
    ima.image = [UIImage imageNamed:@"point"];
    //ima.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:ima];
    self.ima = ima;
    
    
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.text = @"授课日期:";
    [self.contentView  addSubview:title];
    self.timeL = title;
    
    UILabel *timeV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    timeV.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.contentView addSubview:timeV];
    self.timeV = timeV;
    
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but setTitle:@"授课评分" forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setBackgroundColor:HGMainColor];
    [but addTarget:self action:@selector(scoreClick) forControlEvents:UIControlEventTouchUpInside];
    self.scoreB = but;
    [self.contentView addSubview:but];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    but.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    
    UILabel *courseNL = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
    courseNL.text = @"课程名称:";
    [self.contentView addSubview:courseNL];
    self.courseNL = courseNL;
    
    UILabel *courseNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView addSubview:courseNV];
    self.courseNV = courseNV;
    
    UILabel *projectNL = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGFont Color:[UIColor blackColor]];
    projectNL.text = @"项目名称:";
    [self.contentView addSubview:projectNL];
    self.projectNL = projectNL;
    
    UILabel *projectNV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView addSubview:projectNV];
    self.projectNV = projectNV;
    
    
    
    
    
    
}
-(void)scoreClick
{
    CSTableViewController *cs = [[CSTableViewController alloc]init];
    
    cs.projectCourse_id = self.record.recordId;
    if (_scoreBlock) {
        _scoreBlock(cs);
    }
}
-(void)setRecord:(HGTeachRecord *)record
{
    _record = record;
    
    
    
    self.timeV.text = record.recordDate;
    
    self.courseNV.text = record.courseName;
    
    self.projectNV.text = record.projectName ;
    
    
    [self layoutSubviews];
    
    
    
    
    
   
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat mar = 5;
    CGFloat imaH = [TextFrame frameOfText:@"马克思主义" With:[UIFont fontWithName:@"Helvetica-Bold" size:14] Andwidth:HGScreenWidth-CellWMargin*2].height;
    self.ima.frame = CGRectMake(0, butH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
    
    [self.scoreB sizeToFit];
    
    self.scoreB.frame = CGRectMake(self.width-self.scoreB.width-6-CellWMargin, CellHMargin, self.scoreB.width+6, butH);
    
    [self.timeL sizeToFit];
    
    self.timeL.frame = CGRectMake(self.ima.maxX, CellHMargin, self.timeL.width, butH);
    
    self.timeV.frame = CGRectMake(self.timeL.maxX+mar, CellHMargin, self.scoreB.x-self.timeL.maxX-2*mar, butH);
    
    [self.courseNL sizeToFit];
    
    self.courseNL.frame = CGRectMake(self.timeL.x, self.timeL.maxY+CellHMargin, self.courseNL.width, imaH);
    
    self.courseNV.frame = CGRectMake(self.courseNL.maxX+mar, self.courseNL.y, self.width-self.courseNL.maxX-CellWMargin-mar, imaH);
    
    [self.projectNL sizeToFit];
    
    self.projectNL.frame = CGRectMake(self.courseNL.x, self.courseNL.maxY+CellHMargin, self.projectNL.width, imaH   );
    
    self.projectNV.frame = CGRectMake(self.projectNL.maxX+mar, self.projectNL.y, self.width-self.projectNL.maxX-CellWMargin-mar, imaH);
    
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGTRcordTableViewCell";
    HGTRcordTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGTRcordTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}
@end
