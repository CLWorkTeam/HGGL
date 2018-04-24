//
//  HGSelfAdaptationBar.m
//  HGGL
//
//  Created by 陈磊 on 2018/4/17.
//  Copyright © 2018年 HGGL. All rights reserved.
//

#import "HGSelfAdaptationBar.h"
#define horMargin 20
#define horMar 20
@interface HGSelfAdaptationBar ()
@property (nonatomic,weak) UIButton *selectedButton;
@property (nonatomic,strong) NSMutableArray *imageArray;
@property (nonatomic,weak) UIScrollView *scroll;
@property (nonatomic,weak) UIView *contentView;//将所有控件都放在内容控件之中，那么就可以达到让内容控件自适应长度 然后设置内容控件的中心位置就行了
@property (nonatomic,weak) UIView *redLine;
@property (nonatomic,weak) UIView *grayLine;
@end
@implementation HGSelfAdaptationBar
-(NSMutableArray *)imageArray
{
    if (_imageArray == nil) {
        _imageArray = [NSMutableArray array];
    }
    return _imageArray;
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = [UIColor whiteColor];
        
        UIScrollView *scroll = [[UIScrollView alloc]init];
        //        scroll.backgroundColor = [UIColor redColor];
        //self.backgroundColor = [UIColor redColor];
        scroll.bounces = NO;
        //        scroll.scrollEnabled = NO;
        
        //不允许显示横向的滑轴
        scroll.showsHorizontalScrollIndicator = NO;
        //不允许显示钟祥的滑轴
        scroll.showsVerticalScrollIndicator = NO;
        //自动分页属性打开
        [self addSubview:scroll];
        self.scroll = scroll;
        UIView *contentView = [[UIView alloc]init];
        contentView.backgroundColor = [UIColor clearColor];
        self.contentView = contentView;
        [self.scroll addSubview:contentView];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = HGMainColor;
        self.redLine = line;
        //        line.frame = CGRectMake(space, toolsBar.height-1-HEIGHT_PT(4), width, HEIGHT_PT(4));
        [contentView addSubview:line];
        UIView *grayLine = [[UIView alloc]init];
        grayLine.backgroundColor = [UIColor colorWithHexString:@"#eeeeee"];
        //        grayLine.frame = CGRectMake(0, line.bottom, toolsBar.contentSize.width, 1);
        self.grayLine = grayLine;
        [scroll addSubview:grayLine];
        
    }
    return self;
}

-(void)setKeyArray:(NSArray *)keyArray
{
    _keyArray = keyArray;
    
    for (int i = 0; i<self.keyArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.tag = 400+i;
        [button setTitleColor:HGMainColor forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setTitle:self.keyArray[i] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(clickButton:) forControlEvents:UIControlEventTouchUpInside];
        button.titleLabel.font = [UIFont systemFontOfSize:HGFont];
        //        [button sizeToFit];
        //        if (i == 0) {
        //
        //            button.frame = CGRectMake(space+(space+width)*i, 0, (button.width>=width)?button.width:width, barHeight-0.3-HEIGHT_PT(4));
        //
        //        }else
        //        {
        //            UIButton *lastButton = self.buttonArray[i-1];
        //            button.frame = CGRectMake(lastButton.right+space, 0, (button.width>=width)?button.width:width, barHeight-0.3-HEIGHT_PT(4));
        //        }
        
        
        [self.contentView addSubview:button];
        [self.imageArray addObject:button];
        if (i == 0) {
            [self clickButton:button];
        }
        
    }
    [self layoutSubviews];
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.scroll.frame = CGRectMake(0, 0, self.width, self.height);
    
    CGFloat width = 0;
    
    CGFloat redLineH = 2;
    
    CGFloat grayLineH = 0.5;
    
    //    self.contentView.bounds = CGRectMake(0, 0, self.imageArray.count*width+(self.imageArray.count-1)*horMar, self.height);
    if ((self.contentView.width+2*horMargin) <= HGScreenWidth) {
        self.scroll.contentSize = CGSizeMake(HGScreenWidth, self.height);
        self.contentView.center = CGPointMake(HGScreenWidth/2, self.contentView.height/2);
    }else
    {
        self.scroll.contentSize = CGSizeMake(self.contentView.width+2*horMargin, self.height);
        self.contentView.center = CGPointMake((self.contentView.width)/2+horMargin, self.height);
        
    }
    
    for (int i = 0 ; i<self.imageArray.count; i++) {
        
        UIButton *button = (UIButton *)self.imageArray[i];
        
        [button sizeToFit];
        
        if (self.imageArray.count < self.minCount) {
            
            width = (HGScreenWidth - (self.imageArray.count-1)*horMar-2*horMargin)/self.imageArray.count;
            
            button.bounds = CGRectMake(0, 0, (width>=button.width)?button.width:width, self.height-redLineH-grayLineH);
            
            button.center = CGPointMake((horMar+width)*i+width/2, self.height/2);
            
            self.contentView.frame = CGRectMake(horMargin, 0, self.scroll.width-2*horMargin, self.height-redLineH-grayLineH);
            
            self.scroll.contentSize = CGSizeMake(self.contentView.width+2*horMargin, self.height);
            
            self.redLine.frame = CGRectMake(button.x, button.maxY, button.width, redLineH);
            
        }else
        {
            width = (HGScreenWidth - (self.minCount-1)*horMar-2*horMargin)/self.minCount;
            
            if (i == 0) {
                
                button.frame = CGRectMake((horMar+width)*i, 0, (button.width>=width)?button.width:width, self.height-redLineH-grayLineH);
                
                self.redLine.frame = CGRectMake(button.x, button.maxY, button.width, redLineH);
                
            }else
            {
                UIButton *lastButton = self.imageArray[i-1];
                
                button.frame = CGRectMake(lastButton.maxX+horMar, 0, (button.width>=width)?button.width:width, self.height-redLineH-grayLineH);
                
            }
            if (i == self.imageArray.count-1) {
                
                self.contentView.frame = CGRectMake(horMargin, 0, button.maxX, self.height-redLineH-grayLineH);
                self.scroll.contentSize = CGSizeMake(self.contentView.width+2*horMargin, self.height);
                //                self.scroll.contentSize = CGSizeMake(but.right, self.height);
            }
        }
        
        
        
        
    }
    
    
    self.grayLine.frame = CGRectMake(0, self.scroll.height-grayLineH, self.scroll.contentSize.width, grayLineH);
    
    
}

-(void)clickButton:(UIButton *)button
{
    if (button.tag == self.selectedButton.tag) {
        return;
    }
    //    [TalkingData trackEvent:@"首页导航" label:[NSString stringWithFormat:@"%@点播",self.arr[button.tag-400]]  parameters:@{@"liveId":self.arr[button.tag-400]}];
    self.selectedButton.selected = NO;
    button.selected = YES;
    self.selectedButton = button;
    NSInteger tag = button.tag - 400;
    //    UIButton *button = self.imageArray[tag];
    BOOL min = ((button.center.x+horMargin)>=(HGScreenWidth/2));
    BOOL max = ((self.contentView.width-button.center.x+horMargin)>=(HGScreenWidth/2));
    if (min&&max) {
        self.scroll.contentOffset = CGPointMake((button.center.x+horMargin-HGScreenWidth/2), 0);
    }else if (min&&(!max))
    {
        self.scroll.contentOffset = CGPointMake(self.scroll.contentSize.width-HGScreenWidth, 0);
    }else
    {
        self.scroll.contentOffset = CGPointMake(0, 0);
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.redLine.x = button.x;
        self.redLine.width = button.width;
    }];
    
    if (_clickButtonBlock) {
        _clickButtonBlock(tag);
    }
}
-(void)clickButtonWithTag:(NSInteger )tag
{
    UIButton *button = self.imageArray[tag];
    [self clickButton:button];
}
-(void)clickButtonWithOutBlock:(NSInteger)tag
{
    UIButton *button = self.imageArray[tag];
    
    self.selectedButton.selected = !self.selectedButton.selected;
    
    self.selectedButton = button;
    
    button.selected = YES;
    
    BOOL min = ((button.center.x+horMargin)>=(HGScreenWidth/2));
    BOOL max = ((self.contentView.width-button.center.x+horMargin)>=(HGScreenWidth/2));
    if (min&&max) {
        self.scroll.contentOffset = CGPointMake((button.center.x+horMargin-HGScreenWidth/2), 0);
    }else if (min&&(!max))
    {
        self.scroll.contentOffset = CGPointMake(self.scroll.contentSize.width-HGScreenWidth, 0);
    }else
    {
        self.scroll.contentOffset = CGPointMake(0, 0);
    }
    [UIView animateWithDuration:0.2 animations:^{
        self.redLine.x = button.x;
        self.redLine.width = button.width;
    }];
    
}


@end
