//
//  CurrentTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrentTableViewController.h"
#import "HGHttpTool.h"
#import "Currse.h"
#import "CurrseList.h"
//#import "MBProgressHUD+Extend.h"
#import "CurrTableViewCell.h"
#import "BaseTableViewCell.h"
#import "CurrHeader.h"
@interface CurrentTableViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *currArr;
@property (nonatomic,strong) NSMutableArray *otherArr;
@property (nonatomic,assign) BOOL isRefreshing;
@end

@implementation CurrentTableViewController
-(NSMutableArray *)currArr
{
    if (_currArr == nil) {
        _currArr = [NSMutableArray array];
        
    }
    return _currArr;
}
-(NSMutableArray *)otherArr
{
    if (_otherArr == nil) {
        _otherArr = [NSMutableArray array];
        
    }
    return _otherArr;
}
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray arrayWithObjects:self.currArr,self.otherArr, nil];
    }
    return _arr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}
-(void)postWith:(NSString *)date
{
//    if (_isRefreshing) {
//        return;
//    }
//    _isRefreshing = YES;
    
//    [self.tableView reloadData];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *url = [HGURL stringByAppendingString:@"Course/getCourseList.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"course_date":date} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        NSArray *array = [NSArray array];
        [self.currArr removeAllObjects];
        [self.otherArr removeAllObjects];
//        _isRefreshing = NO;
        array = [responseObject objectForKey:@"data"];
         HGLog(@"-----%@",array);
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            for (NSDictionary *dict in array) {
                Currse *cu = [Currse initWithDict:dict];
                if (cu.course_style.intValue == -1) {
                    for (CurrseList *cl in cu.morningList) {
                        [self.otherArr addObject:cl];
                    }
                    
                    for (CurrseList *cl in cu.afternoonList) {
                        [self.otherArr addObject:cl];
                    }
                    for (CurrseList *cl in cu.nightList) {
                        [self.otherArr addObject:cl];
                    }
                }else{
                    [self.currArr addObject:cu];
                }
                
            }
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
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return  42;
    
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        CurrHeader *header= [[CurrHeader alloc] init];
        return header;
    }
    return nil;
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
    
    
    return self.currArr.count;
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID1 = @"cell1";
    
    
        
        CurrTableViewCell *cell = [CurrTableViewCell cellWithTabView:self.tableView];
        cell.cu = [self.currArr objectAtIndex:indexPath.row];
        cell.current_date = self.current_date;
        __weak typeof (self) weekSelf = self;
        cell.currCellClick = ^(id vc)
        {
            if (weekSelf.currentBlock) {
                weekSelf.currentBlock(vc);
            }
        };
        cell.currButClick = ^(id vc )
        {
            if (weekSelf.currentBlock) {
                weekSelf. currentBlock(vc);
            }
        };
        return cell;
    

 
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        Currse *cu = [self.currArr objectAtIndex:indexPath.row];
        NSInteger i = cu.course_style .integerValue;
        return i*(45+2*HGSpace);
    
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
