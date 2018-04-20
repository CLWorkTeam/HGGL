//
//  TKProfessionTableViewCell.m
//  泰行销
//
//  Created by 磊陈 on 2017/7/21.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKProfessionTableViewCell.h"
#define verMargin 20
#define  horMargin 30
#define linH 0.5
#define minH(value) [TextFrame frameOfText:@"呵呵" With:[UIFont systemFontOfSize:value] Andwidth:1000].height
@interface TKProfessionTableViewCell ()
@property (nonatomic,weak) UILabel *contentLable;
//@property (nonatomic,weak) UIView *line;
@end
@implementation TKProfessionTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UILabel *contentLable = [[UILabel alloc]init];
        contentLable.numberOfLines = 0;
        contentLable.textColor = [UIColor blackColor];
        contentLable.textAlignment = NSTextAlignmentCenter;
        contentLable.font = [UIFont systemFontOfSize:HGFont];
        self.contentLable = contentLable;
        [self.contentView  addSubview:contentLable];
        //        UIView *line = [[UIView alloc]init];
        //        line.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        //        [self.contentView addSubview:line];
        //        self.line = line;
    }
    return self;
}

-(void)setContent:(NSString *)content
{
    _content = content;
    self.contentLable.text = content;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
//    CGFloat height = [TextFrame frameOfText:self.contentLable.text With:self.contentLable.font Andwidth:self.width-2*horMargin].height;
    self.contentLable.frame = CGRectMake(3, 0, self.width-2*3, self.height);
//    self.line.frame = CGRectMake(0, self.height-linH, self.width, linH);
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    NSString *ID = @"professionCell";
    TKProfessionTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    //    cell.separatorInset = UIEdgeInsetsMake(0, horMargin, 0, 0);
    if (cell == nil) {
        cell = [[TKProfessionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
