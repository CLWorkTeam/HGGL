//
//  MenteeListHeader.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeListHeader.h"
#import "MenteeParama.h"
#import "TeachToolBar.h"
@interface MenteeListHeader()<UISearchBarDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,weak) TeachToolBar *toolBar;
@property (nonatomic,weak) UIView *grayLine;


@end
@implementation MenteeListHeader


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UISearchBar *search = [[UISearchBar alloc]init];
        search.placeholder = @"请输入关键字:如学员名称等";
        search.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar = search;
        search.delegate = self;
//        search.inputAccessoryView = self.accessoryView;
        [self addSubview:search];
        [self setUpAllSubviews];
    }
    return self;
}
-(void)setUpAllSubviews
{
    
    TeachToolBar *toolBar = [[TeachToolBar alloc]init];
    toolBar.arr = [NSArray arrayWithObjects:@"全部",@"男",@"女", nil];
    [self addSubview:toolBar];
    self.toolBar = toolBar;
    WeakSelf
    self.toolBar.clickChange = ^(NSInteger page){
        
        if (page == 0) {
            weakSelf.parama.mentee_sex = @"2";
        }else if(page == 1)
        {
            weakSelf.parama.mentee_sex = @"0";
        }else
        {
            weakSelf.parama.mentee_sex = @"1";
        }
        if (weakSelf.butClick) {
            weakSelf.butClick(self.parama);
        }
    };
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HGGrayColor;
    self.grayLine = line;
    [self addSubview:line];
    
    
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
    if (_butClick) {
        _butClick(self.parama);
    }
}

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    [searchBar endEditing:YES];
    
    searchBar.showsCancelButton = NO;
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_butClick) {
        _butClick(self.parama);
    }
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_butClick) {
        _butClick(self.parama);
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat Hmar = 5;
    self.searchBar.frame = CGRectMake(0, Hmar, HGScreenWidth, 30);
    self.toolBar.frame = CGRectMake(0, self.searchBar.maxY+Hmar, self.bounds.size.width, 43);
    self.grayLine.frame = CGRectMake(0, self.toolBar.maxY, self.width, 10);
    
}
@end
