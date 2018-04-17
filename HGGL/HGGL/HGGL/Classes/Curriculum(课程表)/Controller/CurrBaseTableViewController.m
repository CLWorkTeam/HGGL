//
//  CurrBaseTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-7.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrBaseTableViewController.h"
#import "CurrseList.h"
#import "CurrFrame.h"
#import "BaseTableViewCell.h"
#import "Currse.h"
#import "TeacViewController.h"
@interface CurrBaseTableViewController ()
@property (nonatomic,strong) CurrFrame *CF;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,copy)NSString *teacher_id;
@end

@implementation CurrBaseTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"项目名称:",@"课程主题:",@"教室:",@"授课教师:",@"是否接送:",@"上课时间:",@"教师简介:",@"课程简介:",@"备注:", nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"课程详情";
    CurrFrame *CF = [[CurrFrame alloc]init];
    CF.course_classroom = self.course_classroom;
    self.teacher_id = self.CL.teacher_id;
    CF.CL = self.CL;
    self.CF = CF;
    self.array = CF.baseArr;
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
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
    cell.name = [self.arr objectAtIndex:indexPath.row];
    cell.nameV = [self.array objectAtIndex:indexPath.row];
    //HGLog(@"(%@)----%d",self.teacher_id,self.teacher_id.length);
    if ((indexPath.row == 3)&&!(self.teacher_id.length == 0)) {
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:@"教师详情" forState:UIControlStateNormal];
        but.titleLabel.font = [UIFont systemFontOfSize:10];
        [but setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        
        but.bounds = CGRectMake(0, 0, 50, 40);
        but.center = CGPointMake(cell.bounds.size.width/2, cell.bounds.size.height/2);
        [cell addSubview:but];
        return cell;
        
    }else
    {
        return cell;
    }
    
    // Configure the cell...
    
   
}

-(void)clickBut:(UIButton *)but
{
    TeacViewController  *vc = [[TeacViewController alloc]init];
    //HGLog(@"--id%@",self.teacher_id);
    vc.teacher_id = self.teacher_id;
    [self.navigationController pushViewController:vc animated:YES];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = [self.CF.frameArr objectAtIndex:indexPath.row];
    CGFloat H = num .floatValue;
    //HGLog(@"哈哈哈啊哈哈哈%f",H);
    return H;
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
