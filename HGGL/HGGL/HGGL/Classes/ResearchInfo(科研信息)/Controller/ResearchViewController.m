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
@property (nonatomic,weak) ResearchListHeader *header;
@property (nonatomic,strong) ResearchParama *parama;
@end

@implementation ResearchViewController
-(ResearchInfoTableViewController *)table
{
    if (_table == nil) {
        
        _table = [[ResearchInfoTableViewController alloc]init];
        
        _table.parama = self.parama;
        
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
    self.parama = [[ResearchParama alloc]init];
    self.parama.research_type = @"";
    self.parama.user_id = [HGUserDefaults objectForKey:HGUserID];
    self.parama.str = @"";
//    self.parama.user_id = @"";
    self.parama.page = @"1";
    self.parama.pageSize = @"10";
    [self setHeader];
    [self setTableView];
}

-(void)setHeader
{
    ResearchListHeader *header = [[ResearchListHeader alloc]init];
    
    header.parama = self.parama;
    
    self.header = header;
    
    header.frame = CGRectMake(0, HGHeaderH, HGScreenWidth, 75);
    
    __weak typeof(self)weakSelf = self;
    
    header.clickBut = ^(ResearchParama *parama)
    {
        weakSelf.table.parama = parama;
        
        [weakSelf.table refresh];
        
    };
    
    header.backgroundColor = HGColor(244, 244, 244,1);
    
    [self.view addSubview:header];
    
}
-(void)setTableView
{
    CurrImageView *table = [CurrImageView showInRect:CGRectMake(0, HGHeaderH+self.header.height, HGScreenWidth, HGScreenHeight-HGHeaderH-self.header.height)];
    
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
