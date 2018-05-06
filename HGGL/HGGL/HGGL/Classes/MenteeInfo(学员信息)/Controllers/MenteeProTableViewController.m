//
//  MenteeProTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeProTableViewController.h"
#import "MPTableViewCell.h"
#import "HGHttpTool.h"
#import "ProjectInfoViewController.h"
#import "MenteeProject.h"
#import "TextFrame.h"
@interface MenteeProTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property  (nonatomic,copy) NSString *error;
@end


@implementation MenteeProTableViewController
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces = NO;
    //topView.backgroundColor = [UIColor redColor];
    NSString *url = [HGURL stringByAppendingString:@"Mentee/getMenteePro.do"];
    NSString *user_id = [HGUserDefaults objectForKey:HGUserID];
    [HGHttpTool POSTWithURL:url parameters:@{@"student_id":self.mentee_id} success:^(id responseObject) {
        NSArray *array = [NSArray array];
        array = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            //[SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            self.error = [responseObject objectForKey:@"message"];
        }else{
            
            for (NSDictionary *dict in array) {
                MenteeProject *MP = [MenteeProject MFWithDict:dict];
                [self.arr addObject:MP];
            }}
        //HGLog(@"student%d",self.arr.count);
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
    
}
-(void)showError
{
    if (self.error.length) {
        [SVProgressHUD showErrorWithStatus:self.error];
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    return self.arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MPTableViewCell *cell = [MPTableViewCell cellWithTabView:self.tableView];
    cell.MP = [self.arr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    MenteeProject *mp = [self.arr objectAtIndex:indexPath.row] ;
//    return (mp.cellH+CellHMargin*3)>=(2*minH+3*CellHMargin*3)?(mp.cellH+CellHMargin*3):(2*minH+CellHMargin*3);
    return 60;
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return  [[UIView alloc]init];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ProjectInfoViewController *pinfo = [[ProjectInfoViewController alloc]init];
    MenteeProject *model = [self.arr objectAtIndex:indexPath.row];
    pinfo.project_id = model.project_id;
    if (_PushBlock) {
        _PushBlock(pinfo);
    }
}
@end
