//
//  FinalApprove.m
//  SYDX_2
//
//  Created by mac on 15-8-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "FinalApprove.h"
#import "HGLable.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#import "SuggestReturn.h"
#define margin 20
#define W (HGScreenWidth-3*margin)/2
#define H 40
@interface FinalApprove ()<UITextViewDelegate>
@property (nonatomic,weak) UILabel *tit;
@property (nonatomic,weak) UILabel *unviesity;
@property (nonatomic,weak) UITextView *unviesityV;
@property (nonatomic,strong) UIView *accessoryView;
@property (nonatomic,weak) UILabel *ZJ;
@property (nonatomic,weak) UITextView *ZJV;
@property (nonatomic,weak) UILabel *KYS;
@property (nonatomic,weak) UITextView *KYSV;
@property (nonatomic,weak) UIButton *cancle;
@property (nonatomic,weak) UIButton *sure;
@property (nonatomic,weak) UIButton *CS;
@property (nonatomic,weak) UIButton *NCS;
@end
@implementation FinalApprove
-(UIView *)accessoryView
{
    
    if (_accessoryView == nil) {
        UIView *accessoryView = [[UIView alloc]init];
        accessoryView.frame = CGRectMake(0, 0, HGScreenWidth, 30);
        accessoryView.backgroundColor = [UIColor lightGrayColor];
//        UIButton *cancle = [UIButton buttonWithType:UIButtonTypeCustom];
//        cancle.backgroundColor = [UIColor redColor];
//        cancle.titleLabel.font = [UIFont systemFontOfSize:14];
//        [cancle setTitle:@"取消" forState:UIControlStateNormal];
//        [cancle addTarget:self action:@selector(cancleA) forControlEvents:UIControlEventTouchUpInside];
//        cancle.bounds = CGRectMake(0, 0, 60, 30);
//        cancle.center = CGPointMake(40, accessoryView.frame.size.height/2);
//        [accessoryView addSubview:cancle];
        UIButton *sure = [UIButton buttonWithType:UIButtonTypeCustom];
        sure.backgroundColor = [UIColor redColor];
        //[sure setBackgroundColor:[UIColor blackColor]];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //[sure.layer setMasksToBounds:YES];
        //sure.backgroundColor = [UIColor clearColor];
        //[sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        sure.titleLabel.font = [UIFont systemFontOfSize:14];
        [sure setTitle:@"确定" forState:UIControlStateNormal];
        [sure addTarget:self action:@selector(sureA) forControlEvents:UIControlEventTouchUpInside];
        sure.bounds = CGRectMake(0, 0, 60, 30);
        sure.center = CGPointMake(HGScreenWidth - 40, accessoryView.frame.size.height/2);
        [accessoryView addSubview:sure];
        
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        _accessoryView = accessoryView;
    }
    return _accessoryView;
}
-(void)sureA
{
    [self endEditing:YES];
}

-(void)setEditEnable:(BOOL)editEnable
{
    if (editEnable == NO) {
        self.unviesityV.editable = NO;
        self.KYSV.editable = NO;
        self.ZJV.editable = NO;
        //self.accessoryView = nil;
        [self.sure addTarget:self action:@selector(click1Sure:) forControlEvents:UIControlEventTouchUpInside];
//
//        if ([self.SR.researchIsVisible isEqualToString: @"1"]) {
//            self.CS.selected = YES;
//            self.NCS.selected = NO;
//            self.unviesityV.text = self.SR.researchCommitteeComment;
//            HGLog(@"%@--%@--%@",self.SR.researchCommitteeComment,self.SR.researchDepartmentComment,self.SR.researchExpertComment);
//            self.ZJV.text = self.SR.researchExpertComment;
//            
//            self.KYSV.text = self.SR.researchDepartmentComment;
//            
//        }else
//        {
//            self.CS.selected = NO;
//            self.NCS.selected = YES;
//        }
        
    }else
    {
        self.unviesityV.editable = YES;
        self.KYSV.editable = YES;
        self.ZJV.editable = YES;
        [self.sure addTarget:self action:@selector(click2Sure:) forControlEvents:UIControlEventTouchUpInside];
    }
}
-(void)setSR:(SuggestReturn *)SR
{
    _SR = SR;
    if ([self.SR.researchIsVisible isEqualToString: @"1"]) {
        self.CS.selected = YES;
        self.NCS.selected = NO;
        
        self.unviesityV.text = self.SR.researchCommitteeComment;
        HGLog(@"%@--%@--%@",self.SR.researchCommitteeComment,self.SR.researchDepartmentComment,self.SR.researchExpertComment);
        self.ZJV.text = self.SR.researchExpertComment;
        
        self.KYSV.text = self.SR.researchDepartmentComment;
    }else
    {
        self.CS.selected = NO;
        self.NCS.selected = YES;
    }
}
-(instancetype)initWithFrame:(CGRect)frame

{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        UILabel *tit = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
        tit.font =  [UIFont fontWithName:@"Helvetica-Bold" size:14];
        tit.text = @"终期评审";
        self.tit = tit;
        [self addSubview:tit];
        UILabel *unviesity  = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
        unviesity.text = @"校党委评审意见";
        self.unviesity = unviesity;
        [self addSubview:unviesity];
        UITextView *unviesityV = [[UITextView alloc]init];
        unviesityV.tag = 1;
        unviesityV.textColor = [UIColor blackColor];
        unviesityV.font = [UIFont systemFontOfSize:14];
        unviesityV.backgroundColor = [UIColor lightGrayColor];
        unviesityV.delegate = self;
        unviesityV.returnKeyType = UIReturnKeyDone;
        unviesityV.keyboardType = UIKeyboardTypeDefault;
        unviesityV.scrollEnabled = YES;
        unviesityV.inputAccessoryView = self.accessoryView;
        self.unviesityV = unviesityV;
        [self addSubview:unviesityV];
        UILabel *ZJ  = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
        ZJ.text = @"专家评审意见";
        self.ZJ = ZJ;
        [self addSubview:ZJ];
        UITextView *ZJV = [[UITextView alloc]init];
        ZJV.tag = 2;
        ZJV.textColor = [UIColor blackColor];
        ZJV.backgroundColor = [UIColor lightGrayColor];
        ZJV.font = [UIFont systemFontOfSize:14];
        ZJV.delegate = self;
        ZJV.returnKeyType = UIReturnKeyDone;
        ZJV.keyboardType = UIKeyboardTypeDefault;
        ZJV.scrollEnabled = YES;
        ZJV.inputAccessoryView = self.accessoryView;
        self.ZJV = ZJV;
        [self addSubview:ZJV];
        UILabel *KYS  = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
        KYS.text = @"科研室评审意见";
        self.KYS = KYS;
        [self addSubview:KYS];
        UITextView *KYSV = [[UITextView alloc]init];
        KYSV.tag = 3;
        KYSV.textColor = [UIColor blackColor];
        KYSV.font = [UIFont systemFontOfSize:14];
        KYSV.backgroundColor = [UIColor lightGrayColor];
        KYSV.delegate = self;
        KYSV.returnKeyType = UIReturnKeyDone;
        KYSV.keyboardType = UIKeyboardTypeDefault;
        KYSV.scrollEnabled = YES;
        KYSV.inputAccessoryView = self.accessoryView;
        self.KYSV = KYSV;
        [self addSubview:KYSV];
        UIButton *CS = [UIButton buttonWithType:UIButtonTypeCustom];
        //CS.backgroundColor = [UIColor redColor];
        [CS setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        CS.titleLabel.font = [UIFont systemFontOfSize:14    ];
        [CS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [CS setTitle:@"可见" forState:UIControlStateNormal ];
        [CS addTarget:self action:@selector(clickCS) forControlEvents:UIControlEventTouchUpInside];
        self.CS = CS;
        
        [self addSubview:CS];
        UIButton *NCS = [UIButton buttonWithType:UIButtonTypeCustom];
        //NCS.backgroundColor = [UIColor redColor];
        [NCS setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        NCS.titleLabel.font = [UIFont systemFontOfSize:14    ];
        [NCS setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [NCS setTitle:@"不可见" forState:UIControlStateNormal ];
        [NCS addTarget:self action:@selector(clickNCS) forControlEvents:UIControlEventTouchUpInside];
        self.NCS = NCS;
        [self clickNCS];
        [self addSubview:NCS];
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
        [self.CS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.NCS setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self.cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancle.layer setMasksToBounds:YES];
        [cancle.layer setCornerRadius:4];
        [cancle setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [sure.layer setMasksToBounds:YES];
        [sure.layer setCornerRadius:4];
        [sure setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        self.sure = sure;
        [self.sure setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self addSubview:sure];
        
    }
    return self;
}
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    if (textView.tag == 3) {
        self.y -= 50;
    }
    return YES;
}
-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if (textView.tag == 3) {
        self.y += 50;
    }
    return YES;
}
-(void)clickCS
{
    self.CS.selected = !self.CS.selected;
    if (self.CS.selected) {
        self.NCS.selected = NO;
    }
}
-(void)clickNCS
{
    self.NCS.selected  = !self.NCS.selected;
    if (self.NCS.selected) {
        self.CS.selected = NO;
    }
}
-(void)clickCancle:(UIButton *)but
{
    [self endEditing:YES];
    [ZKRCover dismiss];
    [CurrImageView dismiss];
    
}
-(void)click1Sure:(UIButton *)but
{
    HGLog(@"%d",self.editEnable);
//    if (self.editEnable) {
//        NSString *url = [HGURL stringByAppendingString:@"Research/doFinalApprove.do"];
//        
//        
//        [HGHttpTool POSTWithURL:url parameters:@{@"research_id":self.research_id,@"researchCommitteeComment":self.unviesityV.text,@"researchExpertComment":self.ZJV.text,@"researchDepartmentComment":self.KYSV.text,@"researchIsVisible":[NSString stringWithFormat:@"%d",self.CS.selected]} success:^(id responseObject) {
//            NSString *status = [responseObject objectForKey:@"status"];
//            if ([status isEqualToString:@"1"]) {
//                [MBProgressHUD SVProgressHUD showSuccessWithStatusWithStatus:[responseObject objectForKey:@"message"]];
//                
//            }else
//            {
//                [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
//            }
//        } failure:^(NSError *error) {
//            HGLog(@"%@",error);
//        }];
//        [self endEditing:YES];
//        [ZKRCover dismiss];
////        [CurrImageView dismiss];
//    }else
//    {
        [ZKRCover dismiss];
        [CurrImageView dismiss];
//    }

    
}
-(void)click2Sure:(UIButton *)but
{
    NSString *url = [HGURL stringByAppendingString:@"Research/doFinalApprove.do"];
    
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"research_id":self.research_id,@"researchCommitteeComment":self.unviesityV.text,@"researchExpertComment":self.ZJV.text,@"researchDepartmentComment":self.KYSV.text,@"researchIsVisible":[NSString stringWithFormat:@"%d",self.CS.selected],@"tokenval":user_id} success:^(id responseObject) {
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
-(void)layoutSubviews
{
    [super layoutSubviews];
    self.tit.frame = CGRectMake(0, 0, self.frame.size.width, 30);
    self.unviesity.frame = CGRectMake(margin, CGRectGetMaxY(self.tit.frame), W, 30);
    self.unviesityV.frame = CGRectMake(margin, CGRectGetMaxY(self.unviesity.frame), W, H);
    self.ZJ.frame = CGRectMake(CGRectGetMaxX(self.unviesity.frame)+margin, CGRectGetMaxY(self.tit.frame), W, 30);
    self.ZJV.frame = CGRectMake(CGRectGetMaxX(self.unviesity.frame)+margin, CGRectGetMaxY(self.ZJ.frame), W, H);
    self.KYS.frame = CGRectMake(margin, CGRectGetMaxY(self.ZJV.frame), HGScreenWidth-2*margin, 30);
    self.KYSV.frame = CGRectMake(margin, CGRectGetMaxY(self.KYS.frame), HGScreenWidth-2*margin, H);
    self.CS.frame = CGRectMake(margin, CGRectGetMaxY(self.KYSV.frame)+margin, 50, 25);
    self.NCS.frame = CGRectMake(margin*2+40,CGRectGetMaxY(self.KYSV.frame)+margin , 50, 25);
    self.cancle.frame = CGRectMake(self.frame.size.width-40*2-20*2, CGRectGetMaxY(self.KYSV.frame)+margin, 40, 25);
    self.sure.frame = CGRectMake(self.frame.size.width-40-20,  CGRectGetMaxY(self.KYSV.frame)+margin, 40, 25);
}
@end
