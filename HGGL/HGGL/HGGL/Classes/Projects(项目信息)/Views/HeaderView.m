//
//  HeaderView.m
//  SYDX_2
//
//  Created by mac on 15-6-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "HeaderView.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "ProjectListParama.h"
#import "HGPopView.h"
#import "ProjectTime.h"
#import "ImageRightBut.h"
@interface HeaderView()<UISearchBarDelegate>
@property (nonatomic,strong) NSArray *arrType;
@property (nonatomic,strong) NSArray *arrTime;
@property (nonatomic,strong) NSArray *arrRun;
@property (nonatomic,weak) UIButton *type;
@property (nonatomic,weak) UIButton *time;
@property (nonatomic,weak) UIButton *runState;
@property (nonatomic,weak) UIButton *selectedBut;
@property (nonatomic,weak) UIView *line;

@end
@implementation HeaderView
-(ProjectListParama *)parama

{
    if (_parama == nil) {
        _parama = [[ProjectListParama alloc]init];
        
    }
    return _parama;
}

-(NSArray *)arrType
{
    if (_arrType == nil) {
        _arrType = [NSArray arrayWithObjects:@"全部",@"调训项目",@"委托项目",@"集中工作", nil];
    }
    return _arrType;
}

-(NSArray *)arrRun
{
    if (_arrRun == nil) {
        _arrRun  = [NSArray arrayWithObjects:@"全部",@"意向",@"立项",@"延迟",@"取消",@"正在运行",@"已完成", nil];
    }
    return _arrRun;
}




-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UISearchBar *search = [[UISearchBar alloc]init];
    
        //self.backgroundColor = [UIColor blackColor];
        search.searchBarStyle = UISearchBarStyleMinimal;
        search.placeholder = @"请输入关键字如项目名称等";
        _searchBar = search;
//        search.inputAccessoryView = self.accessoryView;
        search.delegate = self;
        [self addSubview:search];
        [self setButtons];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = HGColor(235, 235, 235, 1);
        self.line = line;
        [self addSubview:line];
        
    }
    return self;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    searchBar.showsCancelButton = YES;
    for(UIView *view in  [[[searchBar subviews] objectAtIndex:0] subviews]) {
        if([view isKindOfClass:[NSClassFromString(@"UINavigationButton") class]]) {
            UIButton * cancel =(UIButton *)view;
            [cancel setTitle:@"取消" forState:UIControlStateNormal];
            cancel.titleLabel.font = [UIFont systemFontOfSize:14];
            [cancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
    }
    
    //显示键盘
    [self.searchBar becomeFirstResponder];
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    return YES;
}
//点击cancel时候
-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    //隐藏键盘
    [searchBar resignFirstResponder];
    [searchBar endEditing:YES];
    searchBar.text = nil;
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_clickBut) {
        _clickBut(self.parama);
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    searchBar.showsCancelButton = NO;
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_clickBut) {
        _clickBut(self.parama);
    }
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
    [type addTarget:self action:@selector(clickType:) forControlEvents:UIControlEventTouchUpInside];
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
    [runState setTitle:@"运行状态" forState:UIControlStateNormal];
    [runState addTarget:self action:@selector(clickRunState:) forControlEvents:UIControlEventTouchUpInside];
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
        }else if(i == self.subviews.count-1){
            
            view.frame = CGRectMake(0, self.height-1, self.width, 1);
            
        
        }else
        {
            view.frame = CGRectMake((i-1)*width, 40, width, heigh);
        }
        i++;
    }
}
-(void)clickType:(UIButton *)button
{
    CGRect r = [self convertRect:button.frame toView:HGKeywindow];
    
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*4);
    
    [HGPopView setPopViewWith:rect And:self.arrType andShowKey:nil  selectBlock:^(NSString *str) {
        
        [button setTitle:str forState:UIControlStateNormal];
        
        if ([str isEqual:@"全部"]) {
            self.parama.project_type = @"";
        }else if ([str isEqual:@"调训项目"])
        {
            self.parama.project_type = @"1";
        }else if([str isEqual:@"委托项目"])
        {
            self.parama.project_type = @"2";
        }else if ([str isEqual:@"集中工作"])
        {
            self.parama.project_type = @"3";
        }
        if ( _clickBut) {
            _clickBut(self.parama);
        }
        
    }];


    
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
    }
}
-(void)clickRunState:(UIButton *)button
{
    
    CGRect r = [self convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*4);
    
    [HGPopView setPopViewWith:rect And:self.arrRun andShowKey:nil  selectBlock:^(NSString *str) {
        
        [button setTitle:str forState:UIControlStateNormal];
        
        if ([str isEqual:@"全部"]) {
            self.parama.project_status = @"";
        }else
        {
            if([self.arrRun containsObject:str])
            {
                self.parama.project_status = [NSString stringWithFormat:@"%zd",[self.arrRun indexOfObject:str]];
            }
            
        }
        
        if ( _clickBut) {
            _clickBut(self.parama);
        }
        
    }];
    
}
@end
