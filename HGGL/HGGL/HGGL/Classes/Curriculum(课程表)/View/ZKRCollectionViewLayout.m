//
//  ZKRCollectionViewLayout.m
//  SYDX_2
//
//  Created by mac on 15-6-5.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ZKRCollectionViewLayout.h"
@interface ZKRCollectionViewLayout ()
@property (nonatomic,assign) NSInteger count;
//下面五个属性都是用来存储各个属性的使用次数的
@property (nonatomic,assign) NSInteger a;
@property (nonatomic,assign) NSInteger b;
@property (nonatomic,assign) NSInteger c;
@property (nonatomic,assign) NSInteger d;
@property (nonatomic,assign) NSInteger e;

@end
@implementation ZKRCollectionViewLayout
//这个方法必须调用，只有调用这个方法才能得到count
-(void)prepareLayout
{
    [super prepareLayout];
    _count = [self.collectionView numberOfItemsInSection:0];
}


-(CGSize)collectionViewContentSize
{
    // NSLog(@"%f-%ld",HGScreenWidth,(self.num/4-1)*(leftCellHeight+HGSpace)+leftCellWidth+2*HGSpace);
    //从这里可以看出这个方法返回的值并不是和以前的contentsize完全一样，这个地方返回的值是相对于整个uiwindow大小（除了状态栏的部分）加上传统意义上的contentsize的大小的出来的结果
     return CGSizeMake(HGScreenWidth , (self.num/4-1)*(leftCellHeight+HGSpace)+leftCellWidth+2*HGSpace);
    
}
//这个方法在布局参数中负责每个cell的布局方式和布局属性
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{

    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat width = (self.collectionViewContentSize.width - leftCellWidth-5*HGSpace)/3;
    
    if (indexPath.row == 0) {
        attribute.size = CGSizeMake(leftCellWidth, leftCellWidth);
        attribute.center = CGPointMake(HGSpace + leftCellWidth/2, HGSpace+leftCellWidth/2);
       
        
    }else if(indexPath.row/4 == 0){
        attribute.size = CGSizeMake(width, leftCellWidth);
        attribute.center = CGPointMake(width/2+2*HGSpace+leftCellWidth+_e*(width+HGSpace), HGSpace+leftCellWidth/2);
        
        _e++;
    }else if(indexPath.row%4 == 0){
        attribute.size = CGSizeMake(leftCellWidth, leftCellHeight);
        attribute.center = CGPointMake(HGSpace + leftCellWidth/2, leftCellWidth+2*HGSpace+leftCellHeight/2+_a*(leftCellHeight+HGSpace));
        _a++;
        
        
    }else if(indexPath.row%4 == 1)
    {
        attribute.size = CGSizeMake(width,leftCellHeight);
        attribute.center = CGPointMake(HGSpace*2+leftCellWidth+width/2, leftCellWidth+2*HGSpace+leftCellHeight/2+_b*(leftCellHeight+HGSpace));
        _b++;
        
        
    }else if(indexPath.row%4 == 2)
    {
        attribute.size = CGSizeMake(width, leftCellHeight);
        attribute.center = CGPointMake(HGSpace*3+leftCellWidth+width*3/2, leftCellWidth+2*HGSpace+leftCellHeight/2+_c*(leftCellHeight+HGSpace));
        
        
        _c++;
    }else
    {
        attribute.size = CGSizeMake(width, leftCellHeight);
        attribute.center = CGPointMake(HGSpace*4+leftCellWidth+width*5/2, leftCellWidth+2*HGSpace+leftCellHeight/2+_d*(leftCellHeight+HGSpace));
        
                _d++;
        
        
    }
    return attribute;
}
//汇总所有的布局属性
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    /**
     *  因为这个方法要实现他得功能就是在界面滑动 的时候不断的调用上面那一个方法从而不断的更新整个布局所以每次要像调用上面的方法的时候一定要从新将a,b,c,d,e这几个值都归0，要不然这几个值就会一直的累加
     */
    self.a = 0;
    self.b = 0;
    self.c = 0;
    self.d = 0;
    self.e = 0;

    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<self.count; i++) {
        NSIndexPath *path = [NSIndexPath indexPathForItem:i inSection:0];
         [array addObject:[self layoutAttributesForItemAtIndexPath:path]];
    }
   

    HGLog(@"hahah");
    return array;
    
}

@end
