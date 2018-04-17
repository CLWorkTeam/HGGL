//
//  MessagePopCollectionViewController.m
//  中大院移动教学办公系统
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "MessagePopCollectionViewController.h"
#import "MessagePopLayout.h"
#import "CurrImageView.h"
#import "PopCollectionViewCell.h"
#import "Memeber.h"
#import "RoleMember.h"
#import "Role.h"
#import "HGHttpTool.h"
//#import "MBProgressHUD+Extend.h"
@interface MessagePopCollectionViewController ()
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) NSMutableArray *array;

@end

@implementation MessagePopCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(NSMutableArray *)cellArr
{
    if (_cellArr == nil) {
        _cellArr = [NSMutableArray array];
    }
    return _cellArr;
}
-(NSMutableDictionary *)cellDict
{
    if (_cellDict == nil) {
        _cellDict = [NSMutableDictionary dictionary];
    }
    return _cellDict;
}

-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray array];
    }
    return _arr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    NSArray *array = @[@{@"memberName":@"张欣荣",@"memberId":@"1"},@{@"memberName":@"吴海燕",@"memberId":@"2"},@{@"memberName":@"刘天奇",@"memberId":@"3"},@{@"memberName":@"吴敏霞",@"memberId":@"4"},@{@"memberName":@"郭跃",@"memberId":@"5"},@{@"memberName":@"董成鹏",@"memberId":@"6"},@{@"memberName":@"王磊",@"memberId":@"7"},@{@"memberName":@"于小海",@"memberId":@"8"},@{@"memberName":@"吕玉树",@"memberId":@"9"},@{@"memberName":@"刘天宝",@"memberId":@"10"},@{@"memberName":@"王向阳",@"memberId":@"11"},@{@"memberName":@"韩归属",@"memberId":@"12"},@{@"memberName":@"张天翼",@"memberId":@"13"},@{@"memberName":@"向天",@"memberId":@"14"},@{@"memberName":@"徐冰童",@"memberId":@"15"},@{@"memberName":@"李阳",@"memberId":@"16"},@{@"memberName":@"娄底",@"memberId":@"17"}];
    HGLog(@"self.role.roleId = %@", self.role.roleId);
    NSString *user_id = [HGUserDefaults stringForKey:@"userID"];
    [HGHttpTool POSTWithURL:[HGURL stringByAppendingString:@"User/getUserByRole.do"] parameters:@{@"roleId":self.role.roleId,@"tokenval":user_id} success:^(id responseObject) {
        NSArray *array = [responseObject objectForKey:@"data"];
        HGLog(@"array = %@", array);
        for (NSDictionary *dict in array) {
            Memeber *m = [Memeber initWithDict:dict];
            RoleMember *rm = [[RoleMember alloc]init];
            rm.roleId = self.role.roleId;
            rm.m = m;
            [self.arr addObject:rm];
            HGLog(@"self.arr = %@", self.arr);
            for (int i = 0; i<_arr.count ; i++) {
                RoleMember *mer = [_arr objectAtIndex:i];
                BOOL isContains = NO;
                for (RoleMember *m in _contaiArr) {
                    if ([_role.roleId isEqualToString:m.roleId]) {
                        if ([mer.m.user_id isEqualToString:m.m.user_id]) {
                            isContains = YES;
                        }
                    }
                    
                }
                if (isContains) {
                    [self.cellDict setObject:mer forKey:[NSIndexPath indexPathForRow:i inSection:0]];
                    [self.cellArr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
                }
            }
            if (self.cellArr.count == self.arr.count) {
                if (_clickAll) {
                    _clickAll();
                }
            }
        }
        [self.collectionView reloadData];
        
    } failure:^(NSError *error) {
        [SVProgressHUD showErrorWithStatus:@"请检查网络连接"];
        
    }];
    
    
    
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.collectionView registerClass:[PopCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"footer" withReuseIdentifier:@"reuseId"];
////    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"已选用户" withReuseIdentifier:@"ReuseID"];
//    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"header" withReuseIdentifier:@"reuseId"];
    // Do any additional setup after loading the view.
}
-(instancetype)init
{
    //设置流水布局
    MessagePopLayout *layout = [[MessagePopLayout alloc]init];
    layout.num = self.arr.count;
    return [self initWithCollectionViewLayout:layout];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)selectedAll:(BOOL)isAll
{
    [self.cellArr removeAllObjects];
    [self.cellDict removeAllObjects];
    if (isAll) {
        for (int i = 0;  i<self.arr.count; i++) {
            RoleMember *rm = self.arr[i];
            [self.cellDict setObject:rm forKey:[NSIndexPath indexPathForRow:i inSection:0]];
            [self.cellArr addObject:[NSIndexPath indexPathForRow:i inSection:0]];
    }
    }
    [self.collectionView reloadData];
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
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.arr.count;
}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *resusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reuseId" forIndexPath:indexPath];
//    for (UIView *view in resusableView.subviews) {
//        [view removeFromSuperview];
//    }
//    if ([kind isEqualToString:@"footer"]) {
////        UICollectionReusableView *resusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reuseId" forIndexPath:indexPath];
//        
//        anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
//        btn.frame = CGRectMake(5, 0, 100, 30);
//        btn.titleLabel.font = [UIFont systemFontOfSize:HGFont];
//        [btn setTitle:@"选择全部" forState:UIControlStateNormal];
//        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//        
////        btn.backgroundColor = [UIColor redColor];
//        NSArray *arr = @[@"取消",@"确定"];
//        for (int i = 0; i<arr.count; i++) {
//            anyButton *btn = [anyButton buttonWithType:UIButtonTypeCustom];
//            btn.frame = CGRectMake((HGScreenWidth*0.8-1)/2*i, 30, (HGScreenWidth*0.8-1)/2, 30);
//            [btn setTitle:arr[i] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
//            btn.titleLabel.textAlignment = NSTextAlignmentCenter;
//            btn.titleLabel.font = [UIFont systemFontOfSize:15];
//            btn.tag = i;
//            //[self.btnArr addObject:btn];
//            [btn addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventTouchUpInside];
//            [resusableView addSubview:btn];
//            
//            
//            UIImageView *line1 = [[UIImageView alloc]initWithFrame:CGRectMake(HGScreenWidth/2, btn.frame.origin.y+5, 1, 20)];
//            line1.backgroundColor = [UIColor blackColor];
//            [resusableView addSubview:line1];
//        }
//        [resusableView addSubview:btn];
//        return resusableView;
//    }else
//    {
////        UICollectionReusableView *resusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"reuseId" forIndexPath:indexPath];
//        UILabel *lab = [[UILabel alloc]init];
//        lab.tag = indexPath.section;
//        lab.text = @"角色名称:";
//        lab.font = [UIFont systemFontOfSize:HGFont];
//        lab.frame = CGRectMake(10, 0, HGScreenWidth*0.8-2*5, 30);
//        lab.textColor = [UIColor blackColor];
//        lab.textAlignment = NSTextAlignmentLeft;
//        [resusableView addSubview:lab];
//        return resusableView;
//    }
//    
//    
//    
//}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PopCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    cell.backgroundColor = [UIColor redColor];
    for (UIView *view in cell.contentView.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    RoleMember *m = [self.arr objectAtIndex:indexPath.row];
    cell.name = m.m.user_name;
    if ([self.cellDict objectForKey:indexPath]) {
        cell.lab.textColor = [UIColor redColor];
    }
    //    [cell.contentView addSubview:label];
    // Configure the cell
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    RoleMember *m = [self.arr objectAtIndex:indexPath.row];
    if (![self.cellDict objectForKey:indexPath]) {
        
        [self.cellDict setObject:m forKey:indexPath];
        [self.cellArr addObject:indexPath];
    }else
    {
       
        [self.cellDict removeObjectForKey:indexPath];
        [self.cellArr removeObject:indexPath];
    }
    if (self.arr.count == self.cellDict.count) {
        if (_collIsall) {
            _collIsall(YES);
        }
    }else
    {
        if (_collIsall) {
            _collIsall(NO);
        }
    }
    [self.collectionView reloadData];
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
