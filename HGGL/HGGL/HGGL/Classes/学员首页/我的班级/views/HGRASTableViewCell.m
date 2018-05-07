//
//  HGRASTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/6.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRASTableViewCell.h"
@interface HGRASTableViewCell ()
@property (nonatomic,weak) UILabel *key;
@property (nonatomic,weak) UILabel *value;
@end
@implementation HGRASTableViewCell

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
    key.numberOfLines = 0;
    key.textAlignment = NSTextAlignmentLeft;
    key.textColor = [UIColor blackColor];
    key.font = [UIFont systemFontOfSize:HGFont];
    self.key = key;
    [self.contentView addSubview:key];
    
    
    UILabel *value = [[UILabel alloc]init];
    value.numberOfLines = 0;
    value.textAlignment = NSTextAlignmentLeft;
    value.textColor = [UIColor blackColor];
    value.font = [UIFont systemFontOfSize:HGFont];
    self.value = value;
    
    [self.contentView addSubview:value];
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
    CGFloat minWidth = [TextFrame frameOfText:@"车次/班次：" With:[UIFont systemFontOfSize:HGFont] AndHeigh:100].width;
    
    CGFloat mar = 5;
    CGFloat Hmar = 10;
    CGFloat keyHeight = [TextFrame frameOfText:self.name With:self.key.font Andwidth:minWidth].height;
    keyHeight = ((keyHeight>minH)?keyHeight:minH);
    self.key.frame = CGRectMake(CellWMargin, Hmar, minWidth, keyHeight);
    CGSize size1 = [TextFrame frameOfText:self.nameV With:self.value.font Andwidth:self.width-self.key.width-2*CellWMargin-mar];
    
    CGFloat he = ((size1.height)>(self.key.height))?(size1.height):(self.key.height);
    
    self.value.frame = CGRectMake(self.key.maxX+mar, Hmar, self.width-2*CellWMargin-mar-self.key.width, he);
    
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    HGRASTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        //cell.backgroundColor = [UIColor whiteColor];
        cell = [[HGRASTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

@end
