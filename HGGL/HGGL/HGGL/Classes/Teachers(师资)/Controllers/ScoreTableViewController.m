//
//  ScoreTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ScoreTableViewController.h"
//#import "ScoreTableViewCell.h"
#import "HGTRcordTableViewCell.h"
//#import "ScoreList.h"
#import "HGTeachRecord.h"
#import "HGHttpTool.h"
#import "CSTableViewController.h"
////#import "MBProgressHUD+Extend.h"
#import "TextFrame.h"
@interface ScoreTableViewController ()
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,copy) NSString *error;
@end

@implementation ScoreTableViewController
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *url = [HGURL stringByAppendingString:@"Teacher/getRecord.do?"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"teacher_id":self.teacher_id,@"tokenval":user_id} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            self.error =  [responseObject objectForKey:@"message"];
        }else{
        for (NSDictionary *dict in array) {
            HGTeachRecord *record = [HGTeachRecord initWithDict:dict];
            [self.array addObject:record];
            
        }
        [self.tableView reloadData];}
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
    return self.array.count ;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGTRcordTableViewCell *cell = [HGTRcordTableViewCell cellWithTabView:self.tableView];
    WeakSelf
    cell.scoreBlock = ^(id vc) {
        if (weakSelf.selectedRow) {
            weakSelf.selectedRow(vc);
        }
    };
    cell.record = [self.array objectAtIndex:indexPath.row];
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ScoreList *sc = [self.array objectAtIndex:indexPath.row];
//
//    return sc.cellH>(4*minH+5*CellHMargin)?sc.cellH:(4*minH+5*CellHMargin);
    return 2*minH+30+4*CellHMargin;
}

-(void)dealloc
{
    //NSLog(@"score");
    
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
