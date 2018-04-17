//
//  CurrentTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrentTableViewController.h"
#import "HGHttpTool.h"
#import "Currse.h"
#import "CurrseList.h"
////#import "MBProgressHUD+Extend.h"
#import "CurrTableViewCell.h"
#import "BaseTableViewCell.h"
#import "CurrHeader.h"
#import "ZKRCover.h"
#import "PopTableViewController.h"
#import "CurrImageView.h"
#import "CurrentTableViewCell.h"
#import "CurrseList.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
@interface CurrentTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *currArr;
@property (nonatomic,strong) NSMutableArray *otherArr;
@property (nonatomic,strong) NSMutableArray *myCellArr;
@property (nonatomic,strong) NSString *headerTitle;
@property (nonatomic,strong) NSArray *categoryArr;
@property (nonatomic, strong)UIButton *classRoomBtn;
@property(nonatomic, strong)NSString *roomType;
@property(nonatomic,copy) NSString *date;
@property(nonatomic, strong)PopTableViewController *pop;


@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation CurrentTableViewController
-(NSString *)roomType
{
    if (_roomType == nil) {
        _roomType = @"1";
    }
    return _roomType;
}
-(NSString *)headerTitle
{
    if (_headerTitle == nil) {
        _headerTitle = @"教室资源";
    }
    return _headerTitle;
}
-(NSMutableArray *)myCellArr
{
    if (_myCellArr == nil) {
        _myCellArr = [NSMutableArray array];
        
    }
    return _myCellArr;
    
}
-(NSMutableArray *)currArr
{
    if (_currArr == nil) {
        _currArr = [NSMutableArray array];
        
    }
    return _currArr;
}
-(NSMutableArray *)otherArr
{
    if (_otherArr == nil) {
        _otherArr = [NSMutableArray array];
        
    }
    return _otherArr;
}
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray arrayWithObjects:self.currArr,self.otherArr, nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)postWith:(NSString *)date
{

    self.date = date;
//    NSLog(@"self.data = %@", self.date);
    [self.myCellArr removeAllObjects];
//    [self.otherArr removeAllObjects];
    [self.tableView reloadData];
    
    NSString *url = [HGURL stringByAppendingString:@"/Project/getClassroomToday.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:url parameters:@{@"course_date":date, @"roomType":self.roomType,@"tokenval":user_id} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        HGLog(@"%@",self.roomType);
        array = [responseObject objectForKey:@"data"];

         HGLog(@"-----%@",array);
        NSString *status = [responseObject objectForKey:@"status"];
//        status = @"1";
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else
        {
//            for (NSDictionary *dict in array) {
//                Currse *cu = [Currse initWithDict:dict];
//                if (cu.course_style.intValue == -1) {
//                    for (CurrseList *cl in cu.course_AM) {
//                        [self.otherArr addObject:cl];
//                    }
//                    
//                    for (CurrseList *cl in cu.course_PM) {
//                        [self.otherArr addObject:cl];
//                    }
//                    for (CurrseList *cl in cu.course_NT) {
//                        [self.otherArr addObject:cl];
//                    }
//                }else{
//                    [self.currArr addObject:cu];
//                }
//                
//            }
            for (NSDictionary *dic in array) {
                CurrseList *currse = [CurrseList initWithDict:dic];
                [self.myCellArr addObject:currse];
                
            }

            
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
//        HGLog(@"%@",error);
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return  40;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
//        CurrHeader *header= [[CurrHeader alloc] init];
        UIView *view = [[UIView alloc] init];
        view.backgroundColor = [UIColor whiteColor];
        view.frame = CGRectMake(0, 0, HGScreenWidth, 45);
        UIButton *classRoomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        classRoomBtn.backgroundColor = [UIColor clearColor];
        [classRoomBtn setTitle:self.headerTitle forState:UIControlStateNormal];
        classRoomBtn.frame = CGRectMake(0, 0, HGScreenWidth/2, 40);
        classRoomBtn.titleLabel.font = [UIFont systemFontOfSize:HGTextFont1];
        [classRoomBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [classRoomBtn addTarget:self action:@selector(classClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:classRoomBtn];
        self.classRoomBtn = classRoomBtn;
        
        UIView *viewLine = [[UIView alloc] init];
        viewLine.frame = CGRectMake(HGScreenWidth/2-1, 15, 1, 15);
        viewLine.backgroundColor = HGColor(220, 220, 220,1);
        [view addSubview:viewLine];
        
        UIView *viewLine1 = [[UIView alloc] init];
        viewLine1.frame = CGRectMake(5, 39, HGScreenWidth-10, 1);
        viewLine1.backgroundColor = HGColor(220, 220, 220,1);
        [view addSubview:viewLine1];
        
        UILabel *takeUp = [[UILabel alloc] init];
        takeUp.frame = CGRectMake(HGScreenWidth/2, 0, HGScreenWidth/2, 40);
        takeUp.textAlignment = NSTextAlignmentCenter;
        takeUp.font = [UIFont systemFontOfSize:HGTextFont1];
        takeUp.text = @"占用情况";
        [view addSubview:takeUp];
        
        return view;
   
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
        return self.myCellArr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *ID1 = @"cell1";
    
//    if (indexPath.section == 0) {
    
//        CurrTableViewCell *cell = [CurrTableViewCell cellWithTabView:self.tableView];
//        cell.cu = [self.currArr objectAtIndex:indexPath.row];
//        cell.current_date = self.current_date;
//        __weak typeof (self) weekSelf = self;
//        cell.currCellClick = ^(id vc)
//        {
//            if (weekSelf.currentBlock) {
//                weekSelf.currentBlock(vc);
//            }
//        };
//        cell.currButClick = ^(id vc )
//        {
//            if (weekSelf.currentBlock) {
//                weekSelf. currentBlock(vc);
//            }
//        };
        CurrentTableViewCell *cell = [CurrentTableViewCell cellWithTabView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        CurrseList *model = [self.myCellArr objectAtIndex:indexPath.row];
        cell.currse = model;
        return cell;
//    }
//    else{
//        
////        BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
//        
////        cell.name = cu.course_classroom;
//        CurrseList *cl = [self.otherArr objectAtIndex:indexPath.row];
//        UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID1];
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID1];
//        
//        cell.textLabel.text = cl.course_name;
//        return cell;
//        
//    }

 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
        return 30;
}
-(void)classClick:(UIButton *)btn
{
//    HGLog(@"点击");
    ZKRCover *cover = [ZKRCover show];
    cover.dimBackGround = YES;
    cover.ZKRCoverDismiss = ^(){
        
        [CurrImageView  dismiss];};
    self.categoryArr = @[@"教室资源", @"研讨室资源", @"会议室资源"];
    CGRect rect = CGRectMake(0, 226, HGScreenWidth/2, 44*self.categoryArr.count);
    PopTableViewController *pop = [PopTableViewController setPopViewWith:rect And:self.categoryArr];
    self.pop = pop;
    __weak typeof(self)weakSelf = self;
    
    pop.selectedCell = ^(NSString *str){
        
        
//        [weakSelf.classRoomBtn setTitle:str forState:UIControlStateNormal];
        HGLog(@"%@",weakSelf.classRoomBtn.titleLabel.text);
            if ([str isEqualToString:@"教室资源"]) {
                weakSelf.roomType = @"1";
                
                
            } else if ([str isEqualToString:@"研讨室资源"]){
                weakSelf.roomType = @"2";
            } else
            {
                weakSelf.roomType = @"3";
            }
        weakSelf.headerTitle = str;
        [weakSelf postWith:self.date];
        [CurrImageView  dismiss];
        
        //这句话必须的加上,否则上面会有一层透明的遮罩
        [ZKRCover dismiss];
        
        cover.dimBackGround = NO;
    };
    
}

@end
