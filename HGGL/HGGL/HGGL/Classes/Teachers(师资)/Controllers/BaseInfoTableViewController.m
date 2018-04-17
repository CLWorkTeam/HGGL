//
//  BaseInfoTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BaseInfoTableViewController.h"
#import "BaseTableViewCell.h"
#import "BaseHeaderView.h"
#import "HGHttpTool.h"
#import "teacBaseInfo.h"
#import "TeacBaseFrame.h"
////#import "MBProgressHUD+Extend.h"
#import "TextFrame.h"
@interface BaseInfoTableViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,copy) NSString *error;
@end

@implementation BaseInfoTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
//        NSString *path = [[NSBundle mainBundle] pathForResource:@"TeacherPro.plist" ofType:nil];
//        _arr = [NSArray arrayWithContentsOfFile:path];
        _arr = [NSArray arrayWithObjects:@[@"聘任类型:",@"专业领域:",@"适合班次:",@"课酬区间:"],@[@"工作单位:",@"单位地址:",@"职位:"],@[@"民族:",@"出生日期:",@"证件类型:",@"证件号码:"],@[@"移动电话:",@"办公电话:",@"传真号码:",@"邮箱地址:",@"邮政编码:"],nil];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    //self.tableView.userInteractionEnabled = NO;
//    self.tableView.style = UITableViewStyleGrouped;
    [self setHeader];
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherInfo.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:url parameters:@{@"teacher_id":self.teacher_id,@"tokenval":user_id} success:^(id responseObject) {
////////////////////////////////////////////////////////
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        HGLog(@"-----%@",dict[@"teacher_sex"]);
        if([status isEqualToString:@"0"])
        {
            self.error = [responseObject objectForKey:@"message"];
        }else{
        teacBaseInfo *info = [teacBaseInfo initWithDict:dict];
        TeacBaseFrame *baseFrame = [[TeacBaseFrame alloc]init];
        baseFrame.baseInfo = info;
        self.teachInfo = baseFrame;
        self.array = self.teachInfo.baseArr;
  
        [self.tableView reloadData];
            [self setHeader];}
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)showError
{    if (self.error.length) {
//    [SVProgressHUD showErrorWithStatus:self.error];
    [SVProgressHUD showErrorWithStatus:self.error];
}

}
-(void)setHeader
{
    BaseHeaderView *header = [[BaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 120)];
    header.nameS = self.teachInfo.baseInfo.teacher_name;
    header.telS = self.teachInfo.baseInfo.teacher_tel;
    header.sexS = self.teachInfo.baseInfo.teacher_sex;
    self.tableView.tableHeaderView = header;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    NSArray *arr = [self.arr objectAtIndex:section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    // Configure the cell...
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
//    static NSString *ID = @"cell";
//    BaseTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        //cell.backgroundColor = [UIColor whiteColor];
//        cell = [[BaseTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
//    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //HGLog(@"%@",cell.infoArr);
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //HGLog(@"高度");
    NSNumber *num = [[self.teachInfo.frameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    HGLog(@"%f",num.floatValue);
    return num.floatValue>=(minH+2*CellHMargin)?num.floatValue:(minH+2*CellHMargin);
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
