//
//  MessagePopLayout.m
//  中大院移动教学办公系统
//
//  Created by apple on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "MessagePopLayout.h"
#define mar 5
#define headerH 30
#define heigh 30
#define footerH 60
@interface MessagePopLayout()
@property (nonatomic, assign) NSInteger line;
@end
@implementation MessagePopLayout
-(void)setNum:(NSInteger)num
{
    _num = num;
    if (!(_num%3)) {
        _line = _num/3;
    }else
    {
        _line = _num/3 +1;
    }
}
-(CGSize)collectionViewContentSize
{
    return CGSizeMake(HGScreenWidth*0.8, _line*heigh+(_line+1)*mar);
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes * attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath ];
    CGFloat w = (HGScreenWidth*0.8-4*mar)/3;
    
    attributes.center = CGPointMake(mar+w/2+(indexPath.row%3)*(mar+w), mar+heigh/2+(indexPath.row/3)*(heigh+mar));
    HGLog(@"%@",NSStringFromCGPoint(attributes.center));
    attributes.size = CGSizeMake(w, heigh);
    return attributes;
}
//-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
//{
//    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
//    if ([elementKind isEqualToString:@"header"]) {
//        attributes.center = CGPointMake(HGScreenWidth*0.8/2, headerH/2);
//        attributes.size = CGSizeMake(HGScreenWidth*0.8, headerH);
////        return attributes;
//    }else
//    {
//        attributes.center = CGPointMake(HGScreenWidth*0.4, _line*heigh+(_line+1)*mar+headerH+footerH/2);
//        attributes.size = CGSizeMake(HGScreenWidth*0.8, footerH);
//    }
//    return attributes;
//}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i =0; i<[self.collectionView numberOfItemsInSection:0]; i++) {
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:i inSection:0];
        
        [arr addObject:[self layoutAttributesForItemAtIndexPath:indexpath]];
    }
//    NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0 ];
//    [arr addObject:[self layoutAttributesForSupplementaryViewOfKind:@"header" atIndexPath:indexpath]];
//    [arr addObject:[self layoutAttributesForSupplementaryViewOfKind:@"footer" atIndexPath:indexpath]];
    return arr;
}
@end
