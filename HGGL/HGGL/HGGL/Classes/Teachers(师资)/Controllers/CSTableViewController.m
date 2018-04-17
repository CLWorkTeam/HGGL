//
//  CSTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-27.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CSTableViewController.h"
#import "CSTableViewCell.h"
#import "HGHttpTool.h"
#import "CourseScore.h"
////#import "MBProgressHUD+Extend.h"
#import "TextFrame.h"
@interface CSTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@end

@implementation CSTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getScoreDetail.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:url parameters:@{@"projectCourse_id":self.projectCourse_id,@"tokenval":user_id} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
        for (NSDictionary *dict in array) {
            
            CourseScore *cs = [CourseScore courseScoreWithDict:dict];
            [self.arr addObject:cs];
            
        }}
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    CSTableViewCell *cell = [CSTableViewCell cellWithTabView:self.tableView];
    
    cell.cs = [self.arr objectAtIndex:indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CourseScore *cs = [self.arr objectAtIndex:indexPath.row];
    return cs.cellH>(minH*4+5*CellHMargin)?cs.cellH:(minH*4+5*CellHMargin);
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
