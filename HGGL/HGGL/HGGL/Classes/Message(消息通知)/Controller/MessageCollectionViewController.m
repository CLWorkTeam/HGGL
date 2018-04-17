//
//  MessageCollectionViewController.m
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "MessageCollectionViewController.h"
#import "MessageLayout.h"
#import "MessagePopCollectionViewController.h"
#import "ZKRCover.h"
#import "CurrImageView.h"
#import "PopView.h"
#import "Memeber.h"
#import "Role.h"
#import "RoleMember.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
@interface MessageCollectionViewController ()

@property (nonatomic,strong) NSMutableArray *arr2;
@property (nonatomic,strong) PopView *pop;
@end

@implementation MessageCollectionViewController
-(NSMutableArray *)arr1
{
    if (!_arr1) {
        _arr1 = [NSMutableArray array];
    }
    return _arr1;
}
-(NSMutableArray *)arr2
{
    if (!_arr2) {
        
//    NSMutableArray *array = [NSMutableArray  arrayWithObjects:@{@"roleName":@"教务管理",@"roleId":@"1"},@{@"roleName":@"后勤管理",@"roleId":@"2"},@{@"roleName":@"课程管理",@"roleId":@"3"},@{@"roleName":@"接待管理",@"roleId":@"4"},@{@"roleName":@"办公室",@"roleId":@"5"},@{@"roleName":@"财务管理",@"roleId":@"6"},@{@"roleName":@"人事管理",@"roleId":@"7"},@{@"roleName":@"车辆管理",@"roleId":@"8"},@{@"roleName":@"设备管理",@"roleId":@"9"},@{@"roleName":@"网络管理",@"roleId":@"10"}, nil];
        _arr2 = [NSMutableArray array];
//        for (NSDictionary *dict in array) {
//            Role *r = [Role initWithDict:dict];
//            [_arr2 addObject:r];
//        }
    }
    
    
    
    return _arr2;
}
-(void)netWorking
{
//    HGLog(@"self.user_id-----%@", self.user_id);
    [HGHttpTool POSTWithURL:[HGURL stringByAppendingString:@"User/getUserRoles.do"] parameters:@{@"user_id":self.user_id,@"tokenval":self.user_id} success:^(id responseObject)
    {
        NSArray *array = [responseObject objectForKey:@"data"];
        HGLog(@"array === %@", array);
        for (NSDictionary *dict in array) {
            Role *r = [Role initWithDict:dict];
            [self.arr2 addObject:r];
        }
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"请检查网络连接设置"];
    }];

}


static NSString * const reuseIdentifier = @"Cell";

-(instancetype)init
{

    MessageLayout *layout = [[MessageLayout alloc]init];
    layout.sectiong1Num = self.arr1.count;
    layout.sectiong2Num = self.arr2.count;
    return [self initWithCollectionViewLayout:layout];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"添加用户";
    
    [self netWorking];


    self.collectionView.backgroundColor = [UIColor whiteColor];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    [but sizeToFit];
    but.width = 20;
    [but setImage:[UIImage imageNamed:@"return_normal"] forState:UIControlStateNormal];
//    [but setImage:[UIImage imageNamed:@"return_pressed"] forState:UIControlStateHighlighted];
    [but addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *letfBut = [[UIBarButtonItem alloc]initWithCustomView:but];
    self.navigationItem.leftBarButtonItem = letfBut;
    // Register cell classes
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"已选用户" withReuseIdentifier:@"ReuseID"];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"角色" withReuseIdentifier:@"ReuseID"];
    // Do any additional setup after loading the view.
}
-(void)back
{
    if (_messageBlock) {
        _messageBlock(self.arr1);
    }
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (section) {
        return self.arr2.count;
    }
    return self.arr1.count;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    NSInteger x;
//    if (indexPath.section == 0) {
        x = 0;
//    }else{
//        x = 30;
//    }
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ReuseID" forIndexPath:indexPath];

    
    view.backgroundColor = HGColor(245, 245, 245,1);
    //    [_lab removeFromSuperview];
    
    UILabel *lab = [[UILabel alloc]init];
    lab.tag = indexPath.section;
    lab.text = kind;
    lab.font = [UIFont systemFontOfSize:HGFont];
    lab.frame = CGRectMake(10, x, HGScreenWidth-2*10, 30);
    lab.textColor = [UIColor blackColor];
    lab.textAlignment = NSTextAlignmentLeft;
    [view addSubview:lab];

//    //箭头
//    _imV = [[UIImageView alloc]initWithFrame:CGRectMake(HGScreenWidth-15-20, x+10, 15, 15)];
//    _imV.tag = 1;
//    _imV.image = [UIImage showImage:@"go" andType:@"png"];
//    [view addSubview:_imV];

    return view;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.section) {
        UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
        for (UIView *view in cell.contentView.subviews) {
            if (view) {
                [view removeFromSuperview];
            }
        }
        cell.backgroundColor = [UIColor clearColor];
        UILabel *lab = [[UILabel alloc]init];
        lab.frame = cell.bounds;
        lab.font = [UIFont systemFontOfSize:HGFont];
        lab.layer.borderWidth = 1;
        lab.layer.borderColor = [[UIColor grayColor] CGColor ];
        lab.textAlignment = NSTextAlignmentCenter;
        Role *role = [self.arr2 objectAtIndex:indexPath.row];
        lab.text = role.roleName;
        [cell.contentView addSubview:lab];
        return cell;
    }else{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UILabel *lab = [[UILabel alloc]init];
    lab.frame = cell.bounds;
    
    lab.layer.borderWidth = 1;
    lab.layer.borderColor = [[UIColor grayColor] CGColor ];
    lab.font = [UIFont systemFontOfSize:HGFont];
    RoleMember *rm = [self.arr1 objectAtIndex:indexPath.row];
    lab.text = rm.m.user_name;
    lab.textAlignment = NSTextAlignmentCenter;
    [cell.contentView addSubview:lab];
    return cell;
    }
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        
//        MessagePopCollectionViewController *pop = [MessagePopCollectionViewController setPopViewWith:CGRectMake(HGScreenWidth*0.1, HGScreenHeight*0.1, HGScreenWidth*0.8, HGScreenHeight*0.8) And:nil];
        Role *r = [self.arr2 objectAtIndex:indexPath.row];
        
        PopView *pop = [PopView setPopViewWith:CGRectMake(HGScreenWidth*0.1, HGScreenHeight*0.1, HGScreenWidth*0.8, HGScreenHeight*0.8) withRole:r andArr:self.arr1];
        __weak typeof(self) weakSelf = self;
        pop.popBlock = ^(NSArray *arr,NSString *roleId)
        {
            
            if (self.arr1.count == 0) {
                [self.arr1 addObjectsFromArray:arr];
            }else
            {
                NSMutableArray *array = [NSMutableArray array];
                [array addObjectsFromArray:self.arr1];
                int i = -1;
                int j = 0;
                for (RoleMember *rm in self.arr1) {
                    
                    if ([rm.roleId isEqualToString:roleId]) {
                        [array removeObject:rm];
                        if (i<0) {
                            i = j;
                        }
                        
                    }
                    j++;
                }
//                [array addObjectsFromArray:arr];
                if ((array.count == 0)||(i<0)) {
                    [array addObjectsFromArray:arr];
                }else
                {
                    
                    [array insertObjects:arr atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(i, arr.count)]];
                    
                }
                
                [self.arr1 removeAllObjects];
                [self.arr1 addObjectsFromArray:array];
            }
            
            MessageLayout *layout = (MessageLayout *) weakSelf.collectionView.collectionViewLayout;
            layout.sectiong1Num = weakSelf.arr1.count;
            [weakSelf.collectionView reloadData];
        };
//        pop.title = r.roleName;
        self.pop = pop;
    }
}
#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
