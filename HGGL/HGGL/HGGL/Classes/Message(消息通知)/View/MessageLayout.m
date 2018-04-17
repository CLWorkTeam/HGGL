//
//  MessageLayout.m
//  中大院移动教学办公系统
//
//  Created by Lei on 16/3/25.
//  Copyright © 2016年 sinosoft. All rights reserved.
//

#import "MessageLayout.h"
#define mar 10
#define heigh  30
@interface MessageLayout()
@property (nonatomic,assign) NSInteger line1;
@property (nonatomic,assign) NSInteger line2;
@end
@implementation MessageLayout

-(void)setSectiong1Num:(NSInteger)sectiong1Num
{
    _sectiong1Num = sectiong1Num;
    if (!(_sectiong1Num%3)) {
        _line1 = _sectiong1Num/3;
    }else
    {
        _line1 = _sectiong1Num/3 +1;
    }
}
-(void)setSectiong2Num:(NSInteger)sectiong2Num
{
    _sectiong2Num = sectiong2Num;
    if (!(_sectiong2Num%2)) {
        _line2 = _sectiong2Num/2;
    }else
    {
        _line2 = _sectiong2Num/2 +1;
    }
}
-(CGSize)collectionViewContentSize
{
   // CGFloat w = (HGScreenWidth - 3*mar)/2
    return CGSizeMake(HGScreenWidth, ((_line1 + _line2+2)*heigh+(_line1 + _line2+2)*mar));
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    if (indexPath.section == 0) {
        CGFloat w = (HGScreenWidth -4*mar)/3;
        attribute.size = CGSizeMake(w, heigh);
        attribute.center = CGPointMake(mar+w/2+(indexPath.row%3)*(mar+w), heigh+mar+heigh/2+(indexPath.row/3)*(mar+heigh));
    }else
    {
        CGFloat w = (HGScreenWidth -4*mar)/2;
        attribute.size = CGSizeMake(w, heigh);
        attribute.center = CGPointMake(mar+w/2+(indexPath.row%2)*(mar+w), heigh+(_line1+1)*(heigh+mar)+mar+heigh/2+(indexPath.row/2)*(mar+heigh));
    }
    HGLog(@"1");
    return attribute;
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
    if ([elementKind isEqualToString:@"已选用户"]) {
        attributes.center = CGPointMake(HGScreenWidth/2,heigh/2);
        attributes.size = CGSizeMake(HGScreenWidth, heigh);
    }else if([elementKind isEqualToString:@"角色"])
    {
        attributes.center = CGPointMake(HGScreenWidth/2, (_line1+1)*(heigh+mar)+heigh/2);
        attributes.size = CGSizeMake(HGScreenWidth, heigh);
    }
    HGLog(@"2");
    return attributes;
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i = 0; i<2; i++) {
        for (int j = 0; j<[self.collectionView numberOfItemsInSection:i]; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            [arr addObject:[self layoutAttributesForItemAtIndexPath:indexpath]];
            HGLog(@"3");
        }
    }
        NSIndexPath *indexpath = [NSIndexPath indexPathForRow:0 inSection:0];
        [arr addObject:[self layoutAttributesForSupplementaryViewOfKind:@"已选用户" atIndexPath:indexpath]];
//        [arr addObject:[self layoutAttributesForDecorationViewOfKind:@"footer" atIndexPath:indexpath]];
        NSIndexPath *indexpath1 = [NSIndexPath indexPathForRow:0 inSection:1];
        [arr addObject:[self layoutAttributesForSupplementaryViewOfKind:@"角色" atIndexPath:indexpath1]];
//    HGLog(@"3");
    return arr;
}
@end
