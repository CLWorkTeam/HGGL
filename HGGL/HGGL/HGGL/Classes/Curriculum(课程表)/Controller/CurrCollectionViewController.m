//
//  CurrCollectionViewController.m
//  SYDX_2
//
//  Created by mac on 15-6-3.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "CurrCollectionViewController.h"
#import "CurrCollectionViewCell.h"
#import "WeekDayCollectionViewCell.h"
#import "ClassRoomCollectionViewCell.h"
#import "ClassNumCollectionViewCell.h"
#import "NightCollectionViewCell.h"
#import "ZKRCollectionViewLayout.h"

@interface CurrCollectionViewController ()
@property (nonatomic,strong) NSArray *current;
@property (nonatomic,strong) NSArray *arr;
@property (nonatomic,assign) NSInteger i;
@end

@implementation CurrCollectionViewController

static NSString * const classRoomIdentifier1 = @"Cell1";
static NSString * const classNumIdentifier2 = @"Cell2";
static NSString * const weekDayIdentifier3 = @"Cell3";
static NSString * const currIdentifier4 = @"Cell4";
static NSString * const nightreuseIdentifier5 = @"Cell5";
-(NSArray *)arr
{
    if (_arr == nil) {
        _arr = [NSArray arrayWithObjects:@"上午",@"下午",@"晚上", nil];
    }
    return _arr;
}
-(instancetype)init
{
    ZKRCollectionViewLayout *layout = [[ZKRCollectionViewLayout alloc]init];
    layout.num = 100;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    return  [self initWithCollectionViewLayout:layout];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    HGLog(@"课程表");
    
    self.collectionView.bounces = NO;
    //NSArray *arr = [NSArray arrayWithObjects:@"上午",@"下午",@"晚上", nil];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
    [self.collectionView registerClass:[ClassRoomCollectionViewCell class] forCellWithReuseIdentifier:classRoomIdentifier1];
    [self.collectionView registerClass:[ClassNumCollectionViewCell class] forCellWithReuseIdentifier:classNumIdentifier2];
    [self.collectionView registerClass:[WeekDayCollectionViewCell class] forCellWithReuseIdentifier:weekDayIdentifier3];
    [self.collectionView registerClass:[CurrCollectionViewCell class] forCellWithReuseIdentifier:currIdentifier4];
    [self.collectionView registerClass:[NightCollectionViewCell class] forCellWithReuseIdentifier:nightreuseIdentifier5];
    
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

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        ClassRoomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classRoomIdentifier1 forIndexPath:indexPath];
        //NSLog(@"00000");
        return cell;
    }else if((indexPath.row%4 == 0)&&(indexPath.row != 0))
    {
        ClassNumCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:classNumIdentifier2 forIndexPath:indexPath];

        return cell;
    }else if((indexPath.row/4 == 0)&&(indexPath.row != 0))
    {
        WeekDayCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:weekDayIdentifier3 forIndexPath:indexPath];
        cell.str = [self.arr objectAtIndex:self.i];
        _i++;
        if (self.i == 3) {
            self.i = 0;
        }
        //NSLog(@"%ld",self.i);
        return cell;
    }else if(indexPath.row%4 == 3)
    {
        NightCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:nightreuseIdentifier5 forIndexPath:indexPath];
        return cell;
    }else
    {
        CurrCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:currIdentifier4 forIndexPath:indexPath];
        return cell;
    }
    
}
//- (void)viewWillLayoutSubviews
//{
//    [super viewWillLayoutSubviews];
//    [self.collectionView.collectionViewLayout invalidateLayout];
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{rrrrrrrrrrrrr
////    self.collectionView.collectionViewLayout.
////    NSLog(@"gundong");
//}
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 0) {
//        return CGSizeMake(leftCellWidth, leftCellWidth);
//    }else if(indexPath.row%4 == 0){
//        return CGSizeMake(leftCellWidth, leftCellHeight);
//    }
//    else if(indexPath.row/4 == 0)
//    {
//        return CGSizeMake((self.collectionView.bounds.size.width - leftCellWidth-4*HGSpace)/3,leftCellWidth);
//    }else
//    {
//        return CGSizeMake((self.collectionView.bounds.size.width - leftCellWidth-4*HGSpace)/3, leftCellHeight);
//    }
//    
//    
//}

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
//-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    NSLog(@"DRAG");
//}
//-(void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    CGSize size = self.collectionView.collectionViewLayout.collectionViewContentSize;
//    //NSLog(@"%f,%f",size.width,size.height);
//   
//}

@end
