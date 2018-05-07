//
//  TKSelectView.m
//  泰行销
//
//  Created by edz on 2017/5/4.
//  Copyright © 2017年 taikanglife. All rights reserved.
//

#import "TKSelectView.h"
#import "TKSelectCell.h"

@interface TKSelectView ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableV;


@end

@implementation TKSelectView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init{
    
    if (self = [super init]) {
       
        self.backgroundColor = [UIColor clearColor];
        
        [self addBackgroundView];
        
    }
    return self;
}

- (void)addBackgroundView{
    
    UIView *backV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, HGScreenWidth, HGScreenHeight)];
    backV.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedCancel:)];
    [backV addGestureRecognizer:tapGesture];

    [self addSubview:backV];
}

-(void)setDataAry:(NSArray *)dataAry{
    
    if (_dataAry!=dataAry) {
        _dataAry = dataAry;
    }
    [self addTableV];
}

- (void)addTableV{
    
    CGFloat h ;
    if (_dataAry.count<6) { //渠道
        h = HEIGHT_PT(55) * _dataAry.count;
    }else{
        h = HEIGHT_PT(300);
    }
    
    UITableView *tableV = [[UITableView alloc]initWithFrame:CGRectMake(0, HGScreenHeight, HGScreenWidth, h) style:UITableViewStylePlain];
    tableV.separatorStyle = UITableViewCellSeparatorStyleNone;
    tableV.showsVerticalScrollIndicator = NO;
    tableV.dataSource = self;
    tableV.delegate = self;
    self.tableV = tableV ;
    [self addSubview:tableV];
    
    [UIView animateWithDuration:0.25 animations:^{
        tableV.frame = CGRectMake(0, HGScreenHeight - h, HGScreenWidth, h);
    }];
}


- (void)tappedCancel:(UITapGestureRecognizer *)tap
{
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.tableV setFrame:CGRectMake(0, HGScreenHeight, HGScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(didHiddenSelectView:)]) {
                [self.delegate didHiddenSelectView:self];
            }
            [self removeFromSuperview];
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return _dataAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *ID = @"cell";
    TKSelectCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        
        cell = [[TKSelectCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        UIView *lineV = [[UIView alloc]initWithFrame:CGRectMake(0, HEIGHT_PT(55)-HEIGHT_PT(1) , HGScreenWidth, HEIGHT_PT(1))];
        lineV.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        [cell.contentView addSubview:lineV];
    }
    
    cell.textLabel.text = _dataAry[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:FONT_PT(16)];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#333333"];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor colorWithHexString:@"#ef7800"];
    
    [UIView animateWithDuration:0.25 animations:^{
        
        [self.tableV setFrame:CGRectMake(0, HGScreenHeight, HGScreenWidth, 0)];
        self.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            if ([self.delegate respondsToSelector:@selector(didHiddenSelectView:)]) {
                [self.delegate didHiddenSelectView:self];
            }
            if ([self.delegate respondsToSelector:@selector(didSelectTableView:row:)]) {
                [self.delegate didSelectTableView:self row:indexPath.row];
            }
            [self removeFromSuperview];
        }
    }];

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return HEIGHT_PT(55);
}

@end
