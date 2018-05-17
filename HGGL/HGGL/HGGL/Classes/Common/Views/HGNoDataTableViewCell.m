//
//  HGNoDataTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/10.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGNoDataTableViewCell.h"
@interface HGNoDataTableViewCell ()
@property (nonatomic,weak) UILabel *lable;
@end
@implementation HGNoDataTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *contentLable = [[UILabel alloc]init];
        contentLable.text = @"无数据";
        contentLable.textColor = HGColor(193, 193, 193, 1);
        contentLable.textAlignment = NSTextAlignmentCenter;
        contentLable.font = [UIFont systemFontOfSize:HGFont];
        self.lable = contentLable;
        [self.contentView  addSubview:contentLable];
        
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.lable sizeToFit];
    
    self.lable.bounds = CGRectMake(0, 0, self.lable.width, self.lable.height);
    
    self.lable.center = CGPointMake(self.width/2, self.height/2);
    
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    NSString *ID = @"professionCell";
    HGNoDataTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGNoDataTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
