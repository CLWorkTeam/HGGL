//
//  TeachResCollectionViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-18.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "TeachResCollectionViewController.h"
#import "TeachResTableViewController.h"
#import "CourseTableViewController.h"
#import "BaseInfoTableViewController.h"
#import "IntroTableViewController.h"
#import "ScoreTableViewController.h"
#import "TeachCollectionViewCell.h"
#import "UIView+Frame.h"
#import "CurrImageView.h"
@interface TeachResCollectionViewController ()
@property (nonatomic,strong)NSMutableArray *arr;
//下面这四个属性就是我要往cell里面加的视图 ，但是前两个必须在这里保存一下 如果在代码中直接创建就不管的话  就没有保存 那么也就没用

//授课课程
@property (nonatomic,strong)CourseTableViewController *course;
//授课评分
@property (nonatomic,strong)ScoreTableViewController *score;
//档案/介绍
@property (nonatomic,strong)IntroTableViewController *intro;
//基本信息
@property (nonatomic,strong)BaseInfoTableViewController *base;
@end

@implementation TeachResCollectionViewController

static NSString * const reuseIdentifier = @"Cell";

//课程信息
-(CourseTableViewController *)course
{
    if (_course == nil) {
        _course = [[CourseTableViewController alloc]init];
        _course.teacher_id = self.teacher_id;
        __weak typeof (self) weekSelf = self;
        _course.selectedRow = ^(id vc){
            if (weekSelf.PushVC) {
                weekSelf.PushVC (vc);
            }
        };
    }
    return _course;
}

//授课评分
-(ScoreTableViewController *)score
{
    if (_score == nil) {
        _score = [[ScoreTableViewController  alloc]init];
        _score.teacher_id = self.teacher_id;
        __weak typeof (self) weekSelf = self;
        _score.selectedRow = ^(id vc){
            if (weekSelf.PushVC) {
                weekSelf.PushVC (vc);
            }
        };
    }
    return _score;
}

//基本信息
-(BaseInfoTableViewController *)base
{
    if (_base == nil) {
        _base = [[BaseInfoTableViewController alloc]init];
        _base.teacher_id = self.teacher_id;
    }
    return _base;
}

//档案/介绍
-(IntroTableViewController *)intro
{
    if (_intro == nil) {
        _intro = [[IntroTableViewController alloc]init];
        _intro.teacher_id = self.teacher_id;
    }
    return _intro;
}
-(NSArray *)arr
{
    if (_arr == nil) {

        _arr = [NSMutableArray arrayWithObjects:self.base.tableView,self.course.tableView,self.score.tableView, nil];
    }
    return _arr;
}
-(instancetype)init
{
    //设置流水布局
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.itemSize = CGSizeMake(HGScreenWidth, HGScreenHeight-HGHeaderH-43);
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    layout.minimumLineSpacing = 0;
    

    return [self initWithCollectionViewLayout:layout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.bounces = NO;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    
    [self.collectionView registerClass:[TeachCollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
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
-(void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self.base showError];
    }else if (indexPath.row == 1)
    {
        [self.intro showError];
    }else if(indexPath.row == 2)
    {
        [self.course showError];
    }else if(indexPath.row == 3)
    {
        [self.score showError];
    }
}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
#warning Incomplete method implementation -- Return the number of items in the section
    return self.arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TeachCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.teacher_id = self.teacher_id;
    for (UIView *view in cell.ima.subviews) {
        if (view) {
            [view removeFromSuperview];
        }
    }
    UIView *view = [self.arr objectAtIndex:indexPath.row];
    
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
