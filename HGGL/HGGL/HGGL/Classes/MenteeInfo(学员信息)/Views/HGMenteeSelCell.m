//
//  HGMenteeSelCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/5.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGMenteeSelCell.h"
#import "TextFrame.h"
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGFont] Andwidth:60].height
#define cellHigh minH+2*CellHMargin
@interface HGMenteeSelCell ()
@property (nonatomic,weak) UILabel *key;
@property (nonatomic,weak) UILabel *value;
@property (nonatomic,weak) UIImageView  *ima;
@end
@implementation HGMenteeSelCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
    
    UILabel *key = [[UILabel alloc]init];
    key.textAlignment = NSTextAlignmentLeft;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:HGFont];
    self.key = key;
    [self.contentView addSubview:key];
    
    
    UILabel *value = [[UILabel alloc]init];
    value.textAlignment = NSTextAlignmentLeft;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    self.value = value;
    [self.contentView addSubview:value];
    
    UIImageView  *ima = [[UIImageView alloc]init];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"icon_right" ofType:@"png"];
    ima.image = [UIImage imageWithContentsOfFile:path];
    self.ima = ima;
    [self.contentView addSubview:ima];
    
}
-(void)setName:(NSString *)name
{
    // NSLog(@"arr");
    _name = name;
    
    
    self.key.text = name;
    
    
    
}
-(void)setNameV:(NSString *)nameV
{
    _nameV = nameV;
    self.value.text = nameV;
    
    
    
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.key sizeToFit];
    CGFloat mar = 5;
    self.key.frame = CGRectMake(CellWMargin, CellHMargin, self.key.width, minH);
    
    self.value.frame = CGRectMake(self.key.maxX+mar, CellHMargin, self.width-2*CellWMargin-mar-self.key.width, minH);
    self.key.center = CGPointMake(self.key.center.x, self.height/2);
    self.value.center = CGPointMake(self.value.center.x, self.height/2);
    
    self.ima.frame = CGRectMake(self.width-CellWMargin-self.key.height,self.height/2-self.key.height/2, self.key.height, self.key.height);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGMenteeSelCell";
    HGMenteeSelCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell = [[HGMenteeSelCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
