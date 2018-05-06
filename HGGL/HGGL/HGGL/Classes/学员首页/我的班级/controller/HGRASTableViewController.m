//
//  HGRASTableViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/6.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGRASTableViewController.h"
#import "HGRASModel.h"
#import "HGHttpTool.h"
#import "SVProgressHUD.h"
#import "HGRASTableViewCell.h"
#import "TextFrame.h"
@interface HGRASTableViewController ()
@property (nonatomic,strong) NSMutableArray *valueArr;
@property (nonatomic,strong) NSMutableArray *keyArr;
@property (nonatomic,strong) UIView *header;
@property (nonatomic,copy) NSString *fillType;
@property (nonatomic,strong) HGRASModel *model;
@property (nonatomic,weak) UIButton *selButton;
@end

@implementation HGRASTableViewController
-(NSMutableArray *)valueArr
{
    if (_valueArr == nil) {
        _valueArr = [NSMutableArray arrayWithArray:@[@"",@"",@"",@"",@"",@"",@"",@"",@"",@"",@""]];
    }
    return _valueArr;
}
-(NSMutableArray *)keyArr
{
    
    _keyArr = [NSMutableArray arrayWithArray:@[@"车次/班次：",[self.fillType isEqualToString:@"1"]?@"接站地点：":@"送站地点：",@"日期：",@"时间：",@"接待人：",@"接待人电话：",@"车辆：",@"车牌号：",@"司机：",@"司机电话：",@"备注："]];
    
    return _keyArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"查看接送站信息"；
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.fillType = @"1";
    [self loadData];
    
}

-(void)loadData
{
    NSString *url = [HGURL stringByAppendingString:@"Project/getBaseProject.do"];
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":[HGUserDefaults objectForKey:HGUserID],@"project_id":[HGUserDefaults objectForKey:HGProjectID],@"fillType":self.fillType} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        
        //        NSArray *array = [NSArray array];
        [self.valueArr removeAllObjects];
        NSDictionary *dict = [responseObject objectForKey:@"data"];
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
            
            self.model = [HGRASModel initWithDict:dict];
            [self.valueArr addObjectsFromArray:self.model.arr];
             [self.tableView reloadData];
        }
       
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        HGLog(@"%@",error);
    }];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return self.keyArr.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HGRASTableViewCell *cell = [HGRASTableViewCell cellWithTabView:tableView];
    cell.name = self.keyArr[indexPath.row];
    cell.nameV = self.valueArr[indexPath.row];
    
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat mar = 5;
    CGFloat Hmar = 10;
    CGFloat minWidth = [TextFrame frameOfText:@"车次/班次：" With:[UIFont systemFontOfSize:HGFont] AndHeigh:100].width;
    CGFloat minHeight = [TextFrame frameOfText:self.keyArr[indexPath.row] With:[UIFont systemFontOfSize:HGFont] Andwidth:minWidth].height+2*Hmar;
    minHeight = ((minHeight>minH+2*Hmar)?minHeight:minH+2*Hmar);
    CGFloat cellH = [TextFrame frameOfText:self.valueArr[indexPath.row] With:[UIFont systemFontOfSize:HGFont] Andwidth:HGScreenWidth-minWidth-2*CellWMargin-mar].height;
    
    return ((cellH>minHeight)?cellH:minHeight);
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (!self.header) {
        UIView *header = [[UIView alloc]init];
        header.backgroundColor = [UIColor whiteColor];
        self.header = header;
        
        CGFloat buttonW = 80;
        CGFloat buttonH = 30;
        CGFloat Wmar = 20;
        CGFloat Hmar = 7;
        UIButton *RButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [RButton setTitle:@"接站" forState:UIControlStateNormal];
        [RButton setTitleColor:HGMainColor forState:UIControlStateNormal];
        [RButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        RButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        RButton.titleLabel.font = ZKRButFont;
//        [RButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        RButton.tag = 500;
        [RButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:RButton];
        [RButton setBackgroundColor:HGMainColor];
        RButton.layer.masksToBounds = YES;
        RButton.layer.cornerRadius = 5;
        RButton.selected = YES;
        self.selButton = RButton;
        RButton.frame = CGRectMake(HGScreenWidth/2-Wmar/2-buttonW, Hmar, buttonW, buttonH);
        
        
        UIButton *SButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [SButton setTitle:@"送站" forState:UIControlStateNormal];
        [SButton setTitleColor:HGMainColor forState:UIControlStateNormal];
        [SButton setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
        SButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        SButton.titleLabel.font = ZKRButFont;
//        [SButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        SButton.tag = 501;
        [SButton addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
        [header addSubview:SButton];
        [SButton setBackgroundColor:HGGrayColor];
        SButton.layer.masksToBounds = YES;
        SButton.layer.cornerRadius = 5;
        SButton.selected = NO;
        SButton.frame = CGRectMake(HGScreenWidth/2+Wmar/2, Hmar, buttonW, buttonH);
        
        UIView *grayLine = [[UIView alloc]init];
        grayLine.backgroundColor = HGGrayColor;
        grayLine.frame = CGRectMake(0,44 , HGScreenWidth, 10);
        [header addSubview:grayLine];
        
        
        
    }
    return self.header;
    
}
-(void)clickBut:(UIButton *)button
{
    if ([button isEqual:self.selButton]) {
        return;
    }
    button.selected = YES;
    button.backgroundColor = HGMainColor;
    self.selButton.selected = NO;
    self.selButton.backgroundColor = HGGrayColor;
    self.selButton = button;
    if (button.tag == 500) {
        self.fillType = @"1";
    }else
    {
        self.fillType = @"2";
    }
    
    [self loadData];
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 54;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section

{
    return .1;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [[UIView alloc]init];
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
