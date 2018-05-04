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
#import "HGProjectBaseModel.h"
#import "HGPBRemarkModel.h"
////#import "MBProgressHUD+Extend.h"
@interface BaseTableViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) HGProjectBaseModel *model;
@end

@implementation BaseTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"项目编号:",@"项目名称:",@"项目周期:",@"报名期限:",@"项目天数:",@"学员人数:",@"收费标准:",@"教室:",@"项目类型:",@"承训部门:",@"学员层次:",@"项目委托单位:",@"委托联系人:",@"委托人电话:",@"项目负责人:",@"负责人电话:",@"课程负责人:",@"班主任:",@"服务备注:",@"团队确认单", nil];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    UIView *whiteLine = [[UIView alloc]init];
    whiteLine.backgroundColor = [UIColor whiteColor];
    whiteLine.height = 20;
    self.tableView.tableHeaderView = whiteLine;
    
    [self loadData];
}
-(void)loadData
{
    NSString *url = [HGURL stringByAppendingString:@"Project/getBaseProject.do"];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [HGHttpTool POSTWithURL:url parameters:@{@"project_id":self.project_id} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
//        NSArray *array = [NSArray array];
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            
            self.model = [HGProjectBaseModel initWithDict:dict];
        }
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    if (section == 0) {
        return self.model.contentArray.count;
    }else if (section == 1)
    {
        return 0;
    }else
    {
        return 1;
    }
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *ID1 = @"cell1";
    if (indexPath.section == 2) {
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID1];
        for (UIView *view in cell.contentView. subviews) {
            [view removeFromSuperview];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setTitle:@"团队确认单" forState:UIControlStateNormal];
        [but addTarget:self action:@selector(conform) forControlEvents:UIControlEventTouchUpInside];
        but.titleLabel.textAlignment = NSTextAlignmentCenter;
        but .backgroundColor = HGMainColor;
        but.layer.masksToBounds = YES;
        but.layer.cornerRadius = 5;
//        [but setBackgroundImage:[UIImage resizableImageWithName:@"red_btn_normal"] forState:UIControlStateNormal];
        
        but.frame = CGRectMake(20, 10, HGScreenWidth - 20*2, 44);
        [cell addSubview:but];
        return cell;
    }else {
        
        BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [self.arr objectAtIndex:indexPath.row];
        cell.nameV = [self.model.contentArray objectAtIndex:indexPath.row];
        
        return cell;
    }

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.arr.count-1) {
        return 64;
    }else
    {
        return 30;
    }
}
-(void)conform
{
    HGWebViewController *wf = [[HGWebViewController alloc  ]init];
    wf.navigationItem.title = @"团队确认单";

    if ((self.model.projectUrl_confirm_list.length == 0)||([self.model.projectUrl_confirm_list isEqualToString:@""])) {
        [SVProgressHUD showErrorWithStatus:@"无相应确认单"];
    }else
    {
        NSString *url = [HGURL2 stringByAppendingString:self.model.projectUrl_confirm_list];
        NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
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
