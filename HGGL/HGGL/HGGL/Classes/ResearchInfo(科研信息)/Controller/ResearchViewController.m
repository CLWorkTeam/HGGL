//
//  ResearchViewController.m
//  SYDX_2
//
//  Created by Lei on 15/9/10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchViewController.h"
#import "ResearchListHeader.h"
#import "ResearchInfoTableViewController.h"
#import "ResearchParama.h"
#import "ZKRCover.h"
#import "CurrImageView.h"

@interface ResearchViewController ()
@property (nonatomic,strong) ResearchInfoTableViewController *table;
@end

@implementation ResearchViewController
-(ResearchInfoTableViewController *)table
{
    if (_table == nil) {
        _table = [[ResearchInfoTableViewController alloc]init];
        __weak typeof(self) weakSelf = self;
        _table.researchBlock = ^(id vc)
        {
            [weakSelf.navigationController pushViewController:vc animated:YES];
        };
    }
    return _table;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"科研信息";
    [self setHeader];
    [self setTableView];
}

-(void)setHeader
{
    ResearchListHeader *header = [[ResearchListHeader alloc]init];
    header.frame = CGRectMake(0, 64, HGScreenWidth, 70);
    __weak typeof(self)weakSelf = self;
    header.clickBut = ^(ResearchParama *parama)
    {
        weakSelf.table.parama = parama;
        [weakSelf.table postWithParama:parama];
    };
    header.backgroundColor = HGColor(244, 244, 244,1);
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, 134, HGScreenWidth, HGScreenHeight-70-49)];
    [self.view addSubview:table];
    table.contentView = self.table.tableView;
    
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
