//
//  ResearchListHeader.m
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchListHeader.h"
#import "ResearchParama.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HGPopView.h"
#import "ImageRightBut.h"
@interface ResearchListHeader()<UISearchBarDelegate>
@property (nonatomic,weak) UISearchBar *search;
@property (nonatomic,weak) UILabel *lab;
@property (nonatomic,weak) UIButton *but;
@property (nonatomic,strong) NSArray *arr;



@end
@implementation ResearchListHeader

-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"全部",@"调训项目",@"委托项目",@"集中工作", nil];
    }
    return _arr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UISearchBar *search = [[UISearchBar alloc]init];
        search.placeholder = @"请输入关键字如课题名称等";
        search.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar = search;
        search.delegate = self;
//        search.inputAccessoryView = self.accessoryView;
        [self addSubview:search];
        [self setButtons];
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
    UILabel *lab = [HGLable  lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    lab.text = @"课题类型";
    self.lab = lab;
    [self addSubview:lab];
    UIButton *type = [ImageRightBut initWithColor:nil andSelColor:nil andTColor:nil andFont:nil];
    [type setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
    [type setImage:[UIImage imageNamed:@"ser_up"] forState:UIControlStateSelected];
    [type setImage:[UIImage imageNamed:@"ser_down"] forState:UIControlStateNormal];
    [type setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    type.titleLabel.font = ZKRButFont;
    type.titleLabel.textAlignment = NSTextAlignmentCenter;
    [type setTitle:@"全部" forState:UIControlStateNormal];
    [type addTarget:self action:@selector(clickType) forControlEvents:UIControlEventTouchUpInside];
    self.but = type;
    
    [self addSubview:type];
}
-(void)clickType
{
    
    CGRect r = [self convertRect:self.but.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*4);
    
    [HGPopView setPopViewWith:rect And:self.arr andShowKey:nil  selectBlock:^(NSString *str) {
        
        [self.but setTitle:str forState:UIControlStateNormal];
        
        if ([str isEqual:@"全部"]) {
            self.parama.research_type = @"";
        }else if ([str isEqual:@"调训项目"])
        {
            self.parama.research_type = @"1";
        }else if([str isEqual:@"委托项目"])
        {
            self.parama.research_type = @"2";
        }else if ([str isEqual:@"集中工作"])
        {
            self.parama.research_type = @"3";
        }
        if ( _clickBut) {
            _clickBut(self.parama);
        }
        
    }];

}
-(void)layoutSubviews
{
    
    [super layoutSubviews];
    CGFloat mar = 5;
    self.searchBar.frame = CGRectMake(0, mar, HGScreenWidth, 30);
    [self.lab sizeToFit];
    self.lab.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.searchBar.frame)+mar, self.lab.width, 30);
    self.but.frame = CGRectMake(self.lab.maxX+mar, self.lab.y,self.width-self.lab.maxX-mar-CellWMargin , 30);
    
}
@end
