//
//  PMissionTableViewCell.m
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PMissionTableViewCell.h"
#import "HGLable.h"
#import "PMissionFrame.h"
#import "MissonList.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "PMissionParama.h"
#import "TextFrame.h"
//#define margin 15
//#define UP 5
#define labHeigh 25
#define Width 65
//#define H 30
//#define Hight [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:HGFont] Andwidth:Width].height
//#define TH  [TextFrame frameOfText:@"学习经历" With:[UIFont systemFontOfSize:16] Andwidth:Width].height
@interface PMissionTableViewCell()
@property (nonatomic,weak) UILabel *title;
@property (nonatomic,weak) UILabel *content;
@property (nonatomic,weak) UILabel *contentV;
@property (nonatomic,weak) UIButton *but;
@end
@implementation PMissionTableViewCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UIImageView *ima = [[UIImageView alloc]init];
        ima.frame = CGRectMake(0, minH/2-CellWMargin/2+CellHMargin, CellWMargin, CellWMargin);
        ima.contentMode = UIViewContentModeCenter;
        ima.image = [UIImage imageNamed:@"point"];
        //ima.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:ima];
    }
    return self;
}
-(void)setPM:(PMissionFrame *)PM
{
    _PM = PM;
    UILabel *title = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    title.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    title.text = PM.ML.task_name;
    self.title = title;
    [self.contentView addSubview:title];
    UILabel *content = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    content.text = @"任务内容:";
    //content.backgroundColor = [UIColor redColor];
    self.content = content;
    [self.contentView addSubview:content];
    UILabel *contentV = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:[UIColor blackColor]];
    contentV.text = PM.ML.task_content;
    [self.contentView addSubview:contentV];
    if (![PM.ML.task_status integerValue]) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        [but setTitle:@"完成" forState:UIControlStateNormal];
        [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        //but.backgroundColor = [UIColor redColor];
        but.titleLabel.font = [UIFont systemFontOfSize:14];
        but.tag = [PM.ML.task_id integerValue];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but.bounds = CGRectMake(0, 0, 60, 30);
        but.center = CGPointMake(HGScreenWidth-CellWMargin-60/2, PM.cellH/2);
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:but];
    }
    self.title.frame = CGRectMake(CellWMargin,CellHMargin, HGScreenWidth-60-2*CellWMargin, minH);
    self.content.frame = CGRectMake(CellWMargin, CGRectGetMaxY(self.title.frame)+CellHMargin, Width, minH);
    self.contentV.frame = PM.contentF;
    
    
}
-(void)clickBut:(UIButton *)but
{
    NSString *url = [HGURL stringByAppendingString:@"Project/finishTask.do"];
    PMissionParama *parama = [[PMissionParama alloc]init ];
    parama.user_id = [HGUserDefaults objectForKey:HGUserID];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"task_id":[NSString stringWithFormat:@"%ld",but.tag],@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            HGLog(@"%@",[responseObject objectForKey:@"message"]);
            [SVProgressHUD showSuccessWithStatus:[responseObject objectForKey:@"message"]];
            if (_butClick) {
                _butClick (parama);
            }
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
}
+(instancetype)cellWithTabView:(UITableView *)view
{
    static NSString *ID = @"cell";
    PMissionTableViewCell *cell = [view dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[PMissionTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }else
    {
        for (UIView *view in cell.contentView.subviews) {
            [view removeFromSuperview];
        }
    }
    return cell;
}

@end
