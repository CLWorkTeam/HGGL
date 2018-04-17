//
//  MessageInfoController.m
//  SYDX_2
//
//  Created by mac on 15-8-14.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MessageInfoController.h"
#import "HGLable.h"
#import "TextFrame.h"
#import "MessageListController.h"
#define margin 15
@interface MessageInfoController ()

@end

@implementation MessageInfoController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    UIColor *color = [UIColor whiteColor];
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    self.navigationController. navigationBar.titleTextAttributes = dict;
    self.navigationItem.title = @"消息详情";
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:14 Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.text = self.msg_name;
    CGFloat titleH = [TextFrame frameOfText:self.msg_name With:[UIFont systemFontOfSize:14] Andwidth:HGScreenWidth-2*15].height;
    title.frame = CGRectMake(margin, 84, HGScreenWidth-2*15, titleH);
    [self.view addSubview:title];
    UILabel *content = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    //content.backgroundColor = [UIColor lightGrayColor];
    content.text = self.msg_content;
    CGFloat contentH = [TextFrame frameOfText:self.msg_content With:[UIFont systemFontOfSize:14] Andwidth:HGScreenWidth-2*15].height;
    CGFloat maxH = HGScreenHeight - 4*margin - titleH;
    content.frame = CGRectMake(margin, CGRectGetMaxY(title.frame)+margin, HGScreenWidth-2*15, contentH>=maxH?maxH:contentH);
    [self.view addSubview:content];
    UILabel *publisher = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:14 Color:[UIColor blackColor]];
    NSString *str = [NSString stringWithFormat:@"发布者:%@",self.msg_publisher];
    publisher.text = str;
    publisher.frame = CGRectMake(HGScreenWidth - 150-margin, CGRectGetMaxY(content.frame), 150, 40);
    [self.view addSubview:publisher];
    
    //    UINavigationBar *bar = [[UINavigationBar alloc]initWithFrame:CGRectMake(0,0, HGScreenWidth, 64)];
    //bar.barStyle = 0;
    UIBarButtonItem *back = [[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStyleDone target:self action:@selector(clickBack)];
    ////    [bar pushNavigationItem:self.navigationItem animated:YES];
    //self.navigationController.navigationBar.barTintColor =HGColor(205,0,36);
    ////    [self.view addSubview:bar];
    self.navigationItem.leftBarButtonItem = back;
}
-(void)clickBack
{
    if (self.navigationController.topViewController) {
        [self.navigationController popViewControllerAnimated:YES];
//        MessageListController *mes = (MessageListController *)self.navigationController.topViewController;
//        [mes setRefresh];
    }
    //[self dismissViewControllerAnimated:YES completion:nil];
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
