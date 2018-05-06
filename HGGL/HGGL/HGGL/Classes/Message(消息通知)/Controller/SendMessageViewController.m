
//
//  SendMessageViewController.m
//  中大院移动教学办公系统
//
//  Created by imac on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "SendMessageViewController.h"
#import "MessageCollectionViewController.h"
#import "MessageLayout.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#import "Memeber.h"
#import "RoleMember.h"
#import "MessageListController.h"
@interface SendMessageViewController ()<UITextFieldDelegate, UITextViewDelegate>
@property(nonatomic, strong)UIScrollView *myScroll;
@property(nonatomic, strong)UIButton *button;
@property(nonatomic, assign)BOOL isMesClick;
@property(nonatomic, assign)BOOL isSmsClick;
@property(nonatomic, assign)BOOL isEmaClick;
@property(nonatomic, strong)NSString *mesNum;
@property(nonatomic, strong)NSString *smsNum;
@property(nonatomic, strong)NSString *emaNum;
@property(nonatomic, strong)UIButton *mes;
@property(nonatomic, strong)UIButton *sms;
@property(nonatomic, strong)UIButton *ema;
@property(nonatomic, strong)NSString *selectType;
@property(nonatomic, strong)NSArray *arr;
@property(nonatomic, strong)UITextView *contentText;
@property(nonatomic, strong)UITextField *titleField;
@property(nonatomic,weak)UIButton *add;
@property(nonatomic,weak)UILabel *user;
@property(nonatomic,weak)UIButton *all;
@property(nonatomic,weak)UILabel *num;
@property(nonatomic, strong)NSString *memberType;
@property(nonatomic, strong)NSMutableArray *allArr;



@end

@implementation SendMessageViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray array];
    }
    return _arr;
}
-(NSMutableArray *)allArr
{
    if (_allArr == nil) {
        _allArr = [NSMutableArray array];
    }
    return _allArr;
}
-(NSString *)mesNum
{
    if (_mesNum == nil) {
        _mesNum = @"zkr";
    }
    return _mesNum;
}
-(NSString *)smsNum
{
    if (_smsNum == nil) {
        _smsNum = @"zkr";
    }
    return _smsNum;
}-(NSString *)emaNum
{
    if (_emaNum == nil) {
        _emaNum = @"zkr";
    }
    return _emaNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"发送消息";
    [self setSubView];

//    [self setupLeftNavItem];
}
//设置NavItemBtn
-(void)setupLeftNavItem{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
}
//返回前一页
-(void)back
{
        [self.navigationController popViewControllerAnimated:YES];
        MessageListController *mes = (MessageListController *)self.navigationController.topViewController;
        [mes setRefresh];
}

-(void)setSubView
{
    _myScroll = [[UIScrollView alloc] init];
    _myScroll.backgroundColor = [UIColor whiteColor];
    _myScroll.frame = CGRectMake(0, 0, HGScreenWidth, HGScreenHeight);
    _myScroll.showsVerticalScrollIndicator = YES;
    _myScroll.scrollEnabled = YES;
    _myScroll.contentSize = CGSizeMake(0, HGScreenHeight);
    [self.view addSubview:_myScroll];
    
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(touchScrollView)];
    [recognizer setNumberOfTapsRequired:1];
    [recognizer setNumberOfTouchesRequired:1];
    [_myScroll addGestureRecognizer:recognizer];
    
    UILabel *messageWay = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 65, 20)];
    messageWay.font = [UIFont systemFontOfSize:HGFont];
    messageWay.backgroundColor = [UIColor clearColor];
    messageWay.text = @"发送方式:";
    messageWay.textAlignment = NSTextAlignmentRight;
    [_myScroll addSubview:messageWay];
    
    //消息
    anyButton *mes = [anyButton buttonWithType:UIButtonTypeCustom];
    mes.frame = CGRectMake(CGRectGetMaxX(messageWay.frame)+5, 10, 40, 20);
    [mes changeImageFrame:CGRectMake(0, 5, 10, 10)];
    [mes changeTitleFrame:CGRectMake(10,0,30,20)];
    [mes setImage:[UIImage imageNamed:@"iconfont-xuanze"] forState:UIControlStateNormal];
    [mes setImage:[UIImage imageNamed:@"iconfont-xuanzeyixuanze"] forState:UIControlStateSelected];
    [mes setTitle:@"消息" forState:UIControlStateNormal];
    [mes setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [mes addTarget:self action:@selector(mesClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    mes.backgroundColor = [UIColor clearColor];
    mes.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    self.mes = mes;
    [self mesClickBtn:self.mes];
    [_myScroll addSubview:mes];
    
    //短信
    anyButton *sms = [anyButton buttonWithType:UIButtonTypeCustom];
    [sms setImage:[UIImage imageNamed:@"iconfont-xuanze"] forState:UIControlStateNormal];
    [sms setImage:[UIImage imageNamed:@"iconfont-xuanzeyixuanze"] forState:UIControlStateSelected];
    sms.frame = CGRectMake(CGRectGetMaxX(mes.frame)+5, 10, 40, 20);
    [sms changeImageFrame:CGRectMake(0, 5, 10, 10)];
    [sms changeTitleFrame:CGRectMake(10,0,30,20)];
    sms.tag = 2;
    [sms setTitle:@"短信" forState:UIControlStateNormal];
    [sms addTarget:self action:@selector(smsClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    sms.backgroundColor = [UIColor clearColor];
    sms.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    [sms setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.sms = sms;
    [_myScroll addSubview:sms];

    //邮件
    anyButton *ema = [anyButton buttonWithType:UIButtonTypeCustom];
    [ema setImage:[UIImage imageNamed:@"iconfont-xuanze"] forState:UIControlStateNormal];
    [ema setImage:[UIImage imageNamed:@"iconfont-xuanzeyixuanze"] forState:UIControlStateSelected];
    ema.tag = 3;
    ema.frame = CGRectMake(CGRectGetMaxX(sms.frame)+5, 10, 40, 20);
    [ema changeImageFrame:CGRectMake(0, 5, 10, 10)];
    [ema changeTitleFrame:CGRectMake(10,0,30,20)];
    ema.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    [ema setTitle:@"邮件" forState:UIControlStateNormal];
    [ema setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [ema addTarget:self action:@selector(emaClickBtn:) forControlEvents:UIControlEventTouchUpInside];
    ema.backgroundColor = [UIColor clearColor];
    self.ema = ema;
    [_myScroll addSubview:ema];
    
    UILabel *title = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(messageWay.frame)+5, 65, 20)];
    title.font = [UIFont systemFontOfSize:HGFont];
    title.backgroundColor = [UIColor clearColor];
    title.text = @"标       题:";
    title.textAlignment = NSTextAlignmentRight;
    [_myScroll addSubview:title];
    
    UITextField *titleField = [[UITextField alloc] init];
    titleField.frame = CGRectMake(CGRectGetMaxX(title.frame)+5, CGRectGetMaxY(messageWay.frame)+5, HGScreenWidth-95, 20);
    titleField.delegate = self;
    titleField.placeholder = @"请输入消息的标题";
    titleField.font = [UIFont systemFontOfSize:HGFont];
    titleField.borderStyle = UITextBorderStyleLine;
    titleField.layer.borderColor = [[UIColor grayColor] CGColor];
    titleField.backgroundColor = [UIColor clearColor];
    self.titleField = titleField;
    [_myScroll addSubview:titleField];
    
    UILabel *user = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(title.frame)+5, 65, 20)];
    user.font = [UIFont systemFontOfSize:HGFont];
    user.backgroundColor = [UIColor clearColor];
    user.text = @"用       户:";
    self.user = user;
    user.textAlignment = NSTextAlignmentRight;
    [_myScroll addSubview:user];
    
    //添加
    UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
    [add setImage:[UIImage imageNamed:@"iconfont-tianjia-3"] forState:UIControlStateNormal];
    [add addTarget:self action:@selector(addBtn:) forControlEvents:UIControlEventTouchUpInside];
    add.frame = CGRectMake(CGRectGetMaxX(user.frame)+5, CGRectGetMaxY(title.frame)+5, 20, 20);
    add.backgroundColor = [UIColor clearColor];
    self.add = add;
    [_myScroll addSubview:add];
    
    UIButton *all = [UIButton buttonWithType:UIButtonTypeCustom];
//    [add setImage:[UIImage imageNamed:@"iconfont-tianjia-3"] forState:UIControlStateNormal];
    [all setTitle:@"发送全部" forState:UIControlStateNormal];
    all.titleLabel.font = [UIFont systemFontOfSize:HGFont];
    self.all = all;
    [all setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [all setImage:[UIImage imageNamed:@"check_n"] forState:UIControlStateNormal];
    [all setImage:[UIImage imageNamed:@"check"] forState:UIControlStateSelected];
    [all addTarget:self action:@selector(selectedAll) forControlEvents:UIControlEventTouchUpInside];
//    all.frame = CGRectMake(HGScreenWidth-15-80, CGRectGetMaxY(title.frame)+5, 80, 20);
    [all sizeToFit];
    all.x = HGScreenWidth-15-all.width;
    all.y = CGRectGetMaxY(title.frame)+5;
    all.height = 20;
    all.backgroundColor = [UIColor clearColor];
    [_myScroll addSubview:all];
    UILabel *content = [[UILabel alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(user.frame)+5, 65, 20)];
    content.font = [UIFont systemFontOfSize:HGFont];
    content.backgroundColor = [UIColor clearColor];
    content.text = @"内       容:";
    content.textAlignment = NSTextAlignmentRight;
    [_myScroll addSubview:content];
    
    UITextView *contentText = [[UITextView alloc] init];
    contentText.frame = CGRectMake(15, CGRectGetMaxY(content.frame)+5, HGScreenWidth-30, 150);
    contentText.backgroundColor = [UIColor whiteColor];
    contentText.font = [UIFont systemFontOfSize:HGTextFont1];
    contentText.text = @"请输入内容....";
    contentText.textColor = HGColor(192, 192, 192,1);
    contentText.delegate = self;
    contentText.keyboardType = UIKeyboardTypeWebSearch;
    contentText.layer.borderWidth =1;
    contentText.layer.cornerRadius = 0;
    contentText.layer.masksToBounds = YES;
    contentText.layer.borderColor = [[UIColor grayColor] CGColor];
    self.contentText = contentText;
    [_myScroll addSubview:contentText];
    
    //确定取消
    NSArray *myArr = @[@"确定", @"取消"];
    for (int i = 0; i < myArr.count; i++) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setTitle:myArr[i] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(sureOrCancelBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i;
        btn.layer.cornerRadius = 10;
        btn.layer.masksToBounds = YES;
        btn.frame = CGRectMake(40 + i*((HGScreenWidth-90)/2+10), CGRectGetMaxY(contentText.frame)+10, (HGScreenWidth-90)/2, 30);
        btn.backgroundColor = HGColor(202, 7, 50,1);
        [_myScroll addSubview:btn];
    }
    
}
-(void)selectedAll
{
    
}
-(void)mesClickBtn:(UIButton *)btn
{
        if (_isMesClick) {
            btn.selected = NO;
            self.mesNum = @"zkr";
        } else {
            btn.selected = YES;
            self.mesNum = @"0";
//            NSLog(@"self.mesNum = %@",self.mesNum);

    }
            _isMesClick = !_isMesClick;
    
}
-(void)smsClickBtn:(UIButton *)btn
{
    if (_isSmsClick) {
        btn.selected = NO;
        self.smsNum = @"zkr";

    } else {
        btn.selected = YES;
        self.smsNum = @"1";
//        NSLog(@"self.smsNum = %@",self.smsNum);
        
    }
    _isSmsClick = !_isSmsClick;
    
}
-(void)emaClickBtn:(UIButton *)btn
{
    if (_isEmaClick) {
        btn.selected = NO;
        self.emaNum = @"zkr";
    } else {
        btn.selected = YES;
        self.emaNum = @"2";
//        NSLog(@"self.emaNum = %@",self.emaNum);

    }
    _isEmaClick = !_isEmaClick;

    
}
-(void)addBtn:(UIButton *)btn
{
    MessageCollectionViewController *mcc = [[MessageCollectionViewController alloc]init];
    HGLog(@"self.user_id === %@", self.user_id);
    
    mcc.user_id = self.user_id;

//    mcc.arr1 = [NSMutableArray array];
    [mcc.arr1 addObjectsFromArray:self.arr];
    MessageLayout *layout = (MessageLayout *)mcc.collectionViewLayout;
    layout.sectiong1Num = mcc.arr1.count;
    [mcc.collectionView reloadData];
    __weak typeof(self) weakSelf = self;
    mcc.messageBlock = ^(NSArray *arr){
        weakSelf.arr = arr;
//        NSLog(@" ==== %@", arr);
        if (self.num) {
            self.num.text = [NSString stringWithFormat:@"已选择%ld人",arr.count];
        }else
        {
            UILabel *num = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.user.frame)+5, self.user.y, HGScreenWidth-15*2-3*5-20-self.all.width, 20)];
            self.num = num;
            num.font = [UIFont systemFontOfSize:HGFont];
            num.backgroundColor = [UIColor clearColor];
            num.text = [NSString stringWithFormat:@"已选择%ld人",arr.count];
            num.textAlignment = NSTextAlignmentLeft;
            [_myScroll addSubview:num];
            self.add.x = HGScreenWidth-15-self.all.width-5-20;
        }
        
    };
    
    [self.navigationController pushViewController:mcc animated:YES];
    [mcc.collectionView reloadData];
    
}
-(void)sureOrCancelBtn:(UIButton *)btn
{
    if (btn.tag == 0) {
       
        [self type];

        if (([self.mesNum isEqualToString:@"zkr"] && [self.smsNum isEqualToString:@"zkr"] && [self.emaNum isEqualToString:@"zkr"]) || [self.titleField.text isEqualToString:@""] || self.arr.count == 0 || [self.contentText.text isEqualToString:@""] || [self.contentText.text isEqualToString:@"请输入内容...."])
        {
            
            if ([self.mesNum isEqualToString:@"zkr"] && [self.smsNum isEqualToString:@"zkr"] && [self.emaNum isEqualToString:@"zkr"])
            {
                [SVProgressHUD showErrorWithStatus:@"请选择发送方式"];
            }
            else if ([self.titleField.text isEqualToString:@""])
            {
                [SVProgressHUD showErrorWithStatus:@"请输入消息标题"];
            } else if (self.arr.count == 0)
            {
                [SVProgressHUD showErrorWithStatus:@"请选择发送的用户"];
            } else
            {
                [SVProgressHUD showErrorWithStatus:@"请输入消息内容"];
            }
            
        }
        else
        {
            //获取手机当前时间,日期
            NSDate *currentDate = [NSDate date];
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"YYYY/MM/dd hh:mm:ss"];
            NSString *dateString = [dateFormatter stringFromDate:currentDate];
            
            //取出被发送用户的ID
            RoleMember *rm = [[RoleMember alloc] init];
            NSMutableString *memberType = [NSMutableString string];
            for (int i = 0; i < self.arr.count; i++)
            {
                rm = self.arr[i];
                if (i == self.arr.count-1)
                {
                    [memberType appendString:[NSString stringWithFormat:@"%@",rm.m.user_id]];
                }else
                {
                    [memberType appendString:[NSString stringWithFormat:@"%@,",rm.m.user_id]];
                }
            }
            self.memberType = memberType;
            NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
            
            NSMutableDictionary *dic = [NSMutableDictionary dictionary];
            [dic setValue:[NSString stringWithFormat:@"%@", self.user_id] forKey:@"user_id"];
            [dic setValue:self.titleField.text forKey:@"messageTitle"];
            [dic setValue:self.selectType forKey:@"messageType"];
            [dic setValue:self.memberType forKey:@"messageUsers"];
            [dic setValue:self.contentText.text forKey:@"messageContent"];
            [dic setValue:dateString forKey:@"messageTime"];
            [dic setValue:user_id forKey:@"tokenval"];
            [HGHttpTool POSTWithURL:[HGURL stringByAppendingString:@"MsgPush/sendMessages.do"] parameters:dic success:^(id responseObject)
            {
                NSString *status = [responseObject objectForKey:@"status"];
                HGLog(@"status == %@", status);
                if ([status isEqualToString:@"0"])
                {
                    [SVProgressHUD showErrorWithStatus:@"发送失败"];
                }
                else
                {
                    [SVProgressHUD showSuccessWithStatus:@"发送成功"];
                }
            } failure:^(NSError *error)
            {
                [SVProgressHUD showErrorWithStatus:@"请检查网络连接设置"];
            }];
                [self.navigationController popViewControllerAnimated:YES];
                MessageListController *mes = (MessageListController *)self.navigationController.topViewController;
                [mes setRefresh];
        }
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)type
{
    //获取选择方式
    //1
    if ([self.mesNum isEqualToString:@"0"])
    {
        self.selectType = self.mesNum;
    }
    //2
    if ([self.smsNum isEqualToString:@"1"])
    {
        self.selectType = self.smsNum;
    }
    //3
    if ([self.emaNum isEqualToString:@"2"])
    {
        self.selectType = self.emaNum;
    }
    //4
    if ([self.mesNum isEqualToString:@"0"] && [self.smsNum isEqualToString:@"1"])
    {
        self.selectType = [NSString stringWithFormat:@"%@,%@", self.mesNum, self.smsNum];
    }
    //5
    if ([self.mesNum isEqualToString:@"0"] && [self.emaNum isEqualToString:@"2"])
    {
        self.selectType = [NSString stringWithFormat:@"%@,%@", self.mesNum, self.emaNum];
    }
    //6
    if ([self.smsNum isEqualToString:@"1"] && [self.emaNum isEqualToString:@"2"])
    {
        self.selectType = [NSString stringWithFormat:@"%@,%@", self.smsNum, self.emaNum];
    }
    //7
    if ([self.mesNum isEqualToString:@"0"] && [self.smsNum isEqualToString:@"1"] && [self.emaNum isEqualToString:@"2"])
    {
        self.selectType = [NSString stringWithFormat:@"%@,%@,%@", self.mesNum, self.smsNum, self.emaNum];
    }
    
}
-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([self.contentText.text isEqualToString:@"请输入内容...."])
    {
        self.contentText.text = @"";
        self.contentText.textColor = [UIColor blackColor];
    }
}
-(void)touchScrollView
{
    if ([self.contentText.text isEqualToString:@""]) {
        self.contentText.text = @"请输入内容....";
        self.contentText.textColor = HGColor(192, 192, 192,1);

    }
    [self.titleField resignFirstResponder];
    [self.contentText resignFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
