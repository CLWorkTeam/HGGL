

//
//  AuditHeaderVIew.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/4/11.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "AuditHeaderView.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "ProjectListParama.h"
#import "PopTableViewController.h"
#import "ProjectTime.h"
#import "ImageRightBut.h"
@interface AuditHeaderView()<UISearchBarDelegate>

@property (nonatomic,strong) NSArray *arrType;
@property (nonatomic,strong) NSArray *arrTime;
@property (nonatomic,strong) NSArray *arrAudit;
@property (nonatomic,weak) UIButton *type;
@property (nonatomic,weak) UIButton *time;
@property (nonatomic,weak) UIButton *runState;
@property (nonatomic,strong)PopTableViewController *pop;
@property (nonatomic,weak) UIButton *selectedBut;
@property (nonatomic, strong) UIButton *myButton1;
@property (nonatomic,strong) UIView *accessoryView;
@end

@implementation AuditHeaderView
-(ProjectAuditParama *)parama

{
    if (_parama == nil) {
        _parama = [[ProjectAuditParama alloc]init];
        _parama.user_id = @"1";
        _parama.pageSize = @"10";
    }
    return _parama;
}
-(NSArray *)arrType
{
    if (_arrType == nil) {
        _arrType = [NSArray arrayWithObjects:@"全部",@"主体班次",@"委托班次",@"对接班次", nil];
    }
    return _arrType;
}
-(NSArray *)arrAudit
{
    if (_arrAudit == nil) {
        _arrAudit  = [NSArray arrayWithObjects:@"所有",@"待审核",@"审核未通过",@"审核通过",@"院级审核", nil];
    }
    return _arrAudit;
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
    if (_clickBut) {
        _clickBut(self.parama);
    }
    [self endEditing:YES];
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UISearchBar *search = [[UISearchBar alloc]init];
        //self.backgroundColor = [UIColor blackColor];
        search.searchBarStyle = UISearchBarStyleMinimal;
        search.placeholder = @"请输入关键字如项目名称、项目编号等";
        _searchBar = search;
//        search.inputAccessoryView = self.accessoryView;
        search.delegate = self;
        [self addSubview:search];
        [self setButtons];
        
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
    if (_clickBut) {
        _clickBut(self.parama);
    }
}
-(void)setButtons
{
    //添加类型选择按钮
    UIButton *type = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [self attOfBut:type];
    [type setTitle:@"项目类型" forState:UIControlStateNormal];
    [type setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [type setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [type addTarget:self action:@selector(clickType) forControlEvents:UIControlEventTouchUpInside];
    self.type = type;
    //[type sizeToFit];
    [self addSubview:type];
    
    //添加周期选择按钮
    UIButton *time = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [time setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [time setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [self attOfBut:time];
    [time setTitle:@"时间周期" forState:UIControlStateNormal];
    [time addTarget:self action:@selector(clickTime) forControlEvents:UIControlEventTouchUpInside];
    self.time = time;
    [self addSubview:time];
    
    //添加运行状态选择按钮
    UIButton *runState = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [runState setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [runState setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [self attOfBut:runState];
    [runState setTitle:@"审批状态" forState:UIControlStateNormal];
    [runState addTarget:self action:@selector(clickRunState) forControlEvents:UIControlEventTouchUpInside];
    self.runState = runState;
    
    [self addSubview:runState];
}
-(void)attOfBut:(UIButton *)but
{
    [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    but.titleLabel.font = ZKRButFont;
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    int i = 0;
    CGFloat width = HGScreenWidth/3;
    CGFloat heigh = 30;
    for (UIView *view in self.subviews) {
        if (i == 0) {
            view.frame = CGRectMake(0, 5, HGScreenWidth , heigh);
        }else{
            view.frame = CGRectMake((i-1)*width, 40, width, heigh);
        }
        i++;
    }
}
-(void)clickType
{
    self.type.selected = !self.type.selected;
    
    // but.selected = !but.selected;
    if (self.type.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss=^{
            [CurrImageView dismiss];
            self.type.selected = NO;
        };
        NSArray *arr = self.arrType;
        CGRect rect = CGRectMake(0, 64+40+30, HGScreenWidth/3, arr.count*44);
        PopTableViewController *pop = [PopTableViewController setPopViewWith:rect And:arr];
        self.pop = pop;
        __weak typeof(self)weakSelf = self;
        pop.selectedCell = ^(NSString *str){
            
            //HGLog(@"%@",str);
            
            [self.type setTitle:str forState:UIControlStateNormal];
            //ProjectListParama  *parama = [[ProjectListParama alloc]init];
            if ([str isEqualToString:@"全部"]) {
                weakSelf.parama.project_type = @"";
            }else if ([str isEqualToString:@"主体班次"])
            {
                weakSelf.parama.project_type = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:@"委托班次"])
            {
                weakSelf.parama.project_type = @"2";
            } else
            {
                weakSelf.parama.project_type = @"3";
            }
            
            if (_clickBut) {
                _clickBut(weakSelf.parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            weakSelf.type.selected = NO;
            weakSelf.pop = nil;
        };
        
    }else
    {
        [CurrImageView   dismiss];
    }
    
    
    
}
-(void)clickTime
{
    self.time.selected = !self.time.selected;
    if (self.time.selected) {
      
        if (_timeBlock) {
            
            _timeBlock(YES);
        }
       
    }else{
        if (_timeBlock) {
            _timeBlock(NO);
        }
        [CurrImageView dismiss];
    }
}
-(void)clickRunState
{
    self.runState.selected = !self.runState.selected;
    //self.type.selected = !self.type.selected;
    
    // but.selected = !but.selected;
    if (self.runState.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss=^{
            [CurrImageView dismiss];
            self.runState.selected = NO;
        };
        NSArray *arr = self.arrAudit;
        CGRect rect = CGRectMake(HGScreenWidth/3*2-15, 64+40+30, HGScreenWidth/3+15, arr.count*44);
        PopTableViewController *pop = [PopTableViewController setPopViewWith:rect And:arr];
        self.pop = pop;
        __weak typeof(self)weakSelf = self;
        pop.selectedCell = ^(NSString *str){
            
            //HGLog(@"%@",str);
            
            [self.runState setTitle:str forState:UIControlStateNormal];
            //ProjectListParama  *parama = [[ProjectListParama alloc]init];
            if ([str isEqualToString:[self.arrAudit objectAtIndex:0]]) {
                weakSelf.parama.project_manage_status = @"";
            }else if ([str isEqualToString:[self.arrAudit objectAtIndex:1]])
            {
                weakSelf.parama.project_manage_status = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:[self.arrAudit objectAtIndex:2]])
            {
                weakSelf.parama.project_manage_status = @"2";
            }else if ([str isEqualToString:[self.arrAudit objectAtIndex:3]])
            {
                weakSelf.parama.project_manage_status = @"3";
            }else
            {
                weakSelf.parama.project_manage_status = @"4";
            }
            if (_clickBut) {
                _clickBut(weakSelf.parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            weakSelf.runState.selected = NO;
            weakSelf.pop = nil;
        };
        
    }else
    {
        [CurrImageView   dismiss];
    }
}
@end
