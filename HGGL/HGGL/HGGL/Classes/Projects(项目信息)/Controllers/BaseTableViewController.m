//
//  BaseTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "BaseTableViewController.h"
#import "HGHttpTool.h"
#import "PBaseFrame.h"
#import "BaseTableViewCell.h"
#import "ConformViewController.h"
#import "ProjectList.h"
#import "HGWebViewController.h"
#import "TextFrame.h"
////#import "MBProgressHUD+Extend.h"
@interface BaseTableViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) PBaseFrame *BF;
//@property (nonatomic,copy) NSString *url;
@end

@implementation BaseTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"项目名称:",@"运行状态:",@"编号:",@"类型:",@"性质:",@"教室:",@"周期:",@"项目负责人:",@"课程负责人:",@"计划学员人数:",@"实际学员人数:",@"班主任:",@"团队确认单", nil];
    }
    return _arr;
}
-(PBaseFrame *)BF
{
    if (_BF == nil) {
        _BF = [[PBaseFrame alloc]init];
    }
    return _BF;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.BF.PList = self.PL;
    //NSLog(@"base%@",self.project_id);
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
    NSString *ID1 = @"cell1";
    if (indexPath.row == self.arr.count-1) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID1];
        for (UIView *view in cell.contentView. subviews) {
            [view removeFromSuperview];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:@"团队确认单" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(conform) forControlEvents:UIControlEventTouchUpInside];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        //but .backgroundColor = [UIColor redColor];
        [but setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        but.frame = CGRectMake(20, 10, HGScreenWidth - 20*2, 44);
        [cell addSubview:but];
        return cell;
    }else{
        
        BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [self.arr objectAtIndex:indexPath.row];
        cell.nameV = [self.BF.baseArr objectAtIndex:indexPath.row];
        
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.arr.count-1) {
        return 64;
    }else
    {
        NSNumber *num = [self.BF.frameArr objectAtIndex:indexPath.row];
        return num.floatValue>=(minH+2*CellHMargin)?num.floatValue:(minH+2*CellHMargin);
    }
}
-(void)conform
{
    HGWebViewController *wf = [[HGWebViewController alloc  ]init];
    wf.navigationItem.title = @"团队确认单";

    if ((self.PL.projectUrl_confirm_list.length == 0)||([self.PL.projectUrl_confirm_list isEqualToString:@""])) {
//        [SVProgressHUD showErrorWithStatus:@"无相应确认单"];
        [SVProgressHUD showErrorWithStatus:@"无相应确认单"];
    }else
    {
        NSString *url = [HGURL2 stringByAppendingString:self.PL.projectUrl_confirm_list];
        NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
        url = [url stringByAppendingString:[NSString stringWithFormat:@"&tokenval=%@",user_id]];
        wf.url = url;
        if (_butBlock) {
            _butBlock(wf);
        }
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
