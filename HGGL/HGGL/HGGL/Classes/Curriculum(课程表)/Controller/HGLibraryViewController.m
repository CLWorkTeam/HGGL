//
//  HGLibraryViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGLibraryViewController.h"
#import "TeachToolBar.h"
#import "HGTRBModel.h"
#import "HGSRBModel.h"
#import "HGSGBTableViewCell.h"
#import "HGTRBTableViewCell.h"
#import "HGPopView.h"
@interface HGLibraryViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString *pageSize;
@property (nonatomic,copy) NSString *departmentId;
@property (nonatomic,copy) NSString *userId;
@property (nonatomic,strong) NSArray *partArray;
@property (nonatomic,strong) NSArray *memberArray;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,strong) UIButton *partButton;
@property (nonatomic,strong) UIButton *memberButton;
@property (nonatomic,weak) UIButton *studentButton;
@property (nonatomic,weak) UIButton *teacherButton;

@end

@implementation HGLibraryViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        
        _arr = [NSMutableArray array];
        
    }
    return  _arr;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = @"1";
    self.pageSize = @"10";
    self.departmentId = @"";
    self.userId = @"";
    self.isStudent = YES;
    [self setHeader];
    
}
-(void)setHeader
{
    UIView *tableHeader = [[UIView alloc]init];
    tableHeader.backgroundColor = HGGrayColor;
    tableHeader.frame = CGRectMake(0, 0, self.view.width, 53);
    UIView *content = [[UIView alloc]init];
    content.backgroundColor = [UIColor whiteColor];
    content.frame = CGRectMake(0, 0, self.view.width, 43);
    [tableHeader addSubview:content];
    CGFloat Hmar = 6.5;
    CGFloat Wmar = 8;
    CGFloat W = 10;
    CGFloat H = 30;
    UIButton *student = [self creatButtonWithTitle:@"学员借阅信息" font:14];
    student.tag = 401;
    student.selected = YES;
    student.backgroundColor = HGMainColor;
    [student sizeToFit];
    student.frame = CGRectMake(self.view.width/2-Wmar/2-student.width-W, Hmar, student.width+W, H);
    [content addSubview:student];
    self.studentButton = student;
    UIButton *teacher = [self creatButtonWithTitle:@"职工借阅信息" font:14];
    teacher.tag = 402;
    teacher.selected = NO;
    [teacher sizeToFit];
    teacher.frame = CGRectMake(self.view.width/2+Wmar/2, Hmar, teacher.width+W, H);
    teacher.backgroundColor = HGGrayColor;
    [content addSubview:teacher];
    self.teacherButton = teacher;
    self.tableView.tableHeaderView = tableHeader;
    
    [self setRefresh];
    
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock :^{
        [weakSelf loadData];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        
        NSInteger i = [self.page integerValue ];
        
        weakSelf.page = [NSString stringWithFormat:@"%ld",++i];
        
        [weakSelf loadMoreData];
        
    }];
    
    
}
-(void)loadData
{
    if (_isRefreshing) {
        
        return;
        
    }
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    self.page = @"1";
    NSDictionary *dict;
    NSString *url ;
    if (self.isStudent) {
        url = [HGURL stringByAppendingString:@""];
        dict = @{@"page":self.page,@"pageSize":self.pageSize};
    }else
    {
        url = [HGURL stringByAppendingString:@""];
        dict = @{@"page":self.page,@"pageSize":self.pageSize,@"departmentId":self.departmentId,@"userId":self.userId};
    }
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:dict success:^(id responseObject) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        [self.arr removeAllObjects];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            
            NSArray *array = [responseObject objectForKey:@"data"];
            
            for (NSDictionary *dict in array) {
                
                if (self.isStudent) {
                    HGSRBModel *model = [HGSRBModel initWithDict:dict];
                    
                    [self.arr addObject:model];
                    
                }else
                {
                    HGTRBModel *model = [HGTRBModel initWithDict:dict];
                    
                    [self.arr addObject:model];
                }
                
                
                
            }
            
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
        
        
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_header endRefreshing];
        [self.tableView reloadData];
        HGLog(@"%@",error);
    }];
}
-(void) loadMoreData
{
    
    if (_isRefreshing) {
        
        return;
        
    }
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSDictionary *dict;
    NSString *url ;
    if (self.isStudent) {
        url = [HGURL stringByAppendingString:@""];
        dict = @{@"page":self.page,@"pageSize":self.pageSize};
    }else
    {
        url = [HGURL stringByAppendingString:@""];
        dict = @{@"page":self.page,@"pageSize":self.pageSize,@"departmentId":self.departmentId,@"userId":self.userId};
    }
    
    _isRefreshing = YES;
    
    [HGHttpTool POSTWithURL:url parameters:dict success:^(id responseObject) {
        _isRefreshing = NO;
        [SVProgressHUD dismiss];
        [self.tableView.mj_footer endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray *array = [responseObject objectForKey:@"data"];
            if (self.isStudent) {
                HGSRBModel *model = [HGSRBModel initWithDict:dict];
                
                [self.arr addObject:model];
                
            }else
            {
                HGTRBModel *model = [HGTRBModel initWithDict:dict];
                
                [self.arr addObject:model];
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            NSInteger i = [self.page integerValue ];
            self.page = [NSString stringWithFormat:@"%ld",--i];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.tableView.mj_footer endRefreshing];
        NSInteger i = [self.page integerValue ];
        self.page = [NSString stringWithFormat:@"%ld",--i];
        HGLog(@"%@",error);
    }];
    
}
-(UIButton *)creatButtonWithTitle:(NSString *)title font:(CGFloat)font
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [but setTitleColor:HGMainColor forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:font];
    [but setTitleColor:HGMainColor forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:but];
    
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    return but;
}

-(void)clickBut:(UIButton *)button
{
    NSInteger tag = button.tag - 400;
    switch (tag) {
        case 1:
        {
            button.selected = YES;
            button.backgroundColor = HGMainColor;
            self.teacherButton.selected = NO;
            self.teacherButton.backgroundColor = HGGrayColor;
            self.isStudent = YES;
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 2:
        {
            button.selected = YES;
            button.backgroundColor = HGMainColor;
            self.studentButton.selected = NO;
            self.studentButton.backgroundColor = HGGrayColor;
            self.isStudent = NO;
            [self.tableView.mj_header beginRefreshing];
        }
            break;
        case 3:
        {
            [self getDepartmengt];
        }
            break;
        case 4:
        {
            [self showMember];
        }
            break;
            
        default:
            break;
    }
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.arr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (self.isStudent) {
        HGSGBTableViewCell *cell = [HGSGBTableViewCell cellWithTabView:self.tableView];
        
        HGSRBModel *model = self.arr[indexPath.row];
        
        cell.model = model;
        
        return cell;
    }else
    {
        HGTRBTableViewCell *cell = [HGTRBTableViewCell cellWithTabView:self.tableView];
        
        HGTRBModel *model = self.arr[indexPath.row];
        
        cell.model = model;
        
        return cell;
    }
    
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isStudent) {
        return 120;
    }else
    {
        return 60;
    }
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]init];
    if (!self.isStudent) {
        
        CGFloat Hmar = 6.5;
        CGFloat Wmar = 10;
        CGFloat H = 30;
        CGFloat buttonW = (self.view.width-3*Wmar)/2;
        if (!self.partButton) {
            UIButton *student = [self creatButtonWithTitle:@"选择部门" font:14];
            student.tag = 403;
            [student setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            self.partButton = student;
            
            
            [student setBackgroundColor:HGColor(0, 209, 255, 1)];
        }
        if (!self.memberButton) {
            UIButton *teacher = [self creatButtonWithTitle:@"选择用户" font:14];
            teacher.tag = 404;
            self.memberButton = teacher;
            
            
            [teacher setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [teacher setBackgroundColor:HGColor(0, 209, 255, 1)];
        }
        [header addSubview:self.partButton];
        self.partButton.frame = CGRectMake(Wmar, Hmar, buttonW, H);
        [header addSubview:self.memberButton];
        self.memberButton.frame = CGRectMake(self.studentButton.maxX+Wmar, Hmar, buttonW,  H);
        
    }
    return header;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (!self.isStudent) {
        return 43;
    }
    return 0;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
}
-(void)getDepartmengt
{
    if (self.partArray) {
        [self showDepartMent];
        return;
    }
    
    NSString *url = [HGURL stringByAppendingString:@"User/getDeptProject.do"];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [HGHttpTool POSTWithURL:url parameters:@{@"type":@"2",@"user_id":[HGUserDefaults objectForKey:HGUserID]} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            self.partArray = nil;
            self.partArray = array;
            [self showDepartMent];
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}
-(void)showDepartMent
{

    UIButton *button = self.partButton;
    CGRect r = [button.superview convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*((self.partArray.count<5)?self.partArray.count:5));
    
    [HGPopView setPopViewWith:rect  And:self.partArray andShowKey:@"departName"  selectBlock:^(NSDictionary *dict) {
        
        [button setTitle:dict[@"departName"] forState:UIControlStateNormal];
        if (dict[@"departId"]) {
            self.departmentId = [NSString stringWithFormat:@"%zd",[dict[@"departId"] integerValue]];
        }else
        {
            self.departmentId = @"";
        }
        
        self.memberArray = dict[@"staffList"];
        [self.memberButton setTitle:@"选择用户" forState:UIControlStateNormal];
        self.userId = @"";
        [self.tableView.mj_header beginRefreshing];
        
    }];
    
}
-(void)showMember
{
    if (!self.memberArray) {
        [SVProgressHUD showErrorWithStatus:@"您还未选择部门，请先选择部门"];
        return;
    }
    
    UIButton *button = self.memberButton;
    CGRect r = [button.superview convertRect:button.frame toView:HGKeywindow];
    CGRect rect = CGRectMake(r.origin.x, r.origin.y+r.size.height, r.size.width, 44*((self.memberArray.count<5)?self.memberArray.count:5));
    
    [HGPopView setPopViewWith:rect  And:self.memberArray andShowKey:@"staffName"  selectBlock:^(NSDictionary *dict) {
        
        [button setTitle:dict[@"staffName"] forState:UIControlStateNormal];
        
        self.userId = dict[@"staffUserId"]?dict[@"staffUserId"]:@"";
        
        [self.tableView.mj_header beginRefreshing];
        
    }];
}
@end
