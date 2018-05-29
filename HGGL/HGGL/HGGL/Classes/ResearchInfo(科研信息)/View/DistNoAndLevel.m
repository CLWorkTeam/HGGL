//
//  DistNoAndLevel.m
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "DistNoAndLevel.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#import "PopTableViewController.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#define margin 20
#define W 60
#define H 30
#define LW 150
@interface DistNoAndLevel()<UITextFieldDelegate>
@property (nonatomic,weak) UILabel *tit;
@property (nonatomic,weak) UILabel *N;
@property (nonatomic,weak) UITextField *NV;
@property (nonatomic,weak) UILabel *level;
@property (nonatomic,weak) UIButton *levelV;
@property (nonatomic,strong) PopTableViewController *pop;
@property (nonatomic,weak) UIButton *cancle;
@property (nonatomic,weak) UIButton *sure;
@property (nonatomic,weak) CurrImageView *curr;
@end
@implementation DistNoAndLevel

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *tit = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        tit.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14];
        tit.text = @"分配等级编号";
        self.tit = tit;
        [self addSubview:tit];
        UILabel *N = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        self.N = N;
        N.text = @"编号";
        [self addSubview:N];
        UITextField *NV = [[UITextField alloc]init];
        NV.returnKeyType =UIReturnKeyDone;
        NV.delegate = self;
        NV.borderStyle = UITextBorderStyleRoundedRect;
        [NV setValue:[UIFont boldSystemFontOfSize:14] forKeyPath:@"_placeholderLabel.font"];
        self.NV = NV;
        [self addSubview:NV];
        UILabel *level = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        level.text = @"等级";
        self.level = level;
        [self addSubview:level];
        UIButton *levelV = [UIButton buttonWithType:UIButtonTypeCustom];
        [levelV setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [levelV addTarget:self action:@selector(clickBut) forControlEvents:UIControlEventTouchUpInside];
        //[UIImage  imageNamed:@"search_box"]
        [levelV setBackgroundImage:[UIImage resizableImageWithName:@"search_box"] forState:UIControlStateNormal];
        [levelV setTitle:@"一般" forState:UIControlStateNormal];
        self.levelV = levelV;
        [self addSubview:levelV];
        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
        //cancle.backgroundColor = [UIColor redColor];
        //[cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        cancle.titleLabel.font = [UIFont systemFontOfSize:14    ];
        //[cancle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [cancle setTitle:@"取消" forState:UIControlStateNormal ];
        [cancle addTarget:self action:@selector(clickCancle:) forControlEvents:UIControlEventTouchUpInside];
        self.cancle = cancle;
        [self addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        //sure.backgroundColor = [UIColor redColor];
        //[sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont systemFontOfSize:14    ];
        //[sure setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [sure setTitle:@"确定" forState:UIControlStateNormal ];
        [sure addTarget:self action:@selector(clickSure:) forControlEvents:UIControlEventTouchUpInside];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        self.sure = sure;
        [self addSubview:sure];
        
    }
    return self;
}
-(void)clickCancle:(UIButton *)but
{
    [self endEditing:YES];
    [ZKRCover dismiss];
    [CurrImageView dismiss];
    
}
-(void)clickSure:(UIButton *)but
{
    
    NSString *url = [HGResearchUrl stringByAppendingString:@"Research/doDistNoAndLevel.do"];
    NSString *str;
    if ([self.levelV.titleLabel.text isEqualToString:@"一般"]) {
        str = @"1";
    }else
    {
        str = @"2";
    }
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"research_id":self.research_id,@"researchNum":self.NV.text,@"level":str,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD  showSuccessWithStatus:[responseObject objectForKey:@"message"]];
            if (_sureBlock) {
                _sureBlock();
            }
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    [self endEditing:YES];
    [ZKRCover dismiss];
    [CurrImageView dismiss];
    
}
-(void)clickBut
{
    self.levelV.selected = !self.levelV.selected;
    if (self.levelV.selected) {
        CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-280/2+margin+W, 84+90, LW, 44*2)];
        
        PopTableViewController *pop = [[PopTableViewController alloc] init];
        pop.arr = @[@"一般",@"重要"];
        curr.contentView = pop.tableView;
        [HGKeywindow addSubview:curr];
        self.curr = curr;
        self.pop = pop;
        pop.selectedCell=^(NSString *str)
        {
            //HGLog(@"点击");
            self.levelV.selected = NO;
            [self.levelV setTitle:str forState:UIControlStateNormal];
            //[CurrImageView dismiss];
            [curr removeFromSuperview];
            
        };
    }else
    {
        self.levelV.selected = NO;
        [self.curr removeFromSuperview];
    }

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    //取消成为第一响应者（取消的话 键盘就会消失）
    [textField resignFirstResponder];
    
    
    return YES;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tit.frame = CGRectMake(0, 0, self.frame.size.width, H);
    self.N.frame = CGRectMake(margin, CGRectGetMaxY(self.tit.frame), W, H);
    self.NV.frame = CGRectMake(CGRectGetMaxX(self.N.frame), CGRectGetMaxY(self.tit.frame), LW, H);
    self.level.frame = CGRectMake(margin, CGRectGetMaxY(self.N.frame), W, H);
    self.levelV.frame = CGRectMake(CGRectGetMaxX(self.level.frame), CGRectGetMaxY(self.N.frame), LW, H);
    self.cancle.frame = CGRectMake(self.frame.size.width-40*2-20*2, CGRectGetMaxY(self.levelV.frame)+margin, 40, 25);
    self.sure.frame = CGRectMake(self.frame.size.width-40-20, CGRectGetMaxY(self.levelV.frame)+margin, 40, 25);
}
@end
