//
//  ZKRTextField.m
//  SYDX_2
//
//  Created by mac on 15-8-13.
//  Copyright (c) 2015年 sinosoft. All rights reserved.
//

#import "ZKRTextField.h"

@implementation ZKRTextField

-(CGRect)textRectForBounds:(CGRect)bounds
{
    
    return CGRectMake(80, 0,100, 100);
}
-(CGRect)placeholderRectForBounds:(CGRect)bounds
{
    
    return CGRectMake(5, 0, 75, 40);
}

@end
