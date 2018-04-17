//
//  BlacklogTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-20.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BlacklogTableViewCell.h"
#import "BLackLogCommon.h"
#import "TextFrame.h"
//#define magin 10
#define imaWidth 40
//#define labHeigh 20
#define labWidth 50

@interface BlacklogTableViewCell()
@property (nonatomic,weak)UILabel *titleName;
@property (nonatomic,weak)UILabel *typeName;
@property (nonatomic,weak)UILabel *autorName;
@property (nonatomic,weak)UILabel *typeLab;
@property (nonatomic,weak)UILabel *autorLab;
@property (nonatomic,weak)UIImageView *ima;
@end
@implementation BlacklogTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setSubviews];
        
    }
    return self;
}
-(void)setTitle:(NSString *)title
{
    _title = title;
    self.titleName.text = title;
}
-(void)setType:(NSString *)type
{
    _type = type;
    
    switch ([type integerValue]) {
        case WorkFlow:
            self.typeName.text = @"工作流";
            break;
        case Research:
            self.typeName.text = @"科研审批";
            break;
        case Report:
            self.typeName.text = @"公告审批";
            break;
        case Misson:
            self.typeName.text = @"我的项目任务";
            break;
        default:
            break;
    }
    
}
-(void)setAutor:(NSString *)autor
{
    _autor = autor;
    self.autorName.text = autor;
}
-(void)setSubviews
{
    //标题
    UILabel *title = [[UILabel alloc]init];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.textAlignment = NSTextAlignmentLeft;
   
    title.textColor = [UIColor  blackColor];
    //title.backgroundColor = [UIColor redColor];
    self.titleName = title;
    [self addSubview:title];
    //类型
    UILabel *type = [[UILabel alloc]init];
    type.font = [UIFont systemFontOfSize:15];
    type.textAlignment = NSTextAlignmentLeft;
    type.text = @"类   型:";
    type.textColor = [UIColor blackColor];
    self.typeLab = type;
    [self addSubview:type];
    //类型名称
    UILabel *typeName = [[UILabel alloc]init];
    typeName.font = [UIFont systemFontOfSize:15];
    typeName.textAlignment = NSTextAlignmentLeft;
    typeName.textColor = [UIColor blackColor];
   
    [self addSubview:typeName];
    self.typeName = typeName;
    //发布人
    UILabel *autor = [[UILabel alloc]init];
    autor.font = [UIFont  systemFontOfSize:15];
    autor.textAlignment = NSTextAlignmentLeft;
    autor.textColor = [UIColor blackColor];
    autor.text = @"发布人:";
    
    //autor.backgroundColor = [UIColor greenColor];
    self.autorLab = autor;
    [self addSubview:autor];
    //发布人名称
    UILabel *autorName = [[UILabel alloc]init];
    autorName.font = [UIFont systemFontOfSize:15];
    autorName.textAlignment = NSTextAlignmentLeft;
    autorName.textColor = [UIColor blackColor];
    [self addSubview:autorName];
    self.autorName = autorName;
    
    //角标
    UIImageView *ima = [[UIImageView alloc]init];
    self.ima = ima;
    [self addSubview:ima];
    //ima.backgroundColor = [UIColor purpleColor];
    
    
}
-(void)layoutSubviews
{
    [super layoutSubviews ];
    self.titleName.frame = CGRectMake(CellWMargin,CellHMargin, HGScreenWidth-CellWMargin-imaWidth, minH);
    self.typeLab.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.titleName.frame)+CellHMargin,50,minH);
    self.typeName.frame = CGRectMake(CGRectGetMaxX(self.typeLab.frame)+CellHMargin, CGRectGetMaxY(self.titleName.frame)+CellHMargin, HGScreenWidth-CellWMargin-CellHMargin-imaWidth-50, minH);
    self.autorLab.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.typeLab.frame)+CellHMargin, 50, minH);
    self.autorName.frame = CGRectMake(CGRectGetMaxX(self.autorLab.frame)+CellHMargin, CGRectGetMaxY(self.typeLab.frame)+CellHMargin, HGScreenWidth-CellHMargin-imaWidth-50-CellWMargin, minH);
    self.ima.center = CGPointMake(CellWMargin/2, (minH-CellWMargin)/2+CellHMargin);
    self.ima.bounds = CGRectMake(0,0 , CellWMargin, CellWMargin);
}
+(instancetype)cellWithTableview:(UITableView *)view
{
    static NSString *ID = @"cell";
    BlacklogTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[BlacklogTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
