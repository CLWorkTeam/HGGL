//
//  HGCRLayout.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/22.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGCRLayout.h"
#import "HGCRCollectionReusableView.h"
#define Wmargin 15
#define Wmargin1 10
#define Wmargin2 5
#define Hmargin 8
#define lableH 30
#define HSpace 15
#define cellH [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGTipFont] Andwidth:60].height*2+3*5
//#define num 2
@interface HGCRLayout ()

@property (nonatomic,assign) BOOL hasData;
@end
@implementation HGCRLayout
-(CGSize)collectionViewContentSize
{
    
    
    [self registerClass:[HGCRCollectionReusableView class] forDecorationViewOfKind:@"contentView"];//注册Decoration View
    NSInteger lineNum = 0;
        
    if (self.dataArray&&(self.dataArray.count == 0)) {
        return CGSizeMake(HGScreenWidth, 0);
    }else
    {
        for (NSArray *arr in self.dataArray) {
            if (arr.count) {
                self.hasData = YES;
            }
            if (arr.count%self.num) {
                lineNum += arr.count/self.num +1;
            }else
            {
                lineNum += arr.count/self.num;
            }
            
        }
        
    }
    
    return CGSizeMake(HGScreenWidth, self.dataArray.count*(lableH+HSpace)+(cellH+Hmargin)*lineNum);
        
    
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    CGFloat imageW = (HGScreenWidth - 2*Wmargin2-2*Wmargin1-(self.num-1)*Wmargin)/self.num ;
    CGFloat headerHeight = lableH;
    CGFloat lineNum = 0;
    for (int i = 0 ; i<indexPath.section; i++) {
        NSArray *arr = self.dataArray[i];
        if (arr.count%self.num) {
            lineNum += arr.count/self.num +1;
        }else
        {
            lineNum += arr.count/self.num;
        }
        
    }
    
    
    attribute.frame = CGRectMake(Wmargin1+Wmargin2+(indexPath.row%self.num)*(imageW+Wmargin),lableH+indexPath.section*(lableH+HSpace)+(indexPath.row/self.num)*(cellH+Hmargin)+lineNum*(cellH+Hmargin), imageW, cellH);
    
    
    return attribute;
    
}
-(UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:elementKind withIndexPath:indexPath];
//    CGFloat imageW = (HGScreenWidth - 2*Wmargin2-2*Wmargin1-(num-1)*Wmargin)/2;
    
    
    CGFloat lineNum = 0;
    
    
    
    for (int i = 0 ; i<indexPath.section; i++) {
        NSArray *arr = self.dataArray[i];
        
        if (arr.count%self.num) {
            lineNum += arr.count/self.num +1;
        }else
        {
            lineNum += arr.count/self.num;
        }
        
    }
    CGFloat headerHeight = (self.hasData?lableH:0);
    CGFloat currentLine = 0;
    NSArray *arr = self.dataArray[indexPath.section];
    if (arr.count%self.num) {
        currentLine += arr.count/self.num +1;
    }else
    {
        currentLine += arr.count/self.num;
    }
    
    attributes.frame = CGRectMake(Wmargin1,(indexPath.section)*(HSpace+headerHeight)+lineNum*(cellH+Hmargin), HGScreenWidth-2*Wmargin1, headerHeight);
    return attributes;
}
- (UICollectionViewLayoutAttributes *)layoutAttributesForDecorationViewOfKind:(NSString*)decorationViewKind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewLayoutAttributes* att = [UICollectionViewLayoutAttributes layoutAttributesForDecorationViewOfKind:decorationViewKind withIndexPath:indexPath];
    att.zIndex = -1;//-1表示这个view会一直待在最底层
    CGFloat headerHeight = (self.hasData?lableH:0);
    
    CGFloat lineNum = 0;
    for (int i = 0 ; i<indexPath.section; i++) {
        NSArray *arr = self.dataArray[i];
        if (arr.count%self.num) {
            lineNum += arr.count/self.num +1;
        }else
        {
            lineNum += arr.count/self.num;
        }
        
    }
    
    CGFloat currentLine = 0;
    NSArray *arr = self.dataArray[indexPath.section];
    if (arr.count%self.num) {
        currentLine += arr.count/self.num +1;
    }else
    {
        currentLine += arr.count/self.num;
    }
    
    att.frame = CGRectMake(Wmargin1, (indexPath.section)*(HSpace+headerHeight)+lineNum*(cellH+Hmargin), HGScreenWidth-2*Wmargin1, headerHeight+currentLine*(Hmargin+cellH));
    
    return att;
}
-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *arr = [NSMutableArray array];
    
    for (int i = 0; i<self.dataArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:3 inSection:i];
        [arr addObject:[self layoutAttributesForDecorationViewOfKind:@"contentView" atIndexPath:indexPath]];
    }
    for (int i = 0; i<self.dataArray.count; i++) {
        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:i];
        [arr addObject:[self layoutAttributesForSupplementaryViewOfKind:@"header" atIndexPath:indexPath]];
    }
    
    for (int i = 0; i<self.dataArray.count; i++) {
        for (int j = 0; j<[self.collectionView numberOfItemsInSection:i]; j++) {
            NSIndexPath *indexpath = [NSIndexPath indexPathForRow:j inSection:i];
            //ZKRLog(@"%d--%d",i,j);
            [arr addObject:[self layoutAttributesForItemAtIndexPath:indexpath]];
        }
    }
    
    
    
    return arr;
}

@end
