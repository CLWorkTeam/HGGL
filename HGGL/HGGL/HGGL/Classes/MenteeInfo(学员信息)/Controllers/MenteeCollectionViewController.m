//
//  MenteeCollectionViewController.m
//  SYDX_2
//
//  Created by mac on 15-7-31.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "MenteeCollectionViewController.h"
#import "MenteeBaseTableViewController.h"
#import "MenteeProTableViewController.h"
#import "MenteeCollectionViewCell.h"
#import "TeachCollectionViewCell.h"
#import "CurrImageView.h"
@interface MenteeCollectionViewController ()
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,strong) MenteeBaseTableViewController *base;
@property (nonatomic,strong) MenteeProTableViewController *pro;
@end

@implementation MenteeCollectionViewController

static NSString * const reuseIdentifier = @"Cell";
-(MenteeBaseTableViewController *)base
{
    if (_base == nil) {
        _base = [[MenteeBaseTableViewController alloc]init];
        _base.mentee = self.mentee;
    }
    return _base;
}
-(MenteeProTableViewController *)pro
{
    if (_pro == nil) {
        _pro = [[MenteeProTableViewController  alloc]init];
        _pro.mentee_id = self.mentee_id;
    }
    return _pro;
}
-(NSArray *)arr

{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:self.base.tableView,self.pro.tableView, nil];
    }
    return _arr;
}
-(instancetype)init
{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(HGScreenWidth, HGScreenHeight-64-43);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    
    
    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled = YES;
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[MenteeCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    TeachCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
//    
//    //cell.teacher_id = self.teacher_id;
//    for (UIView *view in cell.ima.subviews) {
//        if (view) {
//            [view removeFromSuperview];
//        }
//    }
//    UIView *view = [self.arr objectAtIndex:indexPath.row];
//    //HGLog(@"%@",view);
//    cell.content = view;
//    return cell;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    NSInteger page = scrollView.contentOffset.x/scrollView.width +0.5;
    //__weak typeof (self) weekSelf = self;
    if (_VCChange) {
        _VCChange(page);
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MenteeCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    
    for (UIView *view in cell.ima.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UIView *view = [self.arr objectAtIndex:indexPath.row];
    
    cell.content = view;
    
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 1) {
        [self.pro showError];
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
