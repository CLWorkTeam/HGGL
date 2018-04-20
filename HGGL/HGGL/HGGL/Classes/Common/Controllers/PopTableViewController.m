//
//  PopTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-16.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PopTableViewController.h"
#import "CurrImageView.h"
#import "TKProfessionTableViewCell.h"
@interface PopTableViewController ()

@end

@implementation PopTableViewController
//-(NSArray *)arr
//{
//    if (_arr == nil) {
//        _arr = [NSArray arrayWithObjects:@"当日餐饮",@"当日住宿",@"当日用车",@"当日教室", nil];
//    }
//    return _arr;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorInset =  UIEdgeInsetsMake(0, 0, 0, 0);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
+(instancetype)setPopViewWith:(CGRect)rect And:(NSArray *)arr
{
    
    CurrImageView *topView = [CurrImageView showInRect:rect];
    PopTableViewController *popView = [[PopTableViewController alloc]init];
    ///popView = popView;
    topView.contentView = popView.tableView;
    popView.arr = arr;
    //[PopView setTabFrame];
    [HGKeywindow addSubview:topView];
    //HGLog(@"%@",self.view.subviews);
    return popView;
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
//    static NSString *ID = @"cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
//    }
//    cell.textLabel.text = [self.arr objectAtIndex:indexPath.row];
//    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    //NSLog(@"%@",cell.textLabel.text);
    TKProfessionTableViewCell *cell = [TKProfessionTableViewCell cellWithTabView:tableView];
    cell.content = [self.arr objectAtIndex:indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedCell) {
        _selectedCell([self.arr objectAtIndex:indexPath.row]);
    }
}
-(void)dealloc
{
    HGLog(@"pop");
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
