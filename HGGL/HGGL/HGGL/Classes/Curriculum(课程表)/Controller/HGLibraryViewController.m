//
//  HGLibraryViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGLibraryViewController.h"
#import "TeachToolBar.h"
@interface HGLibraryViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,assign) BOOL isStudent;
@property (nonatomic,copy) NSString *page;
@property (nonatomic,copy) NSString *pageSize;
@property (nonatomic,copy) NSString *departmentId;
@property (nonatomic,copy) NSString *userId;


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
    
}
-(void)setHeader
{
    UIView *tableHeader = [[UIView alloc]init];
    tableHeader.frame = CGRectMake(0, 0, self.view.width, 43);
    CGFloat Hmar = 6.5;
    CGFloat Wmar = 8;
    CGFloat W = 10;
    CGFloat H = 30;
    UIButton *student = [self creatButtonWithTitle:@"学员借阅信息" font:14];
    student.tag = 401;
    [student sizeToFit];
    student.frame = CGRectMake(self.view.width/2-Wmar/2-student.width-W, Hmar, student.width+W, H);
    [tableHeader addSubview:student];
    
    UIButton *teacher = [self creatButtonWithTitle:@"职工借阅信息" font:14];
    teacher.tag = 402;
    [teacher sizeToFit];
    teacher.frame = CGRectMake(self.view.width/2+Wmar/2, Hmar, teacher.width+W, Hmar);
    [tableHeader addSubview:teacher];
    
    self.tableView.tableHeaderView = tableHeader;
    
}
-(void)setRefresh
{
    __weak typeof(self)weakSelf = self;
    self.tableView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock :^{
        [weakSelf loadData];
    }];
    
    
    [self.tableView.mj_header beginRefreshing];
    
    self.tableView.mj_footer = [HGRefresh loadMoreRefreshWithRefreshBlock:^{
        
        NSInteger i = [self.parama.page integerValue ];
        
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
        url = [HGURL stringByAppendingString:@"Reception/getRecList.do"];
        dict = @{@"page":self.page,@"pageSize":self.pageSize};
    }else
    {
        url = [HGURL stringByAppendingString:@"Reception/getRecList.do"];
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
                
                HGRSModel *mes = [HGRSModel initWithDict:dict];
                
                [self.arr addObject:mes];
                
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
        
        HGLog(@"%@",error);
    }];
}
-(UIButton *)creatButtonWithTitle:(NSString *)title font:(CGFloat)font
{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [but setTitleColor:HGMainColor forState:UIControlStateNormal];
    [but setTitleColor:HGMainColor forState:UIControlStateSelected];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:font];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:title forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:but];
    [but setBackgroundColor:HGColor(0, 209, 255, 1)];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    return but;
}

-(void)clickBut:(UIButton *)button
{
    
}
@end
