//
//  TeacherListHeader.m
//  SYDX_2
//
//  Created by mac on 15-7-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeacherListHeader.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "PopTableViewController.h"
#import "TeacherListParama.h"
#import "ImageRightBut.h"
@interface TeacherListHeader()<UISearchBarDelegate>

@property (nonatomic,strong) NSArray *arrArea;
@property (nonatomic,strong) NSArray *arrType;
@property (nonatomic,strong) NSArray *arrSex;
@property (nonatomic,weak) UIButton *area;
@property (nonatomic,weak) UIButton *type;
@property (nonatomic,weak) UIButton *sex;
@property (nonatomic,strong) PopTableViewController *popView;
@property (nonatomic,weak) UIButton *selectedBut;
@property (nonatomic,strong) TeacherListParama *parama;
@property (nonatomic,strong) UIView *accessoryView;
@end
@implementation TeacherListHeader
-(TeacherListParama *)parama
{
    if (_parama == nil) {
        _parama = [[TeacherListParama alloc]init];
    }
    return _parama  ;
}
//-(NSArray *)arrArea
//{
//    if (_arrArea == nil) {
//        _arrArea = [NSArray arrayWithObjects:@"全部",@"顺义区内",@"顺义区外", nil];
//    }
//    return _arrArea;
//}
-(NSArray *)arrType
{
    if (_arrType == nil) {
        _arrType = [NSArray arrayWithObjects:@"全部",@"自有师资",@"特聘教授",@"学员师资", nil];
    }
    return _arrType;
}
-(NSArray *)arrSex
{
    if (_arrSex == nil) {
        _arrSex = [NSArray arrayWithObjects:@"全部",@"男",@"女", nil];
    }
    return _arrSex;
}
-(UIView *)accessoryView
{
    if (_accessoryView == nil) {
        UIView *accessoryView = [[UIView alloc]init];
        accessoryView.frame = CGRectMake(0, 0, HGScreenWidth, 30);
        accessoryView.backgroundColor = [UIColor lightGrayColor];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        cancle.backgroundColor = [UIColor redColor];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
        [cancle setTitle:@"取消" forState:UIControlStateNormal];
        
        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
        cancle.bounds = CGRectMake(0, 0, 60, 30);
        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        sure.backgroundColor = [UIColor redColor];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        //self.Y = sure;
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        _accessoryView = accessoryView;
        
    }
    return _accessoryView;
}
-(void)cancleA
{
    [self endEditing:YES];
    //[ZKRCover dismiss];
    self.searchBar.text = @"";
}
-(void)sureA
{
    self.parama.str = self.searchBar.text;
    [self endEditing:YES];
    if (_butClick) {
        _butClick(self.parama);
    }
    [self endEditing:YES];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UISearchBar *search = [[UISearchBar alloc]init];
        search.placeholder = @"请输入关键字:如教师名称、单位等";
        search.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar = search;
//        search.inputAccessoryView = self.accessoryView;
        search.delegate = self;
        [self addSubview:search];
        [self setUpAllSubviews];
    }
    return self;
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            //            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateSelected];
        }
    }
    
    //显示键盘
    [self.searchBar becomeFirstResponder];
}

//点击cancel时候
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
    [searchBar endEditing:YES];
    searchBar.text = nil;
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    
    searchBar.showsCancelButton = NO;
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_butClick) {
        _butClick(self.parama);
    }
}
-(void)setUpAllSubviews
{
    //添加类型选择按钮
//    UIButton *area = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
//    [self attOfBut:area];
//    [area setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
//    [area setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
//    [area setTitle:@"区域范围" forState:UIControlStateNormal];
//    [area addTarget:self action:@selector(clickArea) forControlEvents:UIControlEventTouchUpInside];
//    self.area = area;
//    //[type sizeToFit];
//    [self addSubview:area];
    //添加周期选择按钮
    UIButton *type = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [type setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [type  setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [self attOfBut:type];
    [type setTitle:@"聘任类型" forState:UIControlStateNormal];
    [type addTarget:self action:@selector(clickType) forControlEvents:UIControlEventTouchUpInside];
    self.type = type;
    
    [self addSubview:type];
    
    //添加运行状态选择按钮
    UIButton *sex = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [sex setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [sex setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [self attOfBut:sex];
    [sex setTitle:@"性别" forState:UIControlStateNormal];
    [sex addTarget:self action:@selector(clickSex) forControlEvents:UIControlEventTouchUpInside];
    self.sex = sex;
    
    [self addSubview:sex];
}
-(void)attOfBut:(UIButton *)but
{
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.titleLabel.font = ZKRButFont;
    //but.backgroundColor = [UIColor whiteColor];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
//-(void)clickArea
//{
//    self.area.selected = !self.area.selected;
//    CGRect rect = CGRectMake(0, 64+70, HGScreenWidth/3, 44*3);
//    //[self coverAndPop:self.area andArray:self.arrArea andRect:rect];    //_selectedBut.backgroundColor = [UIColor clearColor];
//    if (self.area.selected) {
//        
//        //but.backgroundColor = [UIColor purpleColor];
//        ZKRCover *cover = [ZKRCover show];
//        cover.dimBackGround = YES;
//        cover.ZKRCoverDismiss = ^(){
//            [CurrImageView dismiss];
//            self.area.selected = NO;
//            self.popView = nil;
//        };
//        //CGRect rect = CGRectMake(0, 104+3+60, HGScreenWidth/3, 44*5);
//        PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:self.arrArea];
//        self.popView = popView;
//        //HGLog(@"%@",arr);
//        //popView.tableView.backgroundColor = [UIColor redColor];
//        //TeacherListParama *parama = [[TeacherListParama alloc]init];
//        __weak typeof(self) weakSelf = self;
//        popView.selectedCell = ^(NSString *str)
//        {
//            [self.area setTitle:str forState:UIControlStateNormal];
//            if ([str isEqualToString:[weakSelf.arrArea objectAtIndex:0]]) {
//                weakSelf.parama.teacher_area = @"";
//            }else if ([str isEqualToString:[weakSelf.arrArea objectAtIndex:1]])
//            {
//                weakSelf.parama.teacher_area = @"1";
//                //[but setTitle:@"工作流" forState:UIControlStateNormal];
//            }else if ([str isEqualToString:[weakSelf.arrArea objectAtIndex:2]])
//            {
//                weakSelf.parama.teacher_area = @"2";
//            }
//            if (_butClick) {
//                _butClick(weakSelf.parama);
//            }
//            [CurrImageView dismiss];
//            [ZKRCover dismiss];
//            weakSelf.area.selected = NO;
//            weakSelf.popView = nil;
//        };
//    }else{
//        //.backgroundColor = [UIColor clearColor];
//        [ZKRCover dismiss];}
//}
-(void)clickType
{
    self.type.selected = !self.type.selected;
    CGRect rect = CGRectMake(0, 64+70, HGScreenWidth/2, 44*self.arrType.count);
    //ZKRCover
    //_selectedBut.backgroundColor = [UIColor clearColor];
    if (self.type.selected) {
        
        //but.backgroundColor = [UIColor purpleColor];
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            [CurrImageView dismiss];
            self.type.selected = NO;
            self.popView = nil;
        };
        //CGRect rect = CGRectMake(0, 104+3+60, HGScreenWidth/3, 44*5);
        PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:self.arrType  ];
        self.popView = popView;
        //HGLog(@"%@",arr);
        //popView.tableView.backgroundColor = [UIColor redColor];
        //TeacherListParama *parama = [[TeacherListParama alloc]init];
        __weak typeof(self) weakSelf = self;
        popView.selectedCell = ^(NSString *str)
        {
            [self.type setTitle:str forState:UIControlStateNormal];
            if ([str isEqualToString:[weakSelf.arrType objectAtIndex:0]]) {
                weakSelf.parama.teacher_type = @"";
            }else if ([str isEqualToString:[weakSelf.arrType objectAtIndex:1]])
            {
                weakSelf.parama.teacher_type = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:[weakSelf.arrType objectAtIndex:2]])
            {
                weakSelf.parama.teacher_type = @"2";
            }
            if (_butClick) {
                _butClick(weakSelf.parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            weakSelf.type.selected = NO;
            weakSelf.popView = nil;
        };
    }else{
        //but.backgroundColor = [UIColor clearColor];
        [ZKRCover dismiss];
    }
}
-(void)clickSex
{
    self.sex.selected = !self.sex.selected;
    CGRect rect = CGRectMake(HGScreenWidth/2, 64+70, HGScreenWidth/2, 44*3);
    //_selectedBut.backgroundColor = [UIColor clearColor];
    if (self.sex.selected) {
        
        //but.backgroundColor = [UIColor purpleColor];
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss = ^(){
            [CurrImageView dismiss];
            self.sex.selected = NO;
            self.popView = nil;
        };
        //CGRect rect = CGRectMake(0, 104+3+60, HGScreenWidth/3, 44*5);
        PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:self.arrSex];
        self.popView = popView;
        //HGLog(@"%@",arr);
        //popView.tableView.backgroundColor = [UIColor redColor];
        //TeacherListParama *parama = [[TeacherListParama alloc]init];
        __weak typeof(self) weakSelf = self;
        popView.selectedCell = ^(NSString *str)
        {
            [self.sex setTitle:str forState:UIControlStateNormal];
            if ([str isEqualToString:[weakSelf.arrSex objectAtIndex:0]]) {
                weakSelf.parama.teacher_sex = @"";
            }else if ([str isEqualToString:[weakSelf.arrSex objectAtIndex:1]])
            {
                weakSelf.parama.teacher_sex = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:[weakSelf.arrSex objectAtIndex:2]])
            {
                weakSelf.parama.teacher_sex = @"0";
            }
            if (_butClick) {
                _butClick(weakSelf.parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            weakSelf.sex.selected = NO;
            weakSelf.popView = nil;
        };    }else{
        //but.backgroundColor = [UIColor clearColor];
        [ZKRCover dismiss];
    }}
//-(void)coverAndPop:(UIButton *)but andArray:(NSArray *)arr andRect:(CGRect)rect
//{
//    //_selectedBut.selected = NO;
//    //_selectedBut.backgroundColor = [UIColor clearColor];
//    if (but.selected) {
//        
//        //but.backgroundColor = [UIColor purpleColor];
//        ZKRCover *cover = [ZKRCover show];
//        cover.dimBackGround = YES;
//        cover.ZKRCoverDismiss = ^(){
//            [CurrImageView dismiss];
//            but.selected = NO;
//            self.popView = nil;
//        };
//        //CGRect rect = CGRectMake(0, 104+3+60, HGScreenWidth/3, 44*5);
//        PopTableViewController *popView = [PopTableViewController setPopViewWith:rect And:arr];
//        self.popView = popView;
//        HGLog(@"%@",arr);
//        //popView.tableView.backgroundColor = [UIColor redColor];
//        popView.selectedCell = ^(NSString *str)
//        {
//            [CurrImageView dismiss];
//            [ZKRCover dismiss];
//            but.selected = NO;
//            self.popView = nil;
//        };
//    }else{
//        but.backgroundColor = [UIColor clearColor];
//        [ZKRCover dismiss];
//    }
//    _selectedBut = but;
//}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int i = 0;
    CGFloat width = HGScreenWidth/2;
    CGFloat heigh = 30;
    for (UIView *view in self.subviews) {
        if (i == 0) {
            view.frame = CGRectMake(0, 5, HGScreenWidth-10 , heigh);
        }else{
            //view.backgroundColor = [UIColor greenColor];
            
            view.frame = CGRectMake((i-1)*width, 40, width-5, heigh);
            
        }
        i++;
    }
}
@end
