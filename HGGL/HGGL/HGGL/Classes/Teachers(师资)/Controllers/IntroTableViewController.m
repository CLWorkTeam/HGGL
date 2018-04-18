//
//  IntroTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-30.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "IntroTableViewController.h"
#import "IntroTableViewCell.h"
#import "HGHttpTool.h"
#import "TeacIntroInfo.h"
#import "TeacIntroFrame.h"
////#import "MBProgressHUD+Extend.h"
@interface IntroTableViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *cellH;
@property (nonatomic,strong) TeacIntroFrame *TF;
@property (nonatomic,copy) NSString *error;
@end

@implementation IntroTableViewController
-(NSArray *)arr
{
    if (_arr ==nil) {
        _arr = [NSArray arrayWithObjects:@"教师简介:",@"判别依据:",@"师资来源:",@"学习经历:",@"工作经历:",@"备注信息:", nil];
    }
    return _arr;
}
//-(NSArray *)cellH
//{
//    if (_cellH == nil) {
//        _cellH = [NSArray array];
//    }
//    return _cellH;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getTeacherDec.do"];
    HGLog(@"ID%@",self.teacher_id);
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"teacher_id":self.teacher_id,@"tokenval":user_id} success:^(id responseObject) {
        ////////////////////////////////////
        /////////接口文档上data是info/////////
        ///////////////////////////////////
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            self.error = [responseObject objectForKey:@"message"];
        }else{
        HGLog(@"dict%@",dict);
            
        TeacIntroInfo *info = [TeacIntroInfo initWithDict:dict];
        self.TF = [[TeacIntroFrame alloc] init];
        self.TF.info = info;
        self.cellH = self.TF.frameArr;
        [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    IntroTableViewCell *cell = [IntroTableViewCell cellWithTabView:self.tableView];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name = [self.arr objectAtIndex:indexPath.row];
    cell.info =  [self.TF.baseArr objectAtIndex:indexPath.row];
//    HGLog(@"%@",cell.info);
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = [self.TF.frameArr objectAtIndex:indexPath.row];
    CGFloat heigh = num.floatValue;
    return heigh >= 60? heigh:60;
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
