//
//  Common.h
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger, MSG) {
    //以下是枚举成员
    message = 0,
    sys  = 1,
    workFlow = 2,
    research = 3,
    report = 4,
    misson = 6
    
};
#define minH  [TextFrame frameOfText:@"备注:" With:[UIFont systemFontOfSize:ZKRFont] Andwidth:60].height
#define ZKRSpace 1
#define CellWMargin 15
#define CellHMargin 8
#define leftCellWidth 40
#define leftCellHeight 80
#define ZKRFont 14
@interface Common : NSObject

@end
