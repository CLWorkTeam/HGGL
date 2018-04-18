//
//  CurrPopTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-10.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrPopTableViewController.h"
#import "HGHttpTool.h"
#import "ProjectList.h"
//#import "MBProgressHUD+Extend.h"
#import "ProjectInfoViewController.h"
@interface CurrPopTableViewController ()
@property (nonatomic,strong) NSMutableArray *array;
@end
@implementation CurrPopTableViewController
-(NSMutableArray *)array
{
    if (_array == nil) {
        _array = [NSMutableArray array];
        
    }
    return _array;
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    self.tableView.backgroundColor = [UIColor whiteColor];
     NSString *url = [HGURL stringByAppendingString:@"Project/getCroomProjectList.do"];
    //HGLog(@"%@-----%@",self.course_classroom,self.current_date);
    [HGHttpTool POSTWithURL:url parameters:@{@"course_classroom":self.course_classroom,@"current_date":self.current_date} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        HGLog(@"%@",array);
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            for (NSDictionary *dict in array) {
                
                ProjectList *pro = [ProjectList initWithDict:dict];
                [self.array  addObject:pro];
            }
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *header = [[UIView alloc]init];
    header.backgroundColor = [UIColor lightGrayColor];
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = header.bounds;
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.frame = CGRectMake(0, 0, self.tableView.bounds.size.width , 44);
    lab.font = [UIFont fontWithName:@"Helvetica-Bold" size:14];
    lab.text = [NSString stringWithFormat:@"%@教室当前运行项目:",self.course_classroom];
    [header addSubview:lab];
    return header;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 44;
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
    //HGLog(@"........%d",self.array.count);
    return self.array.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    ProjectList *PL = [self.array objectAtIndex:indexPath.row];
    //HGLog(@"name%@",PL.project_name);
    HGLog(@"POP%@",PL.project_name);
    cell.textLabel.text = PL.project_name;
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectInfoViewController *vc = [[ProjectInfoViewController alloc]init];
    vc.PL = [self.array objectAtIndex:indexPath.row];
    vc.project_id = vc.PL.project_id;
    if (_currPPopBlock) {
        _currPPopBlock(vc);
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
