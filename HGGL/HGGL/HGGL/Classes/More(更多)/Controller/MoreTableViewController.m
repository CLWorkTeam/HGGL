//
//  MoreTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-5-28.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MoreTableViewController.h"
#import "TeachTableViewCell.h"
#import "PersonInfoTableViewController.h"
#import "EditViewController.h"
#import "HGLoginController.h"
@interface MoreTableViewController ()
@property (nonatomic,strong) NSArray *titleArr;
@property (nonatomic,strong) NSArray *imaArr;
@end

@implementation MoreTableViewController
-(NSArray *)titleArr
{
    if (_titleArr == nil) {
        NSArray *arr = [NSArray arrayWithObjects:@"个人信息及修改",@"账户密码修改",@"联系我们",@"退出当前账号", nil];
        _titleArr = arr;
    }
    return _titleArr;
}
-(NSArray *)imaArr
{
    if (_imaArr == nil) {
        _imaArr = [NSArray arrayWithObjects:@"",@"",@"",@"",@"", nil];
    }
    return _imaArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    NSString *mytimestr=@"丑巳午未申";
//    size_t length = [mytimestr length];
//    for (size_t i=0; i < length; i++) {
//        unichar c = [mytimestr characterAtIndex:i];
//        NSLog(@"%C", c);
//    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
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
    return self.titleArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TeachTableViewCell *cell = [TeachTableViewCell cellWithTabView:self.tableView];
    [cell.name setTitle:[self.titleArr objectAtIndex:indexPath.row] forState:UIControlStateNormal];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.name.userInteractionEnabled = NO;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.row == 0) {
        [cell.name setImage:[UIImage imageNamed:@"personal_information"] forState:UIControlStateNormal];
        
    }else if (indexPath.row == 1)
    {
        [cell.name setImage:[UIImage imageNamed:@"password_change"] forState:UIControlStateNormal];
    }else if (indexPath.row == 2)
    {
        [cell.name setImage:[UIImage imageNamed:@"contact"] forState:UIControlStateNormal];
    }else
    {
        [cell.name setImage:[UIImage imageNamed:@"switch"] forState:UIControlStateNormal];
    }
    // Configure the cell...
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.row) {
        case 0:
        {
            PersonInfoTableViewController *pvc = [[PersonInfoTableViewController alloc]init];
            [self.navigationController pushViewController:pvc animated:YES];
        }
            break;
        case 1:
        {
            EditViewController *change = [[EditViewController alloc]init];
            [self.navigationController pushViewController:change animated:YES];
            
        }
            break;
        case 2:
        {
            
        }
            break;
        case 3:
        {
            HGLoginController *login  = [[HGLoginController alloc]init];
            [HGUserDefaults setObject:@"" forKey:@"account"];
            [HGUserDefaults setObject:@"" forKey:@"passWord"];
            HGKeywindow.rootViewController = login;
        }
            break;
        default:
            break;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath

{
    return 44;
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
