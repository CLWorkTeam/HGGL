//
//  HGScheduleTableViewCell.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/7.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGScheduleTableViewCell.h"
#import "HGScheduleModel.h"
#import "CurrseList.h"
#import "CurrImageView.h"
#import "ElseTableViewController.h"
#import "CurrBaseTableViewController.h"
#import "CurrBut.h"
#import "CurrPopTableViewController.h"
#import "ZKRCover.h"
#import "CurrPopTableViewController.h"
#define ClassroomW 80
#define CurrseH 45
@interface HGScheduleTableViewCell()
@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,strong) NSMutableArray *arr;
@end
@implementation HGScheduleTableViewCell

-(NSMutableArray *)butArr
{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
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
        self.contentView.backgroundColor = HGColor(232, 232, 232, 1);
    }
    return self;
}
-(void)setModel:(HGScheduleModel *)model
{
    _model = model;
    for (int i =0; i<3; i++) {
        CurrBut *but = [CurrBut buttonWithType:UIButtonTypeCustom];
        but.titleLabel.numberOfLines = 4;
        but.backgroundColor = [UIColor whiteColor];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.butArr addObject:but];
        [self.contentView addSubview:but];
        but.tag = 600+i;
        
        if (i == 0) {
            
            [but setTitle:model.courseName forState:UIControlStateNormal];
            //            [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [but setBackgroundColor:HGGrayColor];
            [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
            
        }else if (((i-1) == 0)) {
            //HGLog(@"%d",((i-1)/j == 0)&&i);
            
            [but setTitle:[NSString stringWithFormat:@"%@~%@",model.startTime,model.endTime] forState:UIControlStateNormal];
            
        }else if(i == 2){
            //HGLog(@"222%d--%d",(i-1)/j == 1,j);
            
            [but setTitle:model.classroom forState:UIControlStateNormal];
            
                
            
            
        }
        
    }
}
-(void)clickBut:(CurrBut *)but
{
    CurrBaseTableViewController *base = [[CurrBaseTableViewController alloc]init];
    base.courseID = self.model.courseId;
    //    base.CL = but.CL;
    if (_currButClick) {
        _currButClick(base);
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat currW = (HGScreenWidth - ClassroomW-HGSpace*4)/2;
    for (NSInteger i = 0 ; i<self.butArr.count; i++) {
        UIButton *but = self.butArr[i];
        
        if (i == 0) {
            but.frame = CGRectMake(HGSpace, HGSpace, currW, (CurrseH+HGSpace)-HGSpace);
        }else if (i == 1)
        {
            but.frame = CGRectMake(HGSpace*2+currW, HGSpace, currW, CurrseH);
        }else
        {
            but.frame = CGRectMake(HGSpace*3+2*currW, HGSpace,ClassroomW , CurrseH);
        }
            
    }
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"HGScheduleTableViewCell";
    HGScheduleTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[HGScheduleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
@end
