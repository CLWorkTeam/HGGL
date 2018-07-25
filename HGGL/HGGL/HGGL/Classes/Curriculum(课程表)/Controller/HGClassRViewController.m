//
//  HGClassRViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGClassRViewController.h"
#import "HGCRLayout.h"
#import "HGUCRoomModel.h"
#import "HGCRoomModel.h"
#import "HGHoldRMDModel.h"
#import "HGCRCollectionViewCell.h"
#import "HGLable.h"
#import "HGCRoomHeader.h"
#import "HGCRPopView.h"
@interface HGClassRViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong) NSMutableArray *UHCRArray;
@property (nonatomic,strong) NSMutableArray *HCRArray;
@property (nonatomic,weak) HGCRoomHeader *header;
@property (nonatomic,weak) UIView *footer;
@property (nonatomic,weak)  UICollectionView *collectionView;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,copy) NSString *course_date;
@property (nonatomic,copy) NSString *type; //1、教室  2、研讨室  3、会议室
@end

@implementation HGClassRViewController
-(NSMutableArray *)UHCRArray
{
    if (_UHCRArray == nil) {
        _UHCRArray = [NSMutableArray array];
    }
    return _UHCRArray;
}
-(NSMutableArray *)HCRArray
{
    if (_HCRArray == nil) {
        _HCRArray = [NSMutableArray array];
    }
    return _HCRArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    self.course_date = [fomatter stringFromDate:[NSDate date]];
    self.type = @"1";
    [self setHeader];
    [self setCollection];
    [self setFooter];
//    self.view.backgroundColor = [UIColor orangeColor];
    
}
-(void)setHeader
{
    HGCRoomHeader *header = [[HGCRoomHeader alloc]init];
    NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
    [fomatter setDateFormat:@"yyyy-MM-dd"];
    header.date = [fomatter stringFromDate:[NSDate date]];
    header.type = @"1";
    WeakSelf
    header.clickBlock = ^(NSString *type, NSString *date) {
        
        weakSelf.type = type;
        
        weakSelf.course_date = date;
        
        [weakSelf.collectionView.mj_header beginRefreshing];
        
    };
    header.frame = CGRectMake(0, 0, self.view.width, 43+30);
    self.header = header;
    [self.view addSubview:header];
}
-(void)setCollection
{
    HGCRLayout *flowLayout = [[HGCRLayout alloc] init];
    flowLayout.dataArray = @[self.UHCRArray,self.HCRArray];
    flowLayout.num  = 2;
    //设置CollectionView的属性
     UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, HGHeaderH, self.view.width, self.view.height-HGHeaderH) collectionViewLayout:flowLayout];
//    self.collectionView.backgroundColor = Color(238, 238, 238);
    collectionView.delegate = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    collectionView.dataSource = self;
    collectionView.scrollEnabled = YES;
    [self.view addSubview:collectionView];
    self.collectionView = collectionView;
    //注册Cell
    [self.collectionView registerClass:[HGCRCollectionViewCell class] forCellWithReuseIdentifier:@"HGCRCollectionViewCell"];
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:@"header" withReuseIdentifier:@"ReuseID"];
    WeakSelf
    self.collectionView.mj_header = [HGRefresh loadNewRefreshWithRefreshBlock :^{
        [weakSelf loadDWith];
    }];
    
    
    [self.collectionView.mj_header beginRefreshing];
    
   
}
-(void)setFooter
{
//    UIView *footer = [[UIView alloc]init];
    
    UIView *contentV = [[UIView alloc]init];
    
    self.footer = contentV;
    
    [self.view addSubview:contentV];
    
    CGFloat H = 30;
    
    UILabel *name = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGTipFont Color:[UIColor blackColor]];
    
    name.text = @"图例：";
    
    [name sizeToFit];
    
    CGFloat mar = 8;
    
    name.frame = CGRectMake(0, 6.5, name.width, H);
    
    [contentV addSubview:name];
    
    NSArray *arr = @[@{@"name":@"未占用",@"color":HGColor(44, 209, 189, 1)},@{@"name":@"已占用",@"color":HGColor(250, 202, 167, 1)}];
    
    CGFloat lableM = 10;
    
    CGFloat maxW = 0;
    
    NSMutableArray *lableArray = [NSMutableArray array];
    
    for (int i = 0;i<arr.count;i++) {
        
        UILabel *lable = [HGLable lableWithAlignment:NSTextAlignmentCenter Font:HGTipFont Color:[UIColor whiteColor]];
        
        NSDictionary *dict = arr[i];
        
        lable.text = dict[@"name"];
        
        lable.backgroundColor = dict[@"color"];
        
        lable.layer.masksToBounds = YES;
        
        lable.layer.cornerRadius = 5;
        
        [lable sizeToFit];
        
        if (i>0) {
            UILabel *lastLable = lableArray[i-1];
            lable.frame = CGRectMake(lastLable.maxX+mar, name.y, lableM+lable.width, name.height);
        }else
        {
            lable.frame = CGRectMake(name.maxX, name.y, lableM+lable.width, name.height);
        }
//        lable.frame = CGRectMake(name.maxX+(mar+lable.width+lableM)*i, name.y, lableM+lable.width, name.height);
        
        [contentV addSubview:lable];
        [lableArray addObject:lable];
        if (i == arr.count-1) {
            maxW = lable.maxX;
        }
        
    }
    
    contentV.bounds = CGRectMake(0, 0, maxW, 43);
    
    
    
}
-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    self.collectionView.frame = CGRectMake(0, self.header.maxY, self.view.width, self.view.height-self.header.height-HGSafeBottom-self.footer.height);
    
    self.footer.center = CGPointMake(self.view.width/2, self.collectionView.maxY+self.footer.height/2);
    
}
-(void)loadDWith
{
    if (_isRefreshing) {
        
        return;
        
    }
    
    [SVProgressHUD showWithStatus:@"请稍后..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    NSString *url = [HGURL stringByAppendingString:@"Course/getUseCroomInfo.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:@{@"course_date":self.course_date,@"type":self.type} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.collectionView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.HCRArray removeAllObjects];
            [self.UHCRArray removeAllObjects];
            NSDictionary *dictionary = [responseObject objectForKey:@"data"];
            NSArray *UHCRArray = dictionary[@"unHoldList"];
            NSArray *HCRArray = dictionary[@"holdList"];
            for (NSDictionary *dict in UHCRArray) {
                HGUCRoomModel *mes = [HGUCRoomModel initWithDict:dict];
                [self.UHCRArray addObject:mes];
            }
            for (NSDictionary *dict in HCRArray) {
                HGCRoomModel *mes = [HGCRoomModel initWithDict:dict];
                [self.HCRArray addObject:mes];
            }
            HGCRLayout *layout = (HGCRLayout *)self.collectionView.collectionViewLayout;
            layout.dataArray = @[self.UHCRArray,self.HCRArray];
            layout.num = 2;
            [self.collectionView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
//        [self.collectionView.mj_header endRefreshing];
        [self.collectionView.mj_header endRefreshing];
        
        HGLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 2;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    if (section) {
        return self.HCRArray.count;
        
    }else
    {
        return self.UHCRArray.count;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HGCRCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"HGCRCollectionViewCell" forIndexPath:indexPath];
    if (indexPath.section) {
        
        
        
        HGCRoomModel *model = self.HCRArray[indexPath.row];
        cell.titleStr = model.holdName;
        cell.subTitleStr = [NSString stringWithFormat:@"%@座位",model.holdNum];
        cell.BGColor = HGColor(250, 202, 167, 1);
        
    }else
    {
        HGUCRoomModel *model = self.UHCRArray[indexPath.row];
        cell.titleStr = model.unHoldName;
        cell.subTitleStr = [NSString stringWithFormat:@"%@座位",model.unHoldNum];
        cell.BGColor = HGColor(44, 209, 189, 1);
        
    }
    
    return cell;
    
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"ReuseID" forIndexPath:indexPath];
    for (UIView *subview in view.subviews) {
        if (subview) {
            [subview removeFromSuperview];
        }
    }
    
    if (self.HCRArray.count||self.UHCRArray.count) {
        UILabel *lable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
        
        if (indexPath.section) {
            lable.text = @"已占用";
        }else
        {
            lable.text = @"未占用";
        }
        
        lable.frame = CGRectMake(5, 0, view.width-2*5, 30);
        
        [view addSubview:lable];
    }
    
    
    
    return view;
    
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section) {
        
        HGCRoomModel *model = self.HCRArray[indexPath.row];
        
        CGRect r = [self.collectionView.superview convertRect:self.collectionView.frame toView:HGKeywindow];
        CGRect rect = CGRectMake(30, r.origin.y, r.size.width-2*30, HGScreenHeight-HGSafeBottom-r.origin.y*2);
        
        [HGCRPopView setPopViewWith:rect  And:model.detailArr ];
        
    }
}
@end
