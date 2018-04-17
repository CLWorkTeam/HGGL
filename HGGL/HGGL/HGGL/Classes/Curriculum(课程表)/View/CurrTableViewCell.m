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
        self.contentView.backgroundColor = [UIColor blackColor];
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
        but.titleLabel.numberOfLines = 4;
        //[but setBackgroundColor:[UIColor redColor]];
        //[but setBackgroundColor:[UIColor redColor]];
        but.backgroundColor = [UIColor whiteColor];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:10];
        [self.butArr addObject:but];
        [self.contentView addSubview:but];
        but.tag = i;
        but.course_classroom = cu.course_classroom;
        
        
        //CurrseList *cl = [self.arr objectAtIndex:i-1];
        CGFloat currW = (HGScreenWidth - ClassroomW-HGSpace*5)/3;
        if (i == 0) {
            but.frame = CGRectMake(HGSpace, HGSpace, ClassroomW, j*(CurrseH+HGSpace)-HGSpace);
            [but setTitle:cu.course_classroom forState:UIControlStateNormal];
            [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
            [but setBackgroundColor:[UIColor lightGrayColor]];
            self.but = but;
            [but addTarget:self action:@selector(clickRoom:) forControlEvents:UIControlEventTouchUpInside];
        }else if (((i-1)/j == 0)) {
            //HGLog(@"%d",((i-1)/j == 0)&&i);
            but.frame = CGRectMake(HGSpace*2+ClassroomW, HGSpace+((i-1)%j)*(CurrseH+HGSpace), currW, CurrseH);
            
            if (cu.course_AM.count>(i-1)) {
                
                CurrseList *cl = [cu.course_AM objectAtIndex:i-1];
                but.CL = cl;
               // HGLog(@"早%@",cl.course_name);
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
                [but setTitle:cl.course_name forState:UIControlStateNormal];
            }
            //[but setTitle:cl.course_name forState:UIControlStateNormal];
        }else if(((i-1)/j) == 1){
            //HGLog(@"222%d--%d",(i-1)/j == 1,j);
            but.frame = CGRectMake(HGSpace*3+ClassroomW+currW, HGSpace+((i-1)%j)*(CurrseH+HGSpace), currW, CurrseH);
            if (cu.course_PM.count>(i-1-j)) {
                CurrseList *cl = [cu.course_PM objectAtIndex:i-1-j];
                but.CL = cl;
                //HGLog(@"下%@",cl.teacher_pickup);
                HGLog(@"1111%d",i);
                [but setTitle:cl.course_name forState:UIControlStateNormal];
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
                
            }
            
        }else
        {
            but.frame = CGRectMake(HGSpace*4+ClassroomW+2*currW, HGSpace, currW, j*(CurrseH+HGSpace)-HGSpace);
            if (cu.course_NT.count >(i-1-2*j)) {
                CurrseList *cl = [cu.course_NT firstObject];
                but.CL = cl;
                HGLog(@"%@",cl.course_name);
                [but setTitle:cl.course_name forState:UIControlStateNormal];
                [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
            }
            
            
            
        }
        
    }
    
    
}
-(void)clickRoom:(CurrBut *)but
{
    but.selected = !but.selected;
    if (but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        CurrImageView *ima = [CurrImageView showInRect:CGRectMake(HGScreenWidth*0.1, HGScreenHeight*0.25, HGScreenWidth*0.8, HGScreenHeight*0.5)];
        [HGKeywindow addSubview:ima];
        //CurrPopTableViewController *CP = [[CurrPopTableViewController alloc]init];
        self.pop.course_classroom = but.titleLabel.text;
        self.pop.current_date = self.current_date;
        self.pop.tableView.backgroundColor = [UIColor whiteColor];
        ima.contentView = self.pop.tableView;
        cover.ZKRCoverDismiss = ^(){
            
            [CurrImageView  dismiss];
            but.selected = NO;
            self.pop = nil;
            
        };

    }else{
        [CurrImageView dismiss];
        self.pop = nil;
    }
//    CurrImageView *ima = [CurrImageView showInRect:CGRectMake(HGScreenWidth*0.25, HGScreenHeight*0.25, HGScreenWidth*0.5, HGScreenHeight*0.5)];
//    
//    CurrPopTableViewController *CP = [[CurrPopTableViewController alloc]init];
//    CP.course_classroom = but.titleLabel.text;
//    CP.current_date = self.current_date;
//    ima.contentView = CP.tableView;
    
}
-(void)clickBut:(CurrBut *)but
{
    //HGLog(@"点击课程");
    CurrBaseTableViewController *base = [[CurrBaseTableViewController alloc]init];
    base.course_classroom = but.course_classroom;
    base.CL = but.CL;
    base.CL = but.CL;
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
