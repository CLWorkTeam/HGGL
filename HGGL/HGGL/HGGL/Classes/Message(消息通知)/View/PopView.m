//
//  PopView.m
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/26.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "PopView.h"
#import "CurrImageView.h"
#import "ZKRCover.h"
#import "Role.h"
#import "MessagePopCollectionViewController.h"
@interface PopView ()
@property (nonatomic,weak) UILabel *lab;
@property (nonatomic,strong) NSMutableArray *butArr;
@property (nonatomic,weak) UIButton *but;
@property (nonatomic,weak) UIImageView *line;
@property (nonatomic,weak) UIImageView *line2;
@property (nonatomic,weak) UIImageView *line3;
@property (nonatomic,weak) UIView *coll;
@property (nonatomic,strong) NSArray *contaiArr;
@property (nonatomic,weak) ZKRCover *cover;
@property (nonatomic,strong) Role *role;
//@property (nonatomic,strong) NSArray *contaiArr;
@end
@implementation PopView
-(NSMutableArray *)butArr
{
    if (_butArr == nil) {
        _butArr = [NSMutableArray array];
    }
    return _butArr;
}
-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        UILabel *lab = [[UILabel alloc]init];
//        //    lab.tag = indexPath.section;
////        lab.text = [NSString stringWithFormat:@"%@:",title];
//        lab.font = [UIFont systemFontOfSize:HGFont];
//        
//        self.lab = lab;
//        self.backgroundColor = [UIColor whiteColor];
//        lab.textColor = [UIColor blackColor];
//        lab.textAlignment = NSTextAlignmentLeft;
//        [self addSubview:lab];
//        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
//        btn.titleLabel.font = [UIFont systemFontOfSize:HGFont];
//        [btn setTitle:@"选择全部" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        self.but = btn;
//        [self addSubview:btn];
//        NSArray *arr = @[@"取消",@"确定"];
//        for (int i = 0; i<arr.count; i++) {
//            anyButton *but = [anyButton buttonWithType:UIButtonTypeCustom];
//            [but setTitle:arr[i] forState:UIControlStateNormal];
//            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//            but.titleLabel.textAlignment = NSTextAlignmentCenter;
//            but.titleLabel.font = [UIFont systemFontOfSize:15];
//            but.tag = i;
//            [self.butArr addObject:but];
//            [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:but];
//            
//        }
//        HGLog(@"%@",self.butArr);
//        UIImageView *line1 = [[UIImageView alloc]init];
//        self.line = line1;
//        line1.backgroundColor = [UIColor blackColor];
//        [self addSubview:line1];
//        UIImageView *line2 = [[UIImageView alloc]init];
//        self.line2 = line2;
//        line2.backgroundColor = [UIColor blackColor];
//        [self addSubview:line2];
//        UIImageView *line3 = [[UIImageView alloc]init];
//        self.line3 = line3;
//        line3.backgroundColor = [UIColor blackColor];
//        [self addSubview:line3];
//        MessagePopCollectionViewController *popView = [[MessagePopCollectionViewController alloc]init];
//        
//        
//        self.popview = popView;
//        UIView *coll = popView.collectionView;
//        self.coll = coll;
//        [self addSubview:coll];
    }
    return self;
}
-(void)setRole:(Role *)role
{
    _role = role;
    
    
    UILabel *lab = [[UILabel alloc]init];
    //    lab.tag = indexPath.section;
    //        lab.text = [NSString stringWithFormat:@"%@:",title];
    lab.font = [UIFont systemFontOfSize:HGFont];
    self.lab = lab;
    self.backgroundColor = [UIColor whiteColor];
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    self.lab.text = [NSString stringWithFormat:@"%@:",role.roleName];
    [self addSubview:lab];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    [btn setTitle:@"选择全部" forState:UIControlStateNormal];
//    btn.imageView.contentMode = UIViewContentModeCenter;
    [btn addTarget:self action:@selector(selectedAll:) forControlEvents:UIControlEventTouchUpInside];
    [btn setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.but = btn;
    [self addSubview:btn];
    
    
    NSArray *arr = @[@"取消",@"确定"];
    for (int i = 0; i<arr.count; i++) {
        anyButton *but = [anyButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:arr[i] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [but setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.titleLabel.font = [UIFont systemFontOfSize:15];
        but.tag = i;
        [self.butArr addObject:but];
        [but addTarget:self action:@selector(butClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:but];
        
    }
    HGLog(@"%@",self.butArr);
    UIImageView *line1 = [[UIImageView alloc]init];
    self.line = line1;
    line1.backgroundColor = [UIColor blackColor];
    [self addSubview:line1];
    UIImageView *line2 = [[UIImageView alloc]init];
    self.line2 = line2;
    line2.backgroundColor = [UIColor blackColor];
    [self addSubview:line2];
    UIImageView *line3 = [[UIImageView alloc]init];
    self.line3 = line3;
    line3.backgroundColor = [UIColor blackColor];
    [self addSubview:line3];
    
    MessagePopCollectionViewController *popView = [[MessagePopCollectionViewController alloc]init];
    __weak typeof(self) weakSelf = self;
    popView.clickAll = ^{
        [weakSelf selectedAll:btn];
    };
    popView.collIsall = ^(BOOL isAll)
    {
        btn.selected = isAll;
//        [weakSelf selectedAll:btn];

    };
    self.popview = popView;
    self.popview.contaiArr = self.contaiArr;
    self.popview.role = role;
    
    
    UIView *coll = popView.collectionView;
    self.coll = coll;
    [self addSubview:coll];
    
    
}

-(void)selectedAll:(UIButton *)but
{
    but.selected = !but.selected;
    [self.popview selectedAll:but.selected];
    
}
+(instancetype)setPopViewWith:(CGRect)rect withRole:(Role *)role andArr:(NSArray *)arr
{
    ZKRCover *cover = [ZKRCover show];
    cover.dimBackGround = YES;
    CurrImageView *topView = [CurrImageView showInRect:rect];
    PopView *pop = [[PopView alloc]init];
    pop.contaiArr = arr;
    pop.role = role;
    
    topView.contentView = pop;
    [HGKeywindow addSubview:topView];
    cover.ZKRCoverDismiss=^{
        [CurrImageView dismiss];

        pop.popview = nil;
    };
   
    return pop;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.lab.frame = CGRectMake(10, 0, HGScreenWidth*0.8-2*10, 30);
    
    self.but.frame = CGRectMake(5, HGScreenHeight*0.8-60, 100, 30);
    for (int i = 0 ; i<self.butArr.count; i++) {
        UIButton *but = self.butArr[i];
        but.frame = CGRectMake((HGScreenWidth*0.8-1)/2*i, HGScreenHeight*0.8-30, (HGScreenWidth*0.8-1)/2, 30);
        
    }
    
    self.line2.frame = CGRectMake(0, 29, HGScreenWidth*0.8, 1);
    
    self.line3.frame = CGRectMake(0, HGScreenHeight*0.8-29, HGScreenWidth*0.8, 1);
    
    self.line.frame = CGRectMake(HGScreenWidth*0.8/2, HGScreenHeight*0.8-30+5, 0.5, 20);
    
    self.coll.frame = CGRectMake(0, 30, HGScreenWidth*0.8, HGScreenHeight*0.8-30-60);
    
}
-(void)butClick:(UIButton *)but
{
    [ZKRCover dismiss];
    [CurrImageView dismiss];
    
    if (but.tag) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSIndexPath * key in self.popview.cellArr) {
            [array addObject:self.popview.cellDict[key]];
        }
        if (_popBlock) {
            _popBlock (array,self.role.roleId);
        }
    }
    self.popview = nil;
}
@end
