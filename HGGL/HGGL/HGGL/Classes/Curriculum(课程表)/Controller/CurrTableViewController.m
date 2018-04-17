//
//  CurrTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-9.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrTableViewController.h"
#import "Date.h"
@interface CurrTableViewController ()
//@property (nonatomic,strong) NSMutableArray *array;
@end
static NSString *ID = @"cell";
@implementation CurrTableViewController

//-(void)setDateOfYear:(NSArray *)dateOfYear
//{
//    _dateOfYear = dateOfYear;
//    _array = [NSMutableArray array];
//    for (NSDictionary *dict in _dateOfYear) {
//        Date *date = [Date dateWithDict:dict];
//        [_array addObject:date];
//    }
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tableView.frame =  CGRectMake(0, 0, <#CGFloat width#>, <#CGFloat height#>)
    //NSLog(@"%f",self.tableView.frame.origin.y);
    self.tableView.bounces = NO;
    self.tableView.backgroundColor = [UIColor grayColor];
    //NSLog(@"%ld",self.dateOfYear.count);
    
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
    return self.dateOfYear.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    Date *date = [[Date alloc]init];
    date = [self.dateOfYear objectAtIndex:indexPath.row];
    //NSLog(@"%@,%@,%ld",date.week,date.weekStar,self.dateOfYear.count);
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];

    }
    cell.textLabel.text = [NSString stringWithFormat:@"第%@周",date.week];
    cell.textLabel.font = [UIFont systemFontOfSize:16];
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@-%@",date.weekStar,date.weekEnd];
    cell.detailTextLabel.font = [UIFont systemFontOfSize:11];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_selectCell) {
        Date *date = [[Date alloc]init];
        date = [self.dateOfYear objectAtIndex:indexPath.row];
        _selectCell(date);
        //_selectCell(dict[@"weekStar"]);
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
