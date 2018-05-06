//
//  HGPBRemarkModel.m
//  HGGL
//
//  Created by 陈磊 on 2018/5/3.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGPBRemarkModel.h"
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:HGFont] Andwidth:60].height
#define cellHigh minH+2*CellHMargin
@implementation HGPBRemarkModel
-(instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init]) {
        self.title = dict[@"title"];
        self.remark = dict[@"remark"];
        self.department = dict[@"department"];
        self.staff = dict[@"staff"];
        [self layoutView];
    }
    
    return self;
}
+(instancetype)initWithDict:(NSDictionary *)dict
{
    
    return [[[self alloc] init] initWithDict:dict];
}
-(void)layoutView
{
    CGFloat mar = 2;
    CGFloat wid = (HGScreenWidth-2*CellWMargin-3*mar)/4;
    CGFloat titleH = [TextFrame frameOfText:self.title With:[UIFont systemFontOfSize:HGTipFont] Andwidth:wid].height;
    CGFloat remarkH = [TextFrame frameOfText:self.remark With:[UIFont systemFontOfSize:HGTipFont] Andwidth:wid].height;
    CGFloat staffH = [TextFrame frameOfText:self.staff With:[UIFont systemFontOfSize:HGTipFont] Andwidth:wid].height;
    CGFloat departmentH = [TextFrame frameOfText:self.department With:[UIFont systemFontOfSize:HGTipFont] Andwidth:wid].height;
    CGFloat maxH = 0;
    
    maxH = (titleH>remarkH?titleH:remarkH);
    maxH = (maxH>staffH?maxH:staffH);
    maxH = (maxH>departmentH?maxH:departmentH);
    
    self.titleF = CGRectMake(CellWMargin, CellHMargin, wid, titleH);
    self.remarkF = CGRectMake(CGRectGetMaxX(self.titleF)+mar, self.titleF.origin.y, wid, remarkH);
    self.staffF = CGRectMake(CGRectGetMaxX(self.remarkF)+mar,self.titleF.origin.y , wid, staffH);
    self.departmentF = CGRectMake(CGRectGetMaxX(self.staffF)+mar,self.titleF.origin.y , wid, departmentH);
    self.cellH = CellHMargin*2+maxH;
    
    
}

@end
