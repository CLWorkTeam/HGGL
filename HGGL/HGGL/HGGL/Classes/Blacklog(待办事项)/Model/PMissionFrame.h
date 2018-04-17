//
//  PMissionFrame.h
//  SYDX_2
//
//  Created by Lei on 15/9/11.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class MissonList;
@interface PMissionFrame : NSObject
@property (nonatomic,strong) MissonList *ML;
@property (nonatomic,assign) CGRect contentF;
@property (nonatomic,assign) CGFloat cellH;
@end
