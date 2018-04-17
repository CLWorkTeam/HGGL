//
//  MenteeListHeader.m
//  SYDX_2
//
//  Created by mac on 15-8-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeListHeader.h"
#import "MenteeParama.h"
@interface MenteeListHeader()<UISearchBarDelegate,UIGestureRecognizerDelegate>
@property (nonatomic,weak) UISearchBar *searchBar;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) UIButton *selectedBut;
@property (nonatomic,strong) MenteeParama *parama;
@property (nonatomic,strong) UIView *accessoryView;

@end
@implementation MenteeListHeader
-(MenteeParama *)parama
{
    if (_parama == nil) {
        _parama = [[MenteeParama alloc]init];
        _parama.mentee_sex = @"2";
    }
    return _parama;
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
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UISearchBar *search = [[UISearchBar alloc]init];
        search.placeholder = @"请输入关键字:如学员名称、单位等";
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
    
    UIButton *all = [UIButton buttonWithType:UIButtonTypeCustom];
    [all setImage:[UIImage imageNamed:@"radio-_n"] forState:UIControlStateNormal];
    [all setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    [all setTitle:@"全部" forState:UIControlStateNormal];
    [all setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    all.titleLabel.font = [UIFont systemFontOfSize:14];
    [all addTarget:self action:@selector(clickAll:) forControlEvents:UIControlEventTouchUpInside];
    all.selected = YES;
    _selectedBut = all;
    [self.arr addObject:all];
    [self addSubview:all];
    UIButton *men = [UIButton buttonWithType:UIButtonTypeCustom];
    [men setImage:[UIImage imageNamed:@"radio-_n"] forState:UIControlStateNormal];
    [men setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    [men setTitle:@"男" forState:UIControlStateNormal];
    [men setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    men.titleLabel.font = [UIFont systemFontOfSize:14];
    [men addTarget:self action:@selector(clickmen:) forControlEvents:UIControlEventTouchUpInside];
    [self.arr addObject:men];
    [self addSubview:men];
    UIButton *women = [UIButton buttonWithType:UIButtonTypeCustom];
    [women setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [women setImage:[UIImage imageNamed:@"radio-_n"] forState:UIControlStateNormal];
    [women setImage:[UIImage imageNamed:@"radio"] forState:UIControlStateSelected];
    [women setTitle:@"女" forState:UIControlStateNormal];
    women.titleLabel.font = [UIFont systemFontOfSize:14];
    [women addTarget:self action:@selector(clickwomen:) forControlEvents:UIControlEventTouchUpInside];
    [self.arr addObject:women];
    [self addSubview:women];
    
    
}
-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
//    UISwipeGestureRecognizer *swipeDown = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handelDiction:)];
//    swipeDown.direction = UISwipeGestureRecognizerDirectionDown;
//    swipeDown.delegate = self;
//    swipeDown.numberOfTouchesRequired = 1;
//    [self addGestureRecognizer:swipeDown];
//    //[swipeDown requireGestureRecognizerToFail:pan];
//    //[pan requireGestureRecognizerToFail:swipeDown];

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

//-(void)handelDiction:(UISwipeGestureRecognizer *)recognizer
//{
//    HGLog(@"swipdown");
//    if (recognizer.direction == UISwipeGestureRecognizerDirectionDown ) {
//        [self endEditing:YES];
//        for (UIGestureRecognizer *recognizer in self.gestureRecognizers) {
//            [self removeGestureRecognizer:recognizer];
//            HGLog(@"移除");
//        }
//    }
//    
//}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.parama.str = searchBar.text;
    [self endEditing:YES];
    if (_butClick) {
        _butClick(self.parama);
    }
}
-(void)clickmen:(UIButton *)but
{
    _selectedBut.selected = NO;
    but.selected = YES;
    _selectedBut = but;
    self.parama.mentee_sex = @"0";
    if (_butClick) {
        _butClick(self.parama);
    }
    
}
-(void)clickwomen:(UIButton *)but
{
    _selectedBut.selected = NO;
    but.selected = !but.selected;
    _selectedBut = but;
    self.parama.mentee_sex = @"1";
    if (_butClick) {
        _butClick(self.parama);
    }
}
-(void)clickAll:(UIButton *)but
{
    _selectedBut.selected = NO;
    but.selected = !but.selected;
    _selectedBut = but;
    self.parama.mentee_sex = @"2";
    if (_butClick) {
        _butClick(self.parama);
    }
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(0, 0, HGScreenWidth, 30);
    CGFloat margin = 30;
    CGFloat W = (HGScreenWidth - 2*30)/3;
    int i = 0;
    for (UIButton *but in self.arr) {
        but.frame = CGRectMake(margin+i*W, 30, W, 30);
        i++;
    }
}
@end
