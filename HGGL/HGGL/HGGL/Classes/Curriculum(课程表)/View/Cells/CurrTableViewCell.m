//
//  CurrTableViewCell.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrTableViewCell.h"
#import "Currse.h"
#import "CurrseList.h"
#import "CurrImageView.h"
#import "ElseTableViewController.h"
#import "CurrBaseTableViewController.h"
#import "CurrBut.h"
#import "CurrPopTableViewController.h"
#import "ZKRCover.h"
#import "CurrPopTableViewController.h"
#define ClassroomW 40
#define CurrseH 45
@interface CurrTableViewCell()
@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) CurrPopTableViewController  *pop;
@property (nonatomic,weak) UIButton *but;
@end
@implementation CurrTableViewCell
-(NSMutableArray *)butArr
{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
-(CurrPopTableViewController *)pop
{
    if (_pop == nil) {
        _pop = [[CurrPopTableViewController alloc]init];
        __weak typeof(self) weakSelf = self;
        _pop.currPPopBlock = ^(id vc){
            if (weakSelf.currCellClick) {
                [ZKRCover dismiss];
                [CurrImageView dismiss];
                weakSelf.but.selected = NO;
                weakSelf.currCellClick(vc);
            }
            
        };
    }
    return _pop;
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
-(void)setCu:(Currse *)cu
{
    _cu = cu;
    NSInteger j = cu.course_style.integerValue;
//    if (j == -1) {
//        CurrImageView *view = [CurrImageView showInRect:CGRectMake(HGSpace, 15, self.bounds.size.width-2*HGSpace, self.bounds.size.height-15)];
//        ElseTableViewController *other = [[ElseTableViewController alloc]init];
//        other.arr = cu.course_list;
//        view.contentView = other.tableView;
//    }else{
    for (int i =0; i<j*2+1+1; i++) {
        CurrBut *but = [CurrBut buttonWithType:UIButtonTypeCustom];
        but.titleLabel.numberOfLines = 3;
        but.layer.masksToBounds = YES;
        //[but setBackgroundColor:[UIColor redColor]];
        //[but setBackgroundColor:[UIColor redColor]];
        but.backgroundColor = [UIColor whiteColor];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:12];
        [self.butArr addObject:but];
        [self.contentView addSubview:but];
        but.tag = i;
        but.course_classroom = cu.classroomName;
        
        
        //CurrseList *cl = [self.arr objectAtIndex:i-1];
        CGFloat currW = (HGScreenWidth - ClassroomW-HGSpace*5)/3;
        if (i == 0) {
            but.frame = CGRectMake(HGSpace, HGSpace, ClassroomW, j*(CurrseH+HGSpace)-HGSpace);
            [but setTitle:cu.classroomName forState:UIControlStateNormal];
//            [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [but setBackgroundColor:HGGrayColor];
            self.but = but;
            [but addTarget:self action:@selector(clickRoom:) forControlEvents:UIControlEventTouchUpInside];
        }else if (((i-1)/j == 0)) {
            //HGLog(@"%d",((i-1)/j == 0)&&i);
            but.frame = CGRectMake(HGSpace*2+ClassroomW, HGSpace+((i-1)%j)*(CurrseH+HGSpace), currW, CurrseH);
            
            if (cu.morningList.count>(i-1)) {
                
                CurrseList *cl = [cu.morningList objectAtIndex:i-1];
                but.CL = cl;
               // HGLog(@"早%@",cl.course_name);
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
                [but setTitle:[NSString stringWithFormat:@"%@-%@\n%@-%@",cl.startTime,cl.endTime,cl.courseName,cl.teacher] forState:UIControlStateNormal];
            }
            //[but setTitle:cl.course_name forState:UIControlStateNormal];
        }else if(((i-1)/j) == 1){
            //HGLog(@"222%d--%d",(i-1)/j == 1,j);
            but.frame = CGRectMake(HGSpace*3+ClassroomW+currW, HGSpace+((i-1)%j)*(CurrseH+HGSpace), currW, CurrseH);
            if (cu.afternoonList.count>(i-1-j)) {
                CurrseList *cl = [cu.afternoonList objectAtIndex:i-1-j];
                but.CL = cl;
                //HGLog(@"下%@",cl.teacher_pickup);
                HGLog(@"1111%d",i);
                [but setTitle:[NSString stringWithFormat:@"%@-%@\n%@-%@",cl.startTime,cl.endTime,cl.courseName,cl.teacher] forState:UIControlStateNormal];
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
        }else
        {
            but.frame = CGRectMake(HGSpace*4+ClassroomW+2*currW, HGSpace, currW, j*(CurrseH+HGSpace)-HGSpace);
            if (cu.nightList.count >(i-1-2*j)) {
                CurrseList *cl = [cu.nightList firstObject];
                but.CL = cl;
                HGLog(@"%@",cl.courseName);
                [but setTitle:[NSString stringWithFormat:@"%@-%@\n%@-%@",cl.startTime,cl.endTime,cl.courseName,cl.teacher] forState:UIControlStateNormal];
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            
        }
        
    }
    
    
}
-(void)clickRoom:(CurrBut *)but
{


    
}
-(void)clickBut:(CurrBut *)but
{
    //HGLog(@"点击课程");
    CurrBaseTableViewController *base = [[CurrBaseTableViewController alloc]init];
//    base.course_classroom = but.course_classroom;
    base.courseID = but.CL.courseId;
//    base.CL = but.CL;
    if (_currButClick) {
        _currButClick(base);
    }
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    CurrTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[CurrTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}
@end
