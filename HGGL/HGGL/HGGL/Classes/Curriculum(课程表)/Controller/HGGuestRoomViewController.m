//
//  HGGuestRoomViewController.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGGuestRoomViewController.h"
#import "HGCRCollectionViewCell.h"
#import "HGLable.h"
#import "HGCRLayout.h"
#import "HGGRRModel.h"
#import "HGGRFModel.h"
#import "HcdDateTimePickerView.h"
@interface HGGuestRoomViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,weak) UIView *footer;
@property (nonatomic,weak)  UICollectionView *collectionView;
@property (nonatomic,assign) BOOL isRefreshing;
@property (nonatomic,copy) NSString *course_date;
@property (nonatomic,strong) NSMutableArray *dataAarray;
@property (nonatomic,strong) NSMutableArray *titleArray;
@property (nonatomic,weak) UIButton *header;
@property (nonatomic,strong) NSDateFormatter *formatter;
@end

@implementation HGGuestRoomViewController
-(NSDateFormatter *)formatter
{
    if (_formatter == nil) {
        NSDateFormatter *fomatter = [[NSDateFormatter alloc]init];
        [fomatter setDateFormat:@"yyyy-MM-dd"];
        _formatter = fomatter;
    }
    return _formatter;
}
-(NSMutableArray *)dataAarray
{
    if (_dataAarray == nil) {
        _dataAarray = [NSMutableArray array];
    }
    return _dataAarray;
}
-(NSMutableArray *)titleArray
{
    if (_titleArray == nil) {
        _titleArray = [NSMutableArray array];
    }
    return _titleArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setHeader];
    [self setCollection];
    [self setFooter];
    // Do any additional setup after loading the view.
}
-(void)setHeader
{
    self.course_date = [self.formatter stringFromDate:[NSDate date]];
    UIButton *but = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [but setTitleColor:HGMainColor forState:UIControlStateNormal];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
    but.titleLabel.textAlignment = NSTextAlignmentCenter;
    but.titleLabel.font = [UIFont systemFontOfSize:12];
    [but setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [but setTitle:self.course_date forState:UIControlStateNormal];
    [but addTarget:self action:@selector(clickBut:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
    [but setBackgroundColor:HGColor(0, 209, 255, 1)];
    but.layer.masksToBounds = YES;
    but.layer.cornerRadius = 5;
    but.frame = CGRectMake(10, 6.5, self.view.width-2*10, 30);
    but.tag = 201;
    
    self.header = but;
    [self.view addSubview:self.header];
}
-(void)clickBut:(UIButton *)button
{
    switch (button.tag-200) {
        case 1:
        {
            [self showTimeView];
        }
            break;
            
            
        default:
            break;
    }
}
-(void)showTimeView
{
    HcdDateTimePickerView *dateTimePickerView = [[HcdDateTimePickerView alloc] initWithDatePickerMode:DatePickerDateMode defaultDateTime:[[NSDate alloc]initWithTimeIntervalSinceNow:0]];
    dateTimePickerView.clickedOkBtn = ^(NSString * datetimeStr){
        
        NSDate *date = [self.formatter dateFromString:datetimeStr];
        [self.header setTitle:[self.formatter stringFromDate:date] forState:UIControlStateNormal];
        self.course_date = [self.formatter stringFromDate:date];
        [self.collectionView.mj_header beginRefreshing];
        
    };
    [HGKeywindow addSubview:dateTimePickerView];
    [dateTimePickerView showHcdDateTimePicker];
}
-(void)setCollection
{
    HGCRLayout *flowLayout = [[HGCRLayout alloc] init];
    flowLayout.dataArray = self.dataAarray;
    flowLayout.num = 3;
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
    
    CGFloat mar = 3;
    
    name.frame = CGRectMake(0, 6.5, name.width, H);
    
    [contentV addSubview:name];
    
    NSArray *arr = @[@{@"name":@"可用",@"color":HGColor(44, 209, 189, 1)},@{@"name":@"预订",@"color":HGColor(250, 202, 167, 1)},@{@"name":@"脏房",@"color":HGColor(128, 128, 128, 1)},@{@"name":@"维修中",@"color":HGColor(85, 114, 217, 1)},@{@"name":@"故障",@"color":HGColor(255, 122, 0, 1)},@{@"name":@"禁用",@"color":HGColor(48, 255, 43, 1)}];
    
    CGFloat lableM = 6;
    
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
    NSString *url = [HGURL stringByAppendingString:@"Reception/getRoomResource.do"];
    _isRefreshing = YES;
    [HGHttpTool POSTWithURL:url parameters:@{@"date":self.course_date} success:^(id responseObject) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        [self.collectionView.mj_header endRefreshing];
        NSString *status = [responseObject objectForKey:@"status"];
        if ([status isEqualToString:@"1"]) {
            [self.dataAarray removeAllObjects];
            [self.titleArray removeAllObjects];
            NSArray *arr = [responseObject objectForKey:@"data"];
            for (NSDictionary *dict in arr) {
                HGGRFModel *fmodel = [HGGRFModel initWithDict:dict];
                
                [self.dataAarray addObject:fmodel.roomArray];
                [self.titleArray addObject:fmodel.floor];
            }
            HGCRLayout *layout = (HGCRLayout *)self.collectionView.collectionViewLayout;
            layout.dataArray = self.dataAarray;
            layout.num = 3;
            [self.collectionView reloadData];
        }else
        {
            [SVProgressHUD showErrorWithStatus:[responseObject objectForKey:@"message"]];
            
        }
        
    } failure:^(NSError *error) {
        [SVProgressHUD dismiss];
        _isRefreshing = NO;
        //        [self.collectionView.mj_header endRefreshing];
        
        HGLog(@"%@",error);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return self.dataAarray.count;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    NSArray *arr = self.dataAarray[section];
    return arr.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    HGCRCollectionViewCell *cell =[collectionView dequeueReusableCellWithReuseIdentifier:@"HGCRCollectionViewCell" forIndexPath:indexPath];
    NSArray *arr = self.dataAarray[indexPath.section];
    HGGRRModel *rmodel = arr[indexPath.row];
    cell.titleStr = rmodel.roomName;
    cell.subTitleStr = [NSString stringWithFormat:@"%@人",rmodel.roomNum];
    switch ([rmodel.roomState integerValue]) {
        case 1:
        {
            cell.BGColor = HGColor(44, 209, 189, 1);
        }
            break;
        case 2:
        {
            cell.BGColor = HGColor(250, 202, 167, 1);
        }
            break;
        case 7:
        {
            cell.BGColor = HGColor(48, 255, 43, 1);
        }
            break;
        case 4:
        {
            cell.BGColor = HGColor(128, 128, 128, 1);
        }
            break;
        case 5:
        {
            cell.BGColor = HGColor(85, 114, 217, 1);
        }
            break;
        case 6:
        {
            cell.BGColor = HGColor(255, 122, 0, 1);
        }
            break;
            
        default:
            break;
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
    
    if (self.titleArray.count) {
        UILabel *lable = [HGLable lableWithAlignment:NSTextAlignmentLeft Font:HGFont Color:HGMainColor];
        
        
        lable.text = self.titleArray[indexPath.section];
        
        
        lable.frame = CGRectMake(5, 0, view.width-2*5, 30);
        
        [view addSubview:lable];
    }
    
    
    
    return view;
    
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

@end
