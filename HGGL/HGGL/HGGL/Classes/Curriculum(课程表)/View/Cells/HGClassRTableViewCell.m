//
//  HGClassRTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/19.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassRTableViewCell.h"
#import "TextFrame.h"
#import "HGLable.h"
#import "HGCRModel.h"
#define TitleFont [UIFont systemFontOfSize:14]
#define ContexFont [UIFont systemFontOfSize:14]
@interface HGClassRTableViewCell ()
@property (nonatomic,weak) UIImageView *ima;
@property (nonatomic,weak) UILabel *titleLable;
@property (nonatomic,weak) UILabel *timeLable;
@property (nonatomic,weak) UILabel *peopleLable;
@end
@implementation HGClassRTableViewCell

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
    [self.contentView addSubview:ima];
    self.ima = ima;
    
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    [self.contentView  addSubview:title];
    self.titleLable = title;
    
    UILabel *courseNL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView addSubview:courseNL];
    self.timeLable = courseNL;
    
    UILabel *projectNL = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    [self.contentView addSubview:projectNL];
    self.peopleLable = projectNL;
    
    
}
-(void)setModel:(HGCRModel *)model
{
    _model = model;
    
    self.titleLable.text = model.receptionName;
    
    self.timeLable.text = [NSString stringWithFormat:@"%@至%@",model.startTime,model.endTime];
    
    self.peopleLable.text = [NSString stringWithFormat:@"负责人：%@",model.principle];
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat imaH = [TextFrame frameOfText:@"马克思主义" With:[UIFont fontWithName:@"Helvetica-Bold" size:14] Andwidth:HGScreenWidth-CellWMargin*2].height;
    self.ima.frame = CGRectMake(0, CellHMargin, CellWMargin, CellWMargin);
    self.titleLable.frame = CGRectMake(self.ima.maxX, self.ima.y, self.width-2*CellWMargin, imaH);
    self.timeLable.frame = CGRectMake(self.titleLable.x, self.titleLable.maxY+CellHMargin, self.titleLable.width, self.titleLable.height);
    self.peopleLable.frame = CGRectMake(self.titleLable.x, self.timeLable.maxY+CellHMargin, self.titleLable.width, self.titleLable.height);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGClassRTableViewCell";
    HGClassRTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGClassRTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
