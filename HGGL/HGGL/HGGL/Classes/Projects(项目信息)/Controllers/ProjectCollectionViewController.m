//
//  ProjectCollectionViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-29.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ProjectCollectionViewController.h"

#import "TeachCollectionViewCell.h"
#import "CurrImageView.h"
#import "BaseTableViewController.h"
#import "StudentTableViewController.h"
#import "PCourseTableViewController.h"
@interface ProjectCollectionViewController ()<UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic,strong) BaseTableViewController *base;
@property (nonatomic,strong) StudentTableViewController *student;
@property (nonatomic,strong) PCourseTableViewController *pc;
@end

@implementation ProjectCollectionViewController
-(BaseTableViewController *)base
{
    if (_base == nil) {
        _base = [[BaseTableViewController alloc]init];
        __weak typeof (self)weakSelf = self;
        _base.butBlock = ^(id vc)
        {
            if (weakSelf. VCBlock) {
                weakSelf .VCBlock(vc);
            }
        };
        _base.project_id = self.project_id;
//        _base.PL = self.PL;
    }
    return _base;
}
-(StudentTableViewController *)student
{
    if (_student == nil) {
        _student = [[StudentTableViewController alloc]init];
        _student.project_id = self.project_id;
    }
    return _student;
}
-(PCourseTableViewController *)pc
{
    if (_pc == nil) {
        _pc = [[PCourseTableViewController alloc]init];
        __weak typeof (self)weakSelf = self;
        _pc.jumpVCBlock = ^(id vc) {
            if (weakSelf. VCBlock) {
                weakSelf .VCBlock(vc);
            }
        };
        _pc.project_id = self.project_id;
    }
    return _pc;
}
-(NSMutableArray *)arr
{
    if (_arr == nil) {
        _arr = [NSMutableArray arrayWithObjects:self.base.tableView,self.student.tableView,self.pc.tableView, nil];
    }
    return _arr;
}
static NSString * const reuseIdentifier = @"Cell";

static NSString * const reuseIdentifier1 = @"header";
-(instancetype)init
{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(HGScreenWidth, HGScreenHeight-HGHeaderH-53);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
   // self.collectionView
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    //self.collectionView
    // Register cell classes
    [self.collectionView registerClass:[TeachCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
//    [self.collectionView registerClass:[ProjectCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier1];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.student showError];
    }else if (indexPath.row == 2)
    {
        [self.pc showError];
    }
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

//#pragma mark <UICollectionViewDataSource>
//-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
//{
//    ProjectCollectionReusableView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:reuseIdentifier1 forIndexPath:indexPath];
//    if ([kind isEqualToString:UICollectionElementKindSectionHeader]&&header == nil) {
//       header = [[ProjectCollectionReusableView alloc]init];
//        
//    }
//    return header ;
//    
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section
//{
//    return CGSizeMake(HGScreenWidth, 70);
//}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 3;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeachCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    //cell.teacher_id = self.teacher_id;
    for (UIView *view in cell.ima.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UIView *view = [self.arr objectAtIndex:indexPath.row];
    //HGLog(@"%@",view);
    cell.content = view;
    return cell;
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.width +0.5;
    //__weak typeof (self) weekSelf = self;
    if (_VCChange) {
        _VCChange(page);
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
