//
//  PersonInfoTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-12.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "PersonInfoTableViewController.h"
#import "User.h"
#import "Account.h"
#import "BaseTableViewCell.h"
#import "MJExtension.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
#import "TextFrame.h"
#define ZKRAccountFile [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"account.data"]
@interface PersonInfoTableViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSMutableArray *array;
@property (nonatomic,strong) Account *acc;
@property (nonatomic,strong) User *U;
@end

@implementation PersonInfoTableViewController
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@[@"姓名:",@"性别:",@"身份证:",@"职务:"],@[@"手机:",@"电话:",@"邮箱:",@"备注:"], nil];
        
    }
    return _arr;
}
//设置NavItemBtn
-(void)setupLeftNavItem{
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
}
//返回前一页
-(void)back
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
//    User *account = [NSKeyedUnarchiver unarchiveObjectWithFile:ZKRAccountFile];
//    Account  *acc = [[Account alloc]init];
//    acc.user = account;
//    self.acc = acc;
//    self.array = acc.baseArr;
    self.navigationItem.title = @"个人信息修改";
    [self setupLeftNavItem];
    
    NSString *account = [HGUserDefaults stringForKey:@"account1"];
    NSString *pw = [HGUserDefaults stringForKey:@"passWord1"];
    [self loginWith:account and:pw];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)loginWith:(NSString *)account and:(NSString *)pw
{
    NSString *url = [HGURL stringByAppendingString:@"User/Login.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:url parameters:@{@"account":account,@"password":pw,@"tokenval":user_id} success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"-1"]) {
            [SVProgressHUD showErrorWithStatus:@"账号或者密码错误"];
        }else{
            NSDictionary *dict = [responseObject objectForKey:@"data"];

            User *user = [User initWithDict:dict];
            self.U = user;
            Account  *acc = [[Account alloc]init];
            acc.user = user;
            self.acc = acc;
            self.array = acc.baseArr;
            //[NSKeyedArchiver archiveRootObject:user toFile:ZKRAccountFile];
            [self.tableView reloadData];
        }
        
        
        
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络连接设置"];
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return 10;
    }
    return 0;
    
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return self.arr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
     NSArray *arr = [self.arr objectAtIndex:section];
    return arr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
    cell.name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    //cell.selectionStyle = UITableViewCellSelectionStyleNone;
    // Configure the cell...
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = [[self.acc.frameArr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    CGFloat H = num.floatValue;
//    HGLog(@"====%f",H);
    return H>=(minH+CellHMargin+CellHMargin)?H:(minH+2*CellHMargin);
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *name = [[self.arr objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    NSString *nameV = [[self.array objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if (indexPath.section == 0&&indexPath.row == 1) {
        UIAlertView *alter1 = [[UIAlertView alloc]initWithTitle:name message:nil delegate:self cancelButtonTitle:@"男" otherButtonTitles:@"女", nil];
        alter1.alertViewStyle = UIAlertViewStyleDefault;
        [alter1 textFieldAtIndex:0].text = nameV;
        alter1.delegate = self;
        alter1.tag = 100*indexPath.section + indexPath.row;
        [alter1 show];
    }else
    {
        UIAlertView *alter = [[UIAlertView alloc]initWithTitle:name message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alter textFieldAtIndex:0].text = nameV;
        alter.delegate = self;
        alter.tag = 100*indexPath.section + indexPath.row;
        [alter show];
    }


    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.alertViewStyle == UIAlertViewStyleDefault) {
        if (buttonIndex == 0) {
            self.U.user_sex = @"男";
        }else
        {
            self.U.user_sex = @"女";
        }
    }else{
        if (buttonIndex == 0) return;
        NSInteger section = alertView.tag/100;
        NSInteger row = alertView.tag%100;
        NSString *str = [alertView textFieldAtIndex:0].text;
        //NSString *mess = alertView.message;
        //NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
        //    NSMutableArray *a = [self.array objectAtIndex:section];
        //    [a replaceObjectAtIndex:row withObject:str];
        
        //    NSDictionary *dict = [self.U keyValues];
        //    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
        //    for (id key in dict) {
        //
        //        [dict1 setObject:[dict objectForKey:key] forKey:key];
        //    }
        if (section == 0&&row == 0) {
            self.U.user_name = str;
        }else if (section == 0&&row == 2)
        {
            self.U.user_idCard = str;
        }else if (section == 0&&row==3)
        {
            self.U.user_duty = str;
        }else if (section == 1&&row == 0)
        {
            self.U.user_tel = str;
        }else if (section == 1&&row==1)
        {
            self.U.user_phone = str;
        }else if (section == 1&&row == 2)
        {
            self.U.user_email = str;
        }else if (section == 1&&row == 3)
        {
            self.U.user_note = str;
        }
    
    }
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSString *url = [HGURL stringByAppendingString:@"User/infoChange.do"];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_duty":self.U.user_duty,@"user_email":self.U.user_email,@"user_id":self.U.user_id,@"user_idCard":self.U.user_idCard,@"user_name":self.U.user_name,@"user_note":self.U.user_note,@"user_phone":self.U.user_phone,@"user_sex":self.U.user_sex,@"user_tel":self.U.user_tel,@"tokenval":user_id} success:^(id responseObject) {
         NSString *status = [responseObject objectForKey:@"status"];
        
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD  showSuccessWithStatus:[responseObject objectForKey:@"message"]];
        }else if ([status isEqualToString:@"-1"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else if ([status isEqualToString:@"-2"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
        Account *acc = [[Account alloc]init];
        acc.user = self.U;
        self.acc = acc;
        self.array = acc.baseArr;
        //[NSKeyedArchiver archiveRootObject:user toFile:ZKRAccountFile];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
        [SVProgressHUD showErrorWithStatus:@"请检查网络连接设置"];
    }];
    
    Account *acc = [[Account alloc]init];
    acc.user = self.U;
    self.acc = acc;
    self.array = acc.baseArr;
    //[NSKeyedArchiver archiveRootObject:user toFile:ZKRAccountFile];
    [self.tableView reloadData];
   
    
    
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
