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
//#import "MBProgressHUD+Extend.h"
#import "Mentee.h"
#import "MenteeFrame.h"
#import "BaseHeaderView.h"
#import "TextFrame.h"
@interface MenteeBaseTableViewController ()
@property (nonatomic,strong) MenteeFrame *MF;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *arr;
@end

@implementation MenteeBaseTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        //        NSString *path = [[NSBundle mainBundle] pathForResource:@"TeacherPro.plist" ofType:nil];
        //        _arr = [NSArray arrayWithContentsOfFile:path];
        _arr = [NSArray arrayWithObjects:@[@"工作单位:",@"职务:",@"学历学位:",@"政治面貌:"],@[@"民族:",@"生日:",@"年龄:",@"身份证号码",@"籍贯"],@[@"邮箱:",@"备注:"],nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    //self.tableView.userInteractionEnabled = NO;
    //    self.tableView.style = UITableViewStyleGrouped;
    [self setHeader];
    MenteeFrame *baseFrame = [[MenteeFrame alloc]init];
    baseFrame.baseInfo = self.mentee;
    self.MF = baseFrame;
    self.array = self.MF.baseArr;
    
//    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherInfo.do"];
//    [HGHttpTool POSTWithURL:url parameters:@{@"mentee_id":self.mentee_id} success:^(id responseObject) {
//        
//        NSDictionary *dict = [responseObject objectForKey:@"data"];
//        NSString *status = [responseObject objectForKey:@"status"];
//        if([status isEqualToString:@"0"])
//        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
//        }else{
//            Mentee *info = [Mentee initWithDict:dict];
//            MenteeFrame *baseFrame = [[MenteeFrame alloc]init];
//            baseFrame.baseInfo = info;
//            self.MF = baseFrame;
//            self.array = self.MF.baseArr;
//            
//            [self.tableView reloadData];
//            [self setHeader];}
//    } failure:^(NSError *error) {
//        HGLog(@"%@",error);
//    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)setHeader
{
    BaseHeaderView *header = [[BaseHeaderView alloc]initWithFrame:CGRectMake(0, 0, self.tableView.frame.size.width, 120)];
    header.nameS = self.mentee.mentee_name;
    header.telS = self.mentee.mentee_tel;
    header.sexS = self.mentee.mentee_sex;
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
    // Return the number of sections.
    return self.array.count ;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSArray *arr = [self.arr objectAtIndex:section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //HGLog(@"%@--%@",cell.name,cell.nameV);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HGLog(@"%ld   %ld",indexPath.section,indexPath.row);
    NSNumber *num = [[self.MF.frameArr objectAtIndex:indexPath.section]objectAtIndex:indexPath.row];
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
