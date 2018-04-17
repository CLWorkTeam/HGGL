//
//  ResearchDetailTableViewController.m
//  SYDX_2
//
//  Created by mac on 15-8-15.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ResearchDetailTableViewController.h"
#import "ResearchList.h"
#import "ResearchFrame.h"
#import "BaseTableViewCell.h"
#import "ResearchCommon.h"
#import "CurrImageView.h"
#import "ZKRCover.h"
#import "Report.h"
#import "HGHttpTool.h"
////#import "MBProgressHUD+Extend.h"
#import "DistNoAndLevel.h"
#import "FinalApprove.h"
#import "SuggestReturn.h"
#import "TextFrame.h"
#define margin 20
#define H 30
#define W 100
@interface ResearchDetailTableViewController ()<UIAlertViewDelegate>
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) ResearchFrame *RF;
@property (nonatomic,strong) NSArray *array;
@property (nonatomic,assign) NSInteger line;
@property (nonatomic,strong) NSMutableArray *operationArr;

@end

@implementation ResearchDetailTableViewController
-(NSArray *)array
{
    if (_array == nil) {
        _array = [NSArray arrayWithObjects:@"课程名称",@"课题类型",@"负责人",@"课题状态",@"课题类别",@"总经费",@"已报销经费",@"未报销经费", nil];
    }
    return _array;
}
-(NSMutableArray *)operationArr
{
    if (_operationArr == nil) {
        _operationArr = [NSMutableArray array];
    }
    return _operationArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title =@"科研详情";
    [self reflash];
//    NSString *url = [HGURL stringByAppendingString:@"Research/showResearchInfo.do"];
//    NSDictionary *parameters = @{@"research_id":self.research_id};
//    [HGHttpTool POSTWithURL:url parameters:parameters success:^(id responseObject) {
//        NSString *status = [responseObject objectForKey:@"status"];
//        if ([status isEqualToString:@"1"] ) {
//            NSDictionary *dict = [responseObject objectForKey:@"data"];
//            ResearchList *RL = [ResearchList initWithDict:dict];
//            self.RL = RL;
//            [self.tableView reloadData];
//        }else
//        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
//        }
//    } failure:^(NSError *error) {
//        HGLog(@"%@",error);
//    }];
//    ResearchFrame *RF = [[ResearchFrame alloc]init];
//    RF.RL = self.RL;
//    self.RF = RF;
//    self.arr = RF.baseArr;
//    if (self.RL.research_control.count%2)
//    {
//        self.line = self.RL.research_control.count/2 +1;
//    }else
//    {
//        self.line = self.RL.research_control.count/2;
//    }
//    for (NSString *str in self.RL.research_control) {
//        switch ([str integerValue]) {
//            case Operation_Report:
//            {
//                [self.operationArr addObject:@"申报"];
//            }
//                
//                break;
//            case Operation_Cancel:
//            {
//                [self.operationArr addObject:@"取消申报"];
//                
//            }
//                break;
//            case Operation_CommitteeApprove:
//            {
//                [self.operationArr addObject:@"学术委员会审批"];
//            }
//                break;
//            case Operation_DepartmentApprove:
//            {
//                [self.operationArr addObject:@"科室初审"];
//            }
//                break;
//            case Operation_DistNOAndLevel:
//            {
//                [self.operationArr addObject:@"分配等级编号"];
//            }
//                break;
//            case Operation_FinalApprove:
//            {
//                [self.operationArr addObject:@"终期评审"];
//            }
//                break;
//            case Operation_FinalReport:
//            {
//                [self.operationArr addObject:@"终期申报"];
//            }
//                break;
//            case Operation_MiddleReport:
//            {
//                [self.operationArr addObject:@"中期申报"];
//            }
//                break;
//            case Operation_Over:
//            {
//                [self.operationArr addObject:@"归档"];
//            }
//                break;
//            case Operation_ReviewApprove:
//            {
//                [self.operationArr addObject:@"终验评审意见返现"];
//            }
//                break;
//            case Operation_UniversityApprove:
//            {
//                [self.operationArr addObject:@"校党委批复"];
//            }
//                break;
//            default:
//                break;
//        }
//    }
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)reflash
{
    HGLog(@"%@",self.research_id);
    NSString *url = [HGURL stringByAppendingString:@"Research/showResearchInfo.do"];
     NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSDictionary *parameters = @{@"research_id":self.research_id,@"tokenval":user_id};
    
    [HGHttpTool POSTWithURL:url parameters:parameters success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"] ) {
            NSDictionary *dict = [responseObject objectForKey:@"data"];
            ResearchList *RL = [ResearchList initWithDict:dict];
            self.RL = RL;
            ResearchFrame *RF = [[ResearchFrame alloc]init];
            RF.RL = self.RL;
            self.RF = RF;
            self.arr = RF.baseArr;
            [self.operationArr removeAllObjects];
            if (self.RL.research_control.count%2)
            {
                self.line = self.RL.research_control.count/2 +1;
            }else
            {
                self.line = self.RL.research_control.count/2;
            }
            for (NSString *str in self.RL.research_control) {
                switch ([str integerValue]) {
                    case Operation_Report:
                    {
                        [self.operationArr addObject:@"申报"];
                    }
                        
                        break;
                    case Operation_Cancel:
                    {
                        [self.operationArr addObject:@"取消申报"];
                        
                    }
                        break;
                    case Operation_CommitteeApprove:
                    {
                        [self.operationArr addObject:@"学术委员会评审"];
                    }
                        break;
                    case Operation_DepartmentApprove:
                    {
                        [self.operationArr addObject:@"科室初审"];
                    }
                        break;
                    case Operation_DistNOAndLevel:
                    {
                        [self.operationArr addObject:@"分配等级编号"];
                    }
                        break;
                    case Operation_FinalApprove:
                    {
                        [self.operationArr addObject:@"终期评审"];
                    }
                        break;
                    case Operation_FinalReport:
                    {
                        [self.operationArr addObject:@"终期申报"];
                    }
                        break;
                    case Operation_MiddleReport:
                    {
                        [self.operationArr addObject:@"中期申报"];
                    }
                        break;
                    case Operation_Over:
                    {
                        [self.operationArr addObject:@"归档"];
                    }
                        break;
                    case Operation_ReviewApprove:
                    {
                        [self.operationArr addObject:@"终验评审意见返现"];
                    }
                        break;
                    case Operation_UniversityApprove:
                    {
                        [self.operationArr addObject:@"校党委批复"];
                    }
                        break;
                    default:
                        break;
                }
            }
            [self.tableView reloadData];
        }else
        {
//            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
}
-(void)reloadD
{
    NSString *url = [HGURL stringByAppendingString:@"Research/getResearchList.do"];
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:url parameters:@{@"user_id":@"1",@"tokenval":user_id} success:^(id responseObject) {
        
       
        NSString *status = [responseObject objectForKey:@"status"];
        if([status isEqualToString:@"0"])
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }else{
           
            HGLog(@"%@",[responseObject objectForKey:@"data"]);
//                NSDictionary *dict = [responseObject objectForKey:@"data"];
//                ResearchList *RL = [ResearchList initWithDict:dict];
//                self.RL = RL;
//                [self.tableView reloadData];
        }
    } failure:^(NSError *error) {
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return self.arr.count+1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    if (indexPath.row<self.arr.count) {
         NSNumber *num = [self.RF.frameArr objectAtIndex:indexPath.row];
        return num.floatValue>=(minH+2*CellHMargin)?num.floatValue:(minH+2*CellHMargin);
    }else
    {
        if (self.line) {
            return self.line*(margin+H)+margin;
        }else
        {
            return (minH+2*CellHMargin);
        }
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row <self.arr.count) {
        BaseTableViewCell *cell = [BaseTableViewCell cellWithTabView:self.tableView];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.name = [self.array objectAtIndex:indexPath.row];
        cell.nameV = [self.arr objectAtIndex:indexPath.row];
        return cell;
    }else
    {
        static NSString *ID1 = @"cell1";
        UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID1];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *view in cell.contentView. subviews) {
            [view removeFromSuperview];
        }
        
        for (int i = 0; i<self.operationArr.count; i++) {
            UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom ];
            but.tag = i;
            but.backgroundColor = [UIColor redColor];
            [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
            but.titleLabel.textAlignment = NSTextAlignmentCenter;
            [but setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            but.titleLabel.font = [UIFont systemFontOfSize:14];
            [but setTitle:[self.operationArr objectAtIndex:i] forState:UIControlStateNormal];
            if (i%2 == 0) {
                but.frame = CGRectMake(HGScreenWidth/2-margin/2-W, margin+(margin+H)*(i/2), W, H);
                
            }else if (i%2 == 1) {
                but.frame = CGRectMake(HGScreenWidth/2+margin/2, margin+(margin+H)*(i/2), W, H);
            }
            [cell.contentView addSubview:but];
        }
        return cell;
        
    }

    
    
}

-(void)clickBut:(UIButton *)but
{
    but.selected = !but.selected;
    HGLog(@"but---%@",but.titleLabel.text);
    if ([but.titleLabel.text isEqualToString:@"申报"]) {
        if (but.selected) {
            ZKRCover *cover = [ZKRCover show];
            //NSLog(@"%@",cover.subviews);
            cover.dimBackGround = YES;
            cover.ZKRCoverDismiss = ^(){
                
                [CurrImageView  dismiss];
                but.selected = NO;
                
            };
            CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-280/2, 84, 280, 175)];
            Report *report = [[Report alloc]init];
            __weak typeof (self) weekSelf = self;
            report.sureBlock = ^()
            {
                [weekSelf reflash];
            };
            [self reflash];
            report.research_name = self.RL.research_name;
            report.research_id = self.RL.research_id;
            curr.contentView = report;
            [HGKeywindow addSubview:curr];
        }else
        {
            [CurrImageView   dismiss];
        }
            
        
        
    }else if([but.titleLabel.text isEqualToString:@"取消申报"])
    {
        NSString *url = [HGURL stringByAppendingString:@"Research/doCancel.do"];
        NSDictionary *dict = @{@"research_id":self.RL.research_id};
        [self postWith:url dict:dict];
    }else if([but.titleLabel.text isEqualToString:@"学术委员会评审"])
    {
        UIAlertView *alter1 = [[UIAlertView alloc]initWithTitle:but.titleLabel.text message:nil delegate:self cancelButtonTitle:@"不同意" otherButtonTitles:@"同意", nil];
        alter1.alertViewStyle = UIAlertViewStyleDefault;
        alter1.delegate = self;
        alter1.tag = but.tag *100;
        [alter1 show];

    }else if([but.titleLabel.text isEqualToString:@"科室初审"])
    {
        UIAlertView *alter1 = [[UIAlertView alloc]initWithTitle:but.titleLabel.text message:nil delegate:self cancelButtonTitle:@"不同意" otherButtonTitles:@"同意", nil];
        alter1.alertViewStyle = UIAlertViewStyleDefault;
        alter1.delegate = self;
        alter1.tag = but.tag *100;
        [alter1 show];
        
    }else if([but.titleLabel.text isEqualToString:@"分配等级编号"])
    {
        if (but.selected) {
            ZKRCover *cover = [ZKRCover show];
            //NSLog(@"%@",cover.subviews);
            cover.dimBackGround = YES;
            cover.ZKRCoverDismiss = ^(){
                
                [CurrImageView  dismiss];
                but.selected = NO;
                
            };
            CurrImageView *curr = [CurrImageView showInRect:CGRectMake(HGScreenWidth/2-280/2, 84, 280, 160)];
            DistNoAndLevel *NL = [[DistNoAndLevel alloc]init];
            __weak typeof (self) weekSelf = self;
            NL.sureBlock = ^()
            {
                [weekSelf reflash];
            };
            [self reflash];
            NL.research_id = self.RL.research_id;
            curr.contentView = NL;
            [HGKeywindow addSubview:curr];
        }else
        {
            [CurrImageView dismiss];
        }
        
    }else if([but.titleLabel.text isEqualToString:@"终期评审"])
    {
        
        if (but.selected) {
            ZKRCover *cover = [ZKRCover show];
            //NSLog(@"%@",cover.subviews);
            cover.dimBackGround = YES;
            cover.ZKRCoverDismiss = ^(){
                
                [CurrImageView  dismiss];
                but.selected = NO;
                
            };
            CurrImageView *curr = [CurrImageView showInRect:CGRectMake(0, 64, HGScreenWidth, 235)];
            FinalApprove *report = [[FinalApprove alloc]init];
            report.editEnable = YES;
            [self reflash];
            
            report.research_id = self.RL.research_id;
            curr.contentView = report;
            [HGKeywindow addSubview:curr];
        }else
        {
            [CurrImageView   dismiss];
            
        }
    }else if([but.titleLabel.text isEqualToString:@"终期申报"])
    {
        NSString *url = [HGURL stringByAppendingString:@"Research/doFinalReport.do"];
        NSDictionary *dict = @{@"research_id":self.RL.research_id};
        [self postWith:url dict:dict];
        
    }else if([but.titleLabel.text isEqualToString:@"中期申报"])
    {
        NSString *url = [HGURL stringByAppendingString:@"Research/doMiddleReport.do"];
        NSDictionary *dict = @{@"research_id":self.RL.research_id};
        [self postWith:url dict:dict];
    }else if([but.titleLabel.text isEqualToString:@"归档"])
    {
        UIAlertView *alter1 = [[UIAlertView alloc]initWithTitle:but.titleLabel.text message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alter1.alertViewStyle = UIAlertViewStyleDefault;
        alter1.delegate = self;
        alter1.tag = but.tag *100;
        [alter1 show];
        
    }else if([but.titleLabel.text isEqualToString:@"终验评审意见返现"])
    {

        if (but.selected) {
            ZKRCover *cover = [ZKRCover show];
            //NSLog(@"%@",cover.subviews);
            cover.dimBackGround = YES;
            cover.ZKRCoverDismiss = ^(){
                
                [CurrImageView  dismiss];
                but.selected = NO;
                
                
            };
            CurrImageView *curr = [CurrImageView showInRect:CGRectMake(0, 64, HGScreenWidth, 265)];
            FinalApprove *report = [[FinalApprove alloc]init];
            curr.contentView = report;
            NSString *url = [HGURL stringByAppendingString:@"Research/reviewApprove.do"];
            NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
            [HGHttpTool POSTWithURL:url parameters:@{@"research_id":self.research_id,@"tokenval":user_id} success:^(id responseObject) {
                NSString *status = [responseObject objectForKey:@"status"];
                if ([status isEqualToString:@"1"]) {
                    NSDictionary *dict = [responseObject objectForKey:@"data"];
                    HGLog(@"%@",dict);
                    SuggestReturn *SR = [SuggestReturn initWithDict:dict];
                    report.SR = SR;
                    report.editEnable = NO;
                }
            } failure:^(NSError *error) {
                HGLog(@"%@",error);
            }];

            [HGKeywindow addSubview:curr];
        }else
        {
            [CurrImageView   dismiss];
            
        }
        



                
                
                


    }else if([but.titleLabel.text isEqualToString:@"校党委批复"])
    {
        UIAlertView *alter1 = [[UIAlertView alloc]initWithTitle:but.titleLabel.text message:nil delegate:self cancelButtonTitle:@"不同意" otherButtonTitles:@"同意", nil];
        alter1.alertViewStyle = UIAlertViewStyleDefault;
        alter1.delegate = self;
        alter1.tag = but.tag *100;
        [alter1 show];
    }
    
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if ([alertView.title isEqualToString:@"学术委员会评审"]) {
        if (buttonIndex == 0) {
            
            NSString *url = [HGURL stringByAppendingString:@"Research/doUniversityApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"0"};
            [self postWith:url dict:dict];
        }else
        {
            NSString *url = [HGURL stringByAppendingString:@"Research/doUniversityApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"1"};
            [self postWith:url dict:dict];
        }
    }else if ([alertView.title isEqualToString:@"科室初审"])
    {
        if (buttonIndex == 0) {
            
            NSString *url = [HGURL stringByAppendingString:@"Research/doDepartmentApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"0"};
            [self postWith:url dict:dict];
        }else
        {
            NSString *url = [HGURL stringByAppendingString:@"Research/doDepartmentApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"1"};
            [self postWith:url dict:dict];
        }
    }else if ([alertView.title isEqualToString:@"归档"])
    {
        if (buttonIndex == 0) {
            

        }else
        {
            NSString *url = [HGURL stringByAppendingString:@"Research/doOver.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id};
            [self postWith:url dict:dict];
        }
    }else if ([alertView.title isEqualToString:@"校党委批复"])
    {
        if (buttonIndex == 0) {
            
            NSString *url = [HGURL stringByAppendingString:@"Research/doCommitteeApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"0"};
            [self postWith:url dict:dict];
        }else
        {
            NSString *url = [HGURL stringByAppendingString:@"Research/doCommitteeApprove.do"];
            NSDictionary *dict = @{@"research_id":self.RL.research_id,@"isAgree":@"1"};
            [self postWith:url dict:dict];
        }
    }

}
-(void)postWith:(NSString *)url dict:(NSDictionary *)dict
{
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    NSMutableDictionary *par =[NSMutableDictionary dictionaryWithDictionary:dict];
    [par setValue:user_id forKey:@"tokenval"];
   [ HGHttpTool POSTWithURL:url parameters:par success:^(id responseObject) {
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
            [self reflash];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
        }
    } failure:^(NSError *error) {
        HGLog(@"%@",error);
    }];
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
