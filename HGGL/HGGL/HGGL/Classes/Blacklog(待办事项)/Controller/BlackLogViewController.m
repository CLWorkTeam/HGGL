//
//  BlackLogViewController.m
//  SYDX_2
//
//  Created by Lei on 15/9/9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BlackLogViewController.h"
#import "BlacklogTableViewController.h"
#import "ZKRImageview.h"
#import "CurrImageView.h"
#import "BlacklogHeader.h"
@interface BlackLogViewController ()
@property (nonatomic,strong) BlacklogTableViewController *table;
@end

@implementation BlackLogViewController
-(BlacklogTableViewController *)table
{
    if (_table == nil) {
        _table = [[BlacklogTableViewController alloc]init];
        __weak typeof(self)weakSelf = self;
        _table.blackLogBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _table;
}
//-(BlacklogHeader *)header
//{
//    if (_header == nil) {
//        _header = [[BlacklogHeader alloc]init];
//    }
//    return _header;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //self.navigationController.navigationBarHidden = YES;
    self.navigationItem.title = @"待办事项";
    [self setTableView];
    [self setHeader];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}
-(void)setHeader
{
    BlacklogHeader *header = [[BlacklogHeader alloc]init];
    header.frame = CGRectMake(0, 64, HGScreenWidth, 30);
    __weak typeof (self) weakSelf = self;
    header.butBlock = ^(BlackParama *parama)
    {
        weakSelf.table.parama = parama;
        [weakSelf.table postWith:parama];
    };
    header.backgroundColor = [UIColor whiteColor];
//    HGLog(@"\\\%f",header.frame.origin.y);
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    
   ZKRImageview *table = [ZKRImageview showInRect:CGRectMake(0, 30+64, HGScreenWidth, self.view.height-49-30-64)];
    //CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, 30+64, HGScreenWidth, self.view.height-49-30-64)];
    HGLog(@"--==%f--%f++%f",self.view.frame.size.height,HGScreenHeight,table.frame.origin.y );
    [self.view addSubview:table];
    //self.table.tableView.y-=20;
    table.contentView = self.table.tableView;
    HGLog(@"%f",table.contentView.frame.origin.y );
    
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
