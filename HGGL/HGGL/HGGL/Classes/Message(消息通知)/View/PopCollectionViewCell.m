//
//  PopCollectionViewCell.m
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/26.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "PopCollectionViewCell.h"
@interface PopCollectionViewCell ()
@end
@implementation PopCollectionViewCell
-(void)setName:(NSString *)name
{
    _name = name;
    UILabel *lab = [[UILabel alloc]init];
    self.lab = lab;
    lab.frame = self.bounds;
    //    lab.backgroundColor = [UIColor blueColor];
    lab.font = [UIFont systemFontOfSize:HGFont];
    lab.layer.borderWidth = 1;
    lab.layer.borderColor = [[UIColor grayColor] CGColor ];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = name;
    [self.contentView addSubview:lab];

}
@end
