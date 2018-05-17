//
//  HGDownloadedViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/11.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGDownloadedViewController.h"
#import "TKDownLoadManager.h"
#import "HGDownloadTableViewCell.h"
#import "HGNoDataTableViewCell.h"
#import "TKDownLoadModel.h"
#import "MPPlayerViewController.h"
#import "FullNavViewController.h"
#import "AppDelegate.h"
#import "HGWebViewController.h"
@interface HGDownloadedViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) NSMutableDictionary *selectedDictionary;
@property (nonatomic,weak) UITableView *tableView;
@property (nonatomic,weak) UIView *bootView;
@property (nonatomic,weak) UIButton *RButton;
@property (nonatomic,strong) NSMutableArray *dataArray;
@end

@implementation HGDownloadedViewController
-(NSMutableDictionary *)selectedDictionary
{
    if (_selectedDictionary == nil) {
        _selectedDictionary = [NSMutableDictionary dictionary];
    }
    return _selectedDictionary;
}
-(NSMutableArray *)dataArray
{
    if (_dataArray == nil) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(completedRefresh) name:@"downLoadComplete" object:nil];
    [self getDataArray];
    [self setTableView];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    HGLog(@"已下载将要出现");
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    HGLog(@"已下载已经出现");
    [self setRightButton];
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    HGLog(@"已下载将要消失");
//    self.navigationItem.rightBarButtonItem = nil;
    [self hiddenRightButton];
    
}
-(void)getDataArray
{
    
    [self.dataArray removeAllObjects];
    
    NSMutableArray *videoArray = [NSMutableArray array];
    NSMutableArray *meansArray = [NSMutableArray array];
    NSMutableArray *bookArray = [NSMutableArray array];
    for (TKDownLoadModel *model in [TKDownLoadManager share].downloadedArray) {
        if ([model.liveId isEqualToString:@"0"] ) {
            
            [videoArray addObject:model];
            
        }else if ([model.liveId isEqualToString:@"1"])
        {
            [meansArray addObject:model];
        }else
        {
            [bookArray addObject:model];
        }
    }
    
    [self.dataArray addObject:videoArray];
    [self.dataArray addObject:meansArray];
    [self.dataArray addObject:bookArray];
    
}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    HGLog(@"已下载已经消失");
    
}
-(void)setRightButton
{
    
    if ([self.navigationController.topViewController respondsToSelector:@selector(setRightButton:)]) {
        [self.navigationController.topViewController performSelector:@selector(setRightButton:) withObject:self];
        
    }

}
-(void)hiddenRightButton
{
    if ([self.navigationController.topViewController respondsToSelector:@selector(hiddenRightButton:)]) {
        
        [self.navigationController.topViewController performSelector:@selector(hiddenRightButton:) withObject:self];
    }
}
-(void)clickRightButtonItem
{
    if (self.isEdit) {
        
        [self setBottomView];
        
        [self.tableView reloadData];
        
    }else
    {
        
        [self.selectedDictionary removeAllObjects];
        
        [self hiddenBottomView];
        
        [self.tableView reloadData];
        
    }
}
-(void)refreshWithStatus:(BOOL)isEdit
{
 
    self.isEdit = isEdit;
    
    [self getDataArray];
    
    [self.tableView reloadData];
}
-(void)completedRefresh
{
    
    [self refreshWithStatus:self.isEdit];
    
}
-(void)setTableView
{
    if (self.tableView) {
        
        return;
        
    }
    
    UITableView *table = [[UITableView alloc]init];
    
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView = table;
    
    self.tableView.backgroundColor = HGGrayColor;
    
    table.dataSource = self;
    
    table.delegate = self;
    
    [self.view addSubview:table];
    
}
-(void)setBottomView
{
    UIView *footer = [[UIView alloc]init];
    footer.backgroundColor = [UIColor whiteColor];
    CGFloat footH = 43+HGSafeBottom;
    footer.frame = CGRectMake(0, self.view.height-footH, self.view.width, footH);
    [self.view addSubview:footer];
    self.bootView = footer;
    
    UIButton *LButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [LButton setTitle:@"全选" forState:UIControlStateNormal];
    [LButton setTitleColor:HGMainColor forState:UIControlStateNormal];
    LButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    LButton.titleLabel.font = ZKRButFont;
    LButton.tag = 700;
    [LButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:LButton];
    
    LButton.bounds = CGRectMake(0, 0, 100, 30);
    LButton.center = CGPointMake(footer.width/4, 6.5+15);
    
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HGColor(193, 193, 193, 1);
    [footer addSubview:line];
    line.frame = CGRectMake(footer.width/2-0.5, 0, 1, 43);
    
    UIButton *RButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [RButton setTitle:@"删除" forState:UIControlStateNormal];
    [RButton setTitleColor:HGColor(193, 193, 193, 1) forState:UIControlStateNormal];
    RButton.titleLabel.textAlignment = NSTextAlignmentCenter;
    RButton.titleLabel.font = ZKRButFont;
    RButton.tag = 701;
    [RButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [footer addSubview:RButton];
    RButton.selected = NO;
    self.RButton = RButton;
    RButton.bounds = CGRectMake(0, 0, 100, 30);
    RButton.center = CGPointMake(footer.width*3/4, 6.5+15);
}
-(void)hiddenBottomView
{
    [self.bootView removeFromSuperview];
    self.bootView = nil;
    self.RButton = nil;
}
-(void)clickBut:(UIButton *)button
{
    if (button.tag == 700) {
        
        NSArray *arr = self.dataArray;
        
        for (int i = 0; i<arr.count; i++) {
            
            NSArray *array = arr[i];
            
            for (int j = 0 ; j<array.count; j++) {
                
                NSIndexPath *path = [NSIndexPath indexPathForRow:j inSection:i];
                
                if (self.selectedDictionary[path] == nil) {
                    
                    [self.selectedDictionary setObject:@"1" forKey:path];
                    
                }
            }
          
        }
        [self.tableView reloadData];
        
    }else
    {
        
        if (!self.selectedDictionary.count) {
            return;
        }
        TKDownLoadManager *manager = [TKDownLoadManager share];
        
        NSMutableArray *deleteArray = [NSMutableArray array];
        
        for (NSIndexPath *path in self.selectedDictionary) {
            
            [deleteArray addObject:self.dataArray[path.section][path.row]];
            
        }
        
        [manager deleteTaskWith:deleteArray forStatus:YES];
        
        
        [self getDataArray];
        [self.tableView reloadData];
        
    }
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    if (self.isEdit) {
        
        CGFloat footH = 43+HGSafeBottom;
        self.bootView.frame = CGRectMake(0, self.view.height-footH, self.view.width, footH);
        self.tableView.frame = CGRectMake(0, 0, self.view.width, self.view.height-footH);
    }else
    {
        self.tableView.frame = self.view.bounds;
    }

}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    NSMutableArray *arr = self.dataArray[section];
    return ((arr.count == 0)?1:arr.count);
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSMutableArray *arr = self.dataArray[indexPath.section];
    
    if (arr.count) {
        HGDownloadTableViewCell *cell = [HGDownloadTableViewCell cellWithTableview:tableView with:indexPath];
        cell.indexPath = indexPath;
        cell.isEdit = self.isEdit;
        if (self.selectedDictionary[indexPath]) {
            cell.isSelected = YES;
        }else
        {
            cell.isSelected = NO;
        }
        TKDownLoadModel *model = arr[indexPath.row];
        cell.model = model;
        WeakSelf
        
        cell.editBlock = ^(NSIndexPath *path,BOOL isSelected) {
            
            if (isSelected) {
                
                [weakSelf.selectedDictionary setObject:@"1" forKey:path];
                
            }else
            {
                [weakSelf.selectedDictionary removeObjectForKey:path];
            }
            if (!weakSelf.selectedDictionary.count) {
                [weakSelf.RButton setTitle:@"删除" forState:UIControlStateNormal];
            }else
            {
                [weakSelf.RButton setTitle:[NSString stringWithFormat:@"删除(%ld)",self.selectedDictionary.count] forState:UIControlStateNormal];
            }
        };
        return cell;
    }else
    {
        HGNoDataTableViewCell *cell = [HGNoDataTableViewCell cellWithTabView:tableView];
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSMutableArray *arr = self.dataArray[indexPath.section];
    
    if (arr.count) {
        return 44;
    }else
    {
        return 100;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = HGColor(193, 193, 193, 1);
    UILabel *lable = [[UILabel alloc]init];
    lable.font = [UIFont systemFontOfSize:HGFont];
    lable.textAlignment = NSTextAlignmentLeft;
    lable.textColor = HGMainColor;
    lable.frame = CGRectMake(15, 0, self.tableView.width-2*15, 30);
    [header addSubview:lable];
    
    if (!section) {
        lable.text = @"视频";
    }else if (section == 1)
    {
        lable.text = @"课件";
    }else
    {
        lable.text = @"学员手册";
    }
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]init];
    return footer;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TKDownLoadModel *model = self.dataArray[indexPath.section][indexPath.row];
    if (indexPath.row == 0) {
        MPPlayerViewController *player = [[MPPlayerViewController alloc]init];
        
        player.isUrl = NO;
        
        player.title = model.titleStr;
        player.url = model.localUrl;
        FullNavViewController *nav = [[FullNavViewController alloc]initWithRootViewController:player];
        AppDelegate *app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        app.isFull = YES;
        [self presentViewController:nav animated:YES completion:nil];
    }else
    {
        HGWebViewController *web = [[HGWebViewController alloc]init];
        
        web.navigationItem.title = @"预览";
        
        web.url = model.localUrl;
        
        [self.navigationController pushViewController:web animated:YES];
    }
    
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
-(void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"downLoadComplete" object:nil];
}

@end
