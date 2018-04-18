//
//  RecTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "RecTableViewController.h"
#import "RecTableViewCell.h"
#import "HGHttpTool.h"
#import "Dinner.h"
#import "Car.h"
#import "room.h"
#import "ClassRoom.h"
//#import "MBProgressHUD+Extend.h"
#import "TaskTableViewController.h"
@interface RecTableViewController ()
@property (nonatomic,strong) NSString *today;
@property (nonatomic,strong) NSMutableArray *array;
@end

@implementation RecTableViewController
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
    }
    return _array;
}
-(NSString *)today
{
    if (_today == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _today = [fomatter stringFromDate:[NSDate date] ];
    }
    return _today;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    [self dinner];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)dinner
{
    [self.array removeAllObjects];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getDiningToday.do"];
    HGLog(@"%@--%@",url,self.today);
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"date_today":self.today,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            HGLog(@"%@",arr);
            for (NSDictionary *dict in arr) {
                Dinner *d = [Dinner initWithDict:dict];
                [self.array addObject:d];
                
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [self.tableView reloadData];
    }];
}
-(void)car
{
    [self.array removeAllObjects];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getCarToday.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"date_today":self.today,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            HGLog(@"%@",arr);
            for (NSDictionary *dict in arr) {
                Car *c = [Car initWithDict:dict];
                [self.array addObject:c];
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [self.tableView reloadData];
    }];
}
-(void)room
{
    [self.array removeAllObjects];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getAccomToday.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"date_today":self.today,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in arr) {
                room *r = [room initWithDict:dict];
                [self.array addObject:r];
                
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [self.tableView reloadData];
    }];
}
-(void)classRoom
{
    [self.array removeAllObjects];
    NSString *url = [HGURL stringByAppendingString:@"Reception/getClassroomToday.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"date_today":self.today,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        
        if ([status isEqualToString:@"1"]) {
            NSArray *arr = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in arr) {
                HGLog(@"%@",dict[@"classroom_use"]);
                ClassRoom *cr = [ClassRoom initWithDict:dict];
                [self.array addObject:cr];
                
            }
            [self.tableView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [self.tableView reloadData];
    }];
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
    
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RecTableViewCell *cell = [RecTableViewCell cellWithTabView:self.tableView];
    id d = [self.array objectAtIndex:indexPath.row];
    
    if ([d isKindOfClass:[Dinner class]]) {
        Dinner *d =[self.array objectAtIndex:indexPath.row];
        cell.one = d.dining_num;
        cell.two = d.dining_time;
        cell.three = d.dining_place;
    }else if ([d isKindOfClass:[Car class]])
    {
        Car *c = [self.array objectAtIndex:indexPath.row];
        cell.one = c.car_driver;
        cell.two = c.car_num;
        cell.three = c.car_approvalstart;
    }else if([d isKindOfClass:[room class]])
    {
        room *r = [self.array objectAtIndex:indexPath.row];
        cell.one = r.accom_name;
        cell.two = r.accom_num;
        cell.three = r.accom_type;
    }else if([d isKindOfClass:[ClassRoom class]])
    {
        ClassRoom *cr = [self.array objectAtIndex:indexPath.row];
        cell.one = cr.classroom_num;
        cell.two = cr.classroom_start;
        cell.three = cr.classroom_end;
    }
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskTableViewController *tvc = [[TaskTableViewController alloc]init];
    tvc.obj = [self.array objectAtIndex:indexPath.row];
    if (_cellBlock) {
        _cellBlock(tvc);
    }
}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    self.tableView.contentSize = CGSizeMake(HGScreenWidth, 15*44+49);
//}


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
