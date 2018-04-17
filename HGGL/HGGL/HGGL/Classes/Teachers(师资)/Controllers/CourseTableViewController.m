//
//  CourseTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CourseTableViewController.h"
#import "CourseTableViewCell.h"
#import "CourseFrame.h"
#import "CourseList.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "TextFrame.h"
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGFont] Andwidth:60].height

@interface CourseTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,copy) NSString *error;
@end

@implementation CourseTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherCourse.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"teacher_id":self.teacher_id,@"tokenval":user_id} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            self.error = [responseObject objectForKey:@"message"];
        }else{
        for (NSDictionary *dict in array) {
            CourseList *course = [CourseList initWithDict:dict];
            CourseFrame *courseF = [[CourseFrame alloc]init];
            courseF.course = course;
            [self.arr addObject:courseF];
        }}
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    //HGLog(@"%@-%f",self.tableView,HGScreenHeight);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)showError
{
    if (self.error.length) {
//        [SVProgressHUD showErrorWithStatus:self.error];
        [SVProgressHUD showErrorWithStatus:self.error];
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CourseTableViewCell *cell = [CourseTableViewCell cellWithTabView:self.tableView];
    cell.courseF = [self.arr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseFrame *cou = [self.arr objectAtIndex:indexPath.row];
    HGLog(@"%f---==%f",cou.cellH,(3*minH+4*CellHMargin));
    return cou.cellH>=(3*minH+4*CellHMargin)?cou.cellH:(3*minH+4*CellHMargin);
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
