//
//  TaskTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-17.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TaskTableViewController.h"
#import "Dinner.h"
#import "room.h"
#import "ClassRoom.h"
#import "Car.h"
#import "DinnerFrame.h"
#import "CarFrame.h"
#import "ClassRoomFrame.h"
#import "RoomFrame.h"
#import "BaseTableViewCell.h"
#import "TextFrame.h"
@interface TaskTableViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) NSArray *frameArr;
@property (nonatomic,strong) NSArray *baseArr;
@end

@implementation TaskTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"接待详情";
    if ([self.obj isKindOfClass:[Dinner class]]) {
        DinnerFrame *df = [[DinnerFrame alloc]init];
        self.arr = @[@"用餐时间",@"就餐类型",@"就餐形式",@"就餐人数",@"就餐餐厅",@"备注"];
        df.d = self.obj;
        self.frameArr = df.frameArr;
        self.baseArr = df.baseArr;
    }else if ([self.obj isKindOfClass:[Car class]])
    {
        CarFrame *cf = [[CarFrame alloc]init];
        cf.c = self.obj;
        self.arr = @[@"用车人姓名",@"用车人电话",@"出发时间",@"到达时间",@"等车地点",@"到达地点",@"人数",@"车辆名称",@"车牌号",@"司机姓名",@"司机电话",@"出库时间",@"归库时间"];
        self.frameArr = cf.frameArr;
        self.baseArr = cf.baseArr;
    }else if([self.obj isKindOfClass:[room class]])
    {
        RoomFrame *rf = [[RoomFrame alloc]init];
        rf.r = self.obj;
        self.arr = @[@"住宿人姓名",@"客户性别",@"客户职务",@"入住楼层",@"入住房间号",@"房间价格",@"额外成本",@"房间状态",@"客户类型"];
        self.baseArr = rf.baseArr;
        self.frameArr = rf.frameArr;
    }else if([self.obj isKindOfClass:[ClassRoom class]])
    {
        ClassRoomFrame *crf = [[ClassRoomFrame alloc]init    ];
        crf.cr = self.obj;
        self.arr = @[@"教室编号",@"教室用途",@"开始时间",@"结束时间",@"价格",@"备注"];
        self.baseArr = crf.baseArr;
        self.frameArr = crf.frameArr;
    }
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
    cell.nameV = [self.baseArr objectAtIndex:indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSNumber *num = [self.frameArr objectAtIndex:indexPath.row];
    return num.floatValue>=(minH+2*CellHMargin)?num.floatValue:(minH+2*CellHMargin);
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
