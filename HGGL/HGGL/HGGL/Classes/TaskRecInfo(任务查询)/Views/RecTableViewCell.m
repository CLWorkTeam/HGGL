//
//  RecTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "RecTableViewCell.h"
@interface RecTableViewCell()
@property (nonatomic,strong) NSMutableArray *arr;
@end
@implementation RecTableViewCell
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setAllSubViews];
    }
    return self;
}
-(void)setAllSubViews
{
    for (int i = 0; i<3; i++) {
        UILabel *lab = [[UILabel alloc]init];
        
        lab.font = [UIFont systemFontOfSize:14];
        lab.textAlignment = NSTextAlignmentCenter;
        lab.textColor = [UIColor blackColor];
        //lab.backgroundColor = [UIColor redColor];
        [self.arr addObject:lab];
        [self.contentView addSubview:lab];
    }
    UIButton *but = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.textColor = [UIColor blackColor];
    but.userInteractionEnabled = NO;
    //but.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:but];
    [self.arr addObject:but];
}
-(void)setOne:(NSString *)one
{
    _one = one;
    UILabel *lab = [self.arr objectAtIndex:0];
    lab.text = one;
}
-(void)setTwo:(NSString *)two
{
    _two = two;
    UILabel *lab = [self.arr objectAtIndex:1];
    lab.text = two;
    
}
-(void)setThree:(NSString *)three

{
    _three = three;
    UILabel *lab = [self.arr objectAtIndex:2];
    lab.text = three;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat w = HGScreenWidth/11;
    
    CGFloat y = 0;
    CGFloat h = 44;
    //NSLog(@"%f-%f",w,h);
    int i = 0;
    for (UIView *lab in self.arr) {
        switch (i) {
            case 0:
                lab.frame = CGRectMake(0, y, 2*w, h);
                break;
            case 1:
                lab.frame = CGRectMake(2*w, y, 4*w, h);
                break;
            case 2:
                lab.frame = CGRectMake(6*w, y, 4*w, h);
                break;
            case 3:
                lab.frame = CGRectMake(10*w, y, w, h);
                //lab.backgroundColor = [UIColor yellowColor];
                break;
            default:
                break;
        
    }
        i++;
    }
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    RecTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[RecTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    return cell;
}
@end
