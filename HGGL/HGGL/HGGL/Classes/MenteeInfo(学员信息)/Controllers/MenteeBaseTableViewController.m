//
//  MenteeBaseTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeBaseTableViewController.h"
#import "BaseTableViewCell.h"
#import "HGHttpTool.h"
#import "HGMenteeSelCell.h"
#import "Mentee.h"
#import "HGMenteeListModel.h"
#import "MenteeFrame.h"
#import "BaseHeaderView.h"
#import "TextFrame.h"
#import "ProjectInfoViewController.h"
@interface MenteeBaseTableViewController ()
@property (nonatomic,strong) HGMenteeListModel *MF;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,copy) NSString *error;
@end

@implementation MenteeBaseTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"TeacherPro.plist" ofType:nil];
        //        _arr = [NSArray arrayWithContentsOfFile:path];
        _arr = [NSArray arrayWithObjects:@[@"关区:",@"部门:",@"职务:"],@[@"邮箱地址:",@"生日日期:",@"年龄:",@"证件号码:",@"民族:",@"备注"],@[@"当前所在项目:"],nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    //self.tableView.userInteractionEnabled = NO;
    //    self.tableView.style = UITableViewStyleGrouped;
//    [self setHeader];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getBaseInfo.do"];
    NSString *user_id = [HGUserDefaults stringForKey:HGUserID];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [HGHttpTool POSTWithURL:url parameters:@{@"student_id":self.mentee_id} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        
        NSString *status = [responseObject objectForKey:@"status"];
        
        HGLog(@"-----%@",dict[@"teacher_sex"]);
        
        if([status isEqualToString:@"0"])
        {
            self.error = [responseObject objectForKey:@"message"];
        }else{
            HGMenteeListModel *info = [HGMenteeListModel initWithDict:dict];
            self.MF = info;
            self.array = info.menteeArray;
            
            [self.tableView reloadData];
            [self setHeader];
            
        }
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
    
    
}
-(void)setHeader
{
    BaseHeaderView *header = [[BaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 120)];
    header.nameS = self.MF.student_name;
    header.telS = self.MF.student_tel;
    header.sexS = self.MF.student_sex;
    self.tableView.tableHeaderView = header;
}
-(void)showError
{    if (self.error.length) {
    //    [SVProgressHUD showErrorWithStatus:self.error];
    [SVProgressHUD showErrorWithStatus:self.error];
}
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = HGGrayColor;
    return header;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 10;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.array.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *arr = [self.arr objectAtIndex:section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 2) {
        HGMenteeSelCell *cell = [HGMenteeSelCell cellWithTabView:tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        return cell;
    }else
    {
        BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        cell.nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
        //HGLog(@"%@--%@",cell.name,cell.nameV);
        return cell;
    }
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    HGLog(@"%ld   %ld",indexPath.section,indexPath.row);
//    NSNumber *num = [[self.MF.frameArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
//    return num.floatValue>=(minH+2*CellHMargin)?num.floatValue:(minH+2*CellHMargin);
    return minH+2*CellHMargin;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 2) {
        ProjectInfoViewController *pinfo = [[ProjectInfoViewController alloc]init];
        pinfo.project_id = self.MF.projectId;
        if (_PushBlock) {
            _PushBlock(pinfo);
        }
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footer = [[UIView alloc]init];
    if (section == 2) {
        footer.backgroundColor = HGGrayColor;
    }
    
    
    return footer;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == 2) {
        return 10;
    }else
    {
        return .1;
    }
    
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
