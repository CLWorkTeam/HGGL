//
//  TKDownLoadModel.m
//  泰行销
//
//  Created by 陈磊 on 2018/1/18.
//  Copyright © 2018年 taikanglife. All rights reserved.
//

#import "TKDownLoadModel.h"

@interface TKDownLoadModel ()
@property (nonatomic,assign) NSInteger secondLength;
@property (nonatomic,strong) NSDate *currentDate;
@end
@implementation TKDownLoadModel
-(NSDate *)currentDate
{
    if (_currentDate == nil) {
        _currentDate = [NSDate date];
    }
    return _currentDate;
}
-(void)setCurrentSpeed:(NSInteger)currentSpeed
{
    _currentSpeed = currentSpeed;
    if ([[NSDate date] timeIntervalSinceDate:self.currentDate]>=1) {
        self.speed = [NSString stringWithFormat:@"%ld",(long)self.secondLength];
        self.currentDate = [NSDate date];
        self.secondLength = 0;
    }else
    {
        self.secondLength += currentSpeed;
    }
}
-(void)setSpeed:(NSString *)speed
{
    if ((([speed floatValue]/1024)<1024)&&(([speed floatValue]/1024)>=1)) {
        
        NSString *new = [NSString stringWithFormat:@"%.1fKB",[speed floatValue]/1024];
        if (![_speed isEqualToString:new]) {
            _speed = new;
        }
    }else if (([speed floatValue]/1024)>=1024)
    {
        NSString *new = [NSString stringWithFormat:@"%.1fMB",[speed floatValue]/(1024*1024)];
        if (![_speed isEqualToString:new]) {
            _speed = new;
        }
    }else
    {
        NSString *new = [NSString stringWithFormat:@"%.1fByte",[speed floatValue]];
        if (![_speed isEqualToString:new]) {
            _speed = new;
        }
    }
}
-(void)setCurrentLength:(long long)currentLength
{
    _currentLength = currentLength;
    if ((currentLength/(1024*1024))>=1024) {
        NSString *new = [NSString stringWithFormat:@"%.1fGB",(float)((currentLength/(1024*1024*1024)))];
        if (![_currentLengthStr isEqualToString:new]) {
            self.currentLengthStr = new;
        }
    }else if ((currentLength/(1024))<1)
    {
        NSString *new = [NSString stringWithFormat:@"%.1fByte",(float)((currentLength))];
        if (![_currentLengthStr isEqualToString:new]) {
            self.currentLengthStr = new;
        }
        
    }else if(((currentLength/(1024*1024))<1024)&&((currentLength/(1024*1024))>=1))
    {
        NSString *new = [NSString stringWithFormat:@"%.1fMB",(float)((currentLength/(1024*1024)))];
        
        if (![_currentLengthStr isEqualToString:new]) {
            self.currentLengthStr = new;
        }
    }else
    {
        NSString *new = [NSString stringWithFormat:@"%.1fKB",(float)((currentLength/1024))];
        if (![_currentLengthStr isEqualToString:new]) {
            self.currentLengthStr = new;
        }
    }
}
-(void)setTotalLength:(long long)totalLength
{
    _totalLength = totalLength;
    if ((totalLength/(1024*1024))>=1024) {
        NSString *new = [NSString stringWithFormat:@"%.1fGB",(float)((totalLength/(1024*1024*1024)))];
        if (![_totalLengthStr isEqualToString:new]) {
            self.totalLengthStr = new;
        }
    }else if ((totalLength/(1024))<1)
    {
        NSString *new = [NSString stringWithFormat:@"%.1fByte",(float)((totalLength ))];
        if (![_totalLengthStr isEqualToString:new]) {
            self.totalLengthStr = new;
        }
        
    }else if(((totalLength/(1024*1024))<1024)&&((totalLength/(1024*1024))>=1))
    {
        NSString *new = [NSString stringWithFormat:@"%.1fMB",(float)((totalLength/(1024*1024)))];
        if (![_totalLengthStr isEqualToString:new]) {
            self.totalLengthStr = new;
        }
    }else
    {
        NSString *new = [NSString stringWithFormat:@"%.1fKB",(float)((totalLength/(1024)))];
        if (![_totalLengthStr isEqualToString:new]) {
            self.totalLengthStr = new;
        }
    }
    
}
@end
