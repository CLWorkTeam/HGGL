//
//  TeachTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachTableViewCell.h"
#import "ImageLeftBut.h"
@implementation TeachTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIButton *but = [ImageLeftBut initWithColor:nil andSelColor:nil andTColor:[UIColor blackColor] andFont:[UIFont systemFontOfSize:HGFont]];
        but.backgroundColor = [UIColor clearColor];
        self.name = but;
        [self.contentView  addSubview:but];
        
        UIView *myView = [[UIView alloc] init];
        myView.backgroundColor = HGColor(220, 220, 220,1);
        [self.contentView addSubview:myView];
        self.myView = myView;
    }
    return self;
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    TeachTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[self alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.name.bounds = CGRectMake(0,0, self.bounds.size.width - CellWMargin*2, self.bounds.size.height-2*CellHMargin);
    self.name.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    self.myView.frame= CGRectMake(CellWMargin-5, self.bounds.size.height-1, self.bounds.size.width - CellWMargin*2+10, 1);
}
@end
