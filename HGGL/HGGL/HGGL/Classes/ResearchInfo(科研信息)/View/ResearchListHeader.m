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
#import "PopTableViewController.h"
#import "ImageRightBut.h"
@interface ResearchListHeader()<UISearchBarDelegate>
@property (nonatomic,weak) UISearchBar *search;
@property (nonatomic,weak) UILabel *lab;
@property (nonatomic,weak) UIButton *but;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) PopTableViewController *pop;
@property (nonatomic,strong) ResearchParama *parama;
@property (nonatomic,strong) UIView *accessoryView;
@end
@implementation ResearchListHeader
-(ResearchParama *)parama
{
    if (_parama == nil) {
        _parama = [[ResearchParama alloc]init];
        _parama.user_id = [HGUserDefaults stringForKey:@"userID"];
    }
    return _parama;
}
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"全部",@"顺义区基地课题",@"上级党校立项课题",@"校内立项课题",@"其他课题", nil];
    }
    return _arr;
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
        search.placeholder = @"请输入关键字如项目名称、委托单位等";
        search.searchBarStyle = UISearchBarStyleMinimal;
        _searchBar = search;
        search.delegate = self;
//        search.inputAccessoryView = self.accessoryView;
        [self addSubview:search];
        [self setButtons];
    }
    return self;
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
    self.but.selected = !self.but.selected;
    
    // but.selected = !but.selected;
    if (self.but.selected) {
        ZKRCover *cover = [ZKRCover show];
        cover.dimBackGround = YES;
        cover.ZKRCoverDismiss=^{
            [CurrImageView dismiss];
            self.but.selected = NO;
        };
        NSArray *arr = self.arr;
        CGRect rect = CGRectMake(70, 64+40+30, 200, arr.count*44);
        PopTableViewController *pop = [PopTableViewController setPopViewWith:rect And:arr];
        self.pop = pop;
        __weak typeof(self)weakSelf = self;
        pop.selectedCell = ^(NSString *str){
            
            //HGLog(@"%@",str);
            [self.but setTitle:str forState:UIControlStateNormal];
            //[but setTitle:str forState:UIControlStateNormal];
            //ProjectListParama  *parama = [[ProjectListParama alloc]init];
            if ([str isEqualToString:@"全部"]) {
                weakSelf.parama.research_type = @"";
            }else if ([str isEqualToString:@"顺义区基地课题"])
            {
                weakSelf.parama.research_type = @"1";
                //[but setTitle:@"工作流" forState:UIControlStateNormal];
            }else if ([str isEqualToString:@"上级党校立项课题"])
            {
                weakSelf.parama.research_type = @"2";
            }else if ([str isEqualToString:@"校内立项课题"])
            {
                weakSelf.parama.research_type = @"3";
            }else if ([str isEqualToString:@"其他课题"])
            {
                weakSelf.parama.research_type = @"4";
            }
            
            if (_clickBut) {
                _clickBut(weakSelf.parama);
            }
            [CurrImageView dismiss];
            [ZKRCover dismiss];
            weakSelf.but.selected = NO;
            weakSelf.pop = nil;
        };
        
    }else
    {
        [CurrImageView   dismiss];
    }
    

}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.searchBar.frame = CGRectMake(0, 5, HGScreenWidth, 30);
    self.lab.frame = CGRectMake(0, CGRectGetMaxY(self.searchBar.frame), 70, 30);
    self.but.bounds = CGRectMake(0, 0, 200, 30);
    self.but.center = CGPointMake(CGRectGetMaxX(self.lab.frame)+100, 5+30+(self.height-30-6)/2);
    //self.but.frame = CGRectMake(CGRectGetMaxX(self.lab.frame), CGRectGetMaxY(self.searchBar.frame), 200, 40);
}
@end
