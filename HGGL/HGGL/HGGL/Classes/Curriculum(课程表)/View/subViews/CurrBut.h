//
//  CurrBut.h
//  SYDX_2
//
//  Created by mac on 15-8-7.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CurrseList;
@interface CurrBut : UIButton
@property (nonatomic,strong) CurrseList *CL;
@property (nonatomic,copy)NSString *course_classroom;
@property (nonatomic,copy)NSString *teacher_id;
@end
